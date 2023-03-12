<?php


namespace Okay\Modules\SimplaMarket\FacebookPixel\Init;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Settings;
use Okay\Helpers\OrdersHelper;
use Okay\Modules\SimplaMarket\FacebookPixel\Extenders\FrontendExtender;
use Okay\Core\OkayContainer\Reference\ServiceReference AS SR;

return [
    FrontendExtender::class => [
        'class' => FrontendExtender::class,
        'arguments' => [
            new SR(EntityFactory::class),
            new SR(Design::class),
            new SR(OrdersHelper::class),
            new SR(Settings::class),
        ]
    ],
];