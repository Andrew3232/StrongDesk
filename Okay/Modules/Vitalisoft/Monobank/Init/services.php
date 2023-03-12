<?php

namespace Okay\Modules\Vitalisoft\Monobank;

use Okay\Core\OkayContainer\Reference\ServiceReference;
use Okay\Modules\Vitalisoft\Monobank\Helpers\MonobankHelper;
use Psr\Log\LoggerInterface;

return [
    PaymentForm::class => [
        'class' => PaymentForm::class
    ],
    MonobankHelper::class => [
        'class' => MonobankHelper::class,
        'arguments' => [
            new ServiceReference(LoggerInterface::class)
        ]
    ]
];