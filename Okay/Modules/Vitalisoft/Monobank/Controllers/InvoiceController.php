<?php

namespace Okay\Modules\Vitalisoft\Monobank\Controllers;

use Okay\Controllers\AbstractController;
use Okay\Core\Image;
use Okay\Core\Response;
use Okay\Core\Router;
use Okay\Entities\CurrenciesEntity;
use Okay\Entities\ImagesEntity;
use Okay\Entities\OrdersEntity;
use Okay\Entities\PaymentsEntity;
use Okay\Entities\ProductsEntity;
use Okay\Entities\PurchasesEntity;
use Okay\Modules\Vitalisoft\Monobank\Helpers\MonobankHelper;

class InvoiceController extends AbstractController
{
    public function createInvoice(
        MonobankHelper   $monobankHelper,
        OrdersEntity     $ordersEntity,
        PurchasesEntity  $purchasesEntity,
        ProductsEntity   $productsEntity,
        PaymentsEntity   $paymentsEntity,
        CurrenciesEntity $currenciesEntity,
        ImagesEntity     $imagesEntity,
        Image            $image,
                         $orderId
    )
    {
        $order = $ordersEntity->findOne(['id' => (int)$orderId]);
        $purchases = $purchasesEntity->find(['order_id' => (int)$orderId]);
        $paymentMethod = $paymentsEntity->findOne(['id' => $order->payment_method_id]);
        $paymentSettings = $paymentsEntity->getPaymentSettings($paymentMethod->id);
        $currency = $currenciesEntity->findOne(['id' => $paymentMethod->currency_id]);

        $purchasesData = [];
        foreach ($purchases as $purchase) {
            $product = $productsEntity->findOne(['id' => $purchase->product_id]);
            $iconUrl = null;
            if (!empty($product->main_image_id)) {
                $mainImage = $imagesEntity->findOne(['id' => $product->main_image_id]);
                $iconUrl = $image->getResizeModifier($mainImage->filename, 70, 70);
            }
            $purchasesData[] = [
                'name' => $purchase->product_name . ' ' . $purchase->variant_name,
                'qty' => (float)$purchase->amount,
                'sum' => $monobankHelper->convertToCents($purchase->price, $currency),
                'icon' => $iconUrl,
                'unit' => $purchase->units,
            ];
        }

        $url = $monobankHelper->createInvoice($paymentSettings['monobank_api_token'], [
            'amount' => $monobankHelper->convertToCents($order->total_price, $currency),
            'ccy' => $monobankHelper->getNumericCode($currency),
            'merchantPaymInfo' => [
                'reference' => $order->url,
                'destination' => "Оплата заказа #$order->id",
                'basketOrder' => $purchasesData,
            ],
            'redirectUrl' => Router::generateUrl('order', ['url' => $order->url], true),
            'webHookUrl' => Router::generateUrl('Vitalisoft_Monobank_callback', [], true),
            'paymentType' => 'debit',
        ]);
        if (!empty($url)) Response::redirectTo($url);
    }
}