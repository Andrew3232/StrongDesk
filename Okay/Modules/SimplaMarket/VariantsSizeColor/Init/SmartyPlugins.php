<?php


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Plugins\VariantsSizeColorPlugin;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Plugins\VariantsSizeColorCartPlugin;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Plugins\VariantsSizeColorOrderPlugin;
use Okay\Core\OkayContainer\Reference\ParameterReference as PR;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;

return [
    VariantsSizeColorPlugin::class => [
        'class' => VariantsSizeColorPlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
    VariantsSizeColorCartPlugin::class => [
        'class' => VariantsSizeColorCartPlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
    VariantsSizeColorOrderPlugin::class => [
        'class' => VariantsSizeColorOrderPlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
];