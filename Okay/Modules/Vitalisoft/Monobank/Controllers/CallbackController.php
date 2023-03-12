<?php

namespace Okay\Modules\Vitalisoft\Monobank\Controllers;

use Okay\Controllers\AbstractController;
use Okay\Core\Notify;
use Okay\Entities\CurrenciesEntity;
use Okay\Entities\OrderHistoryEntity;
use Okay\Entities\OrdersEntity;
use Okay\Entities\PaymentsEntity;
use Okay\Modules\Vitalisoft\Monobank\Helpers\MonobankHelper;
use Psr\Log\LoggerInterface;

class CallbackController extends AbstractController
{
    public function payOrder(
        LoggerInterface    $logger,
        MonobankHelper     $monobankHelper,
        OrdersEntity       $ordersEntity,
        PaymentsEntity     $paymentsEntity,
        CurrenciesEntity   $currenciesEntity,
        OrderHistoryEntity $orderHistoryEntity,
        Notify             $notify
    )
    {
        $body = $this->request->post();
        $data = json_decode($body, true);
        if ($data['status'] != 'success') exit;

        $order = $ordersEntity->findOne(['url' => $data['reference']]);
        $paymentMethod = $paymentsEntity->findOne(['id' => $order->payment_method_id]);
        $paymentSettings = $paymentsEntity->getPaymentSettings($paymentMethod->id);
        $currency = $currenciesEntity->findOne(['id' => $paymentMethod->currency_id]);
        $apiToken = $paymentSettings['monobank_api_token'];

        $sign = base64_decode($_SERVER['HTTP_X_SIGN']);
        $key = $monobankHelper->getPublicKey($apiToken);

        if (!openssl_verify($body, $sign, $key, OPENSSL_ALGO_SHA256)) {
            $logger->warning('Monobank notice: Invalid signature: "' . base64_encode($sign) . '". Request body:\n' . $body);
            exit;
        }

        if ($data['amount'] != $monobankHelper->convertToCents($order->total_price, $currency)) {
            $logger->warning('Monobank notice: Invalid amount. Request body:\n' . $body);
            exit;
        }

        if ($data['ccy'] != $monobankHelper->getNumericCode($currency)) {
            $logger->warning('Monobank notice: Invalid currency. Request body:\n' . $body);
            exit;
        }

        $ordersEntity->update((int)$order->id, ['paid' => 1]);
        $ordersEntity->close((int)$order->id);
        $notify->emailOrderUser((int)$order->id);
        $notify->emailOrderAdmin((int)$order->id);

        $details = $monobankHelper->getInvoiceDetails($apiToken, $data['invoiceId']);
        if (!empty($details)) {
            $orderHistoryText = implode('<br>', [
                'Monobank payment details',
                'Masked card number: ' . $details['maskedPan'],
                'Reference Retrieval Number: ' . $details['rrn'],
                'Payment scheme: ' . $details['paymentScheme'],
                'Payment method: ' . $details['paymentMethod'],
                'Fee: ' . (!empty($details['fee']) ? $details['fee'] : 'Not specified'),
                'Domestic card: ' . ($details['domesticCard'] ? 'Yes' : 'No'),
                'Country ISO-3166-1: ' . $details['country']
            ]);
            $orderHistoryEntity->add([
                'order_id' => (int)$order->id,
                'manager_id' => null,
                'text' => $orderHistoryText
            ]);
        }
    }
}