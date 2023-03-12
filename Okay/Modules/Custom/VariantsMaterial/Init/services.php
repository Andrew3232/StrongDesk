<?php


namespace Okay\Modules\Custom\VariantsMaterial;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;
use Okay\Modules\Custom\VariantsMaterial\Extenders\BackendExtender;
use Okay\Modules\Custom\VariantsMaterial\Extenders\FrontExtender;

return [
    BackendExtender::class => [
        'class' => BackendExtender::class,
        'arguments' => [
            new SR(EntityFactory::class),
            new SR(Design::class),
        ],
    ],

    FrontExtender::class => [
        'class' => FrontExtender::class,
        'arguments' => [
            new SR(EntityFactory::class),
            new SR(Design::class),
        ],
    ],

];