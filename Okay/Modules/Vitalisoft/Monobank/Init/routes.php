<?php

namespace Okay\Modules\Vitalisoft\Monobank;

return [
    'Vitalisoft_Monobank_callback' => [
        'slug' => 'payment/Vitalisoft/Monobank/callback',
        'params' => [
            'controller' => __NAMESPACE__ . '\Controllers\CallbackController',
            'method' => 'payOrder',
        ],
    ],
    'Vitalisoft_Monobank_invoice' => [
        'slug' => 'payment/Vitalisoft/Monobank/invoice/create/{$orderId}',
        'params' => [
            'controller' => __NAMESPACE__ . '\Controllers\InvoiceController',
            'method' => 'createInvoice',
        ],
    ],
];