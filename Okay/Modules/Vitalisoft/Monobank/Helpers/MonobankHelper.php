<?php

namespace Okay\Modules\Vitalisoft\Monobank\Helpers;

use Okay\Core\Modules\Extender\ExtenderFacade;
use Psr\Log\LoggerInterface;

class MonobankHelper
{
    /** @var LoggerInterface */
    private $logger;

    public function __construct(
        LoggerInterface $logger
    )
    {
        $this->logger = $logger;
    }

    public function convertToCents($sum, $currency): int
    {
        $result = (int)round($sum * 100 * $currency->rate_from / $currency->rate_to);
        return ExtenderFacade::execute(__METHOD__, $result, func_get_args());
    }

    public function getNumericCode($currency): int
    {
        $result = [
            'UAH' => 980,
            'USD' => 940,
            'EUR' => 978,
            'RUB' => 643,
        ][$currency->code];
        return ExtenderFacade::execute(__METHOD__, $result, func_get_args());
    }


    public function createInvoice($apiToken, array $body)
    {
        $ch = curl_init();
        curl_setopt_array($ch, [
            CURLOPT_URL => 'https://api.monobank.ua/api/merchant/invoice/create',
            CURLOPT_POST => true,
            CURLOPT_HTTPHEADER => [
                'Content-Type: application/json',
                "X-Token: $apiToken",
            ],
            CURLOPT_POSTFIELDS => json_encode($body),
            CURLOPT_RETURNTRANSFER => true,
        ]);
        $result = json_decode(curl_exec($ch), true);
        $success = curl_getinfo($ch, CURLINFO_RESPONSE_CODE) == 200;
        curl_close($ch);
        if ($success) {
            $result = $result['pageUrl'];
        } else {
            $this->logger->warning('Monobank notice: ' . $result['errText']);
            $result = null;
        }
        return ExtenderFacade::execute(__METHOD__, $result, func_get_args());
    }

    public function getPublicKey($apiToken)
    {
        $ch = curl_init();
        curl_setopt_array($ch, [
            CURLOPT_URL => 'https://api.monobank.ua/api/merchant/pubkey',
            CURLOPT_HTTPHEADER => ["X-Token: $apiToken"],
            CURLOPT_RETURNTRANSFER => true,
        ]);
        $result = json_decode(curl_exec($ch), true);
        $success = curl_getinfo($ch, CURLINFO_RESPONSE_CODE) == 200;
        curl_close($ch);
        if ($success) {
            $result = base64_decode($result['key']);
        } else {
            $this->logger->warning('Monobank notice: ' . $result['errText']);
            $result = null;
        }
        return ExtenderFacade::execute(__METHOD__, $result, func_get_args());
    }

    public function getInvoiceDetails($apiToken, $invoiceId)
    {
        $ch = curl_init();
        curl_setopt_array($ch, [
            CURLOPT_URL => "https://api.monobank.ua/api/merchant/invoice/payment-info?invoiceId=$invoiceId",
            CURLOPT_HTTPHEADER => ["X-Token: $apiToken"],
            CURLOPT_RETURNTRANSFER => true,
        ]);
        $result = json_decode(curl_exec($ch), true);
        $success = curl_getinfo($ch, CURLINFO_RESPONSE_CODE) == 200;
        curl_close($ch);
        if (!$success) {
            $this->logger->warning('Monobank notice: ' . $result['errText']);
            $result = null;
        }
        return ExtenderFacade::execute(__METHOD__, $result, func_get_args());
    }
}