<?php


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Modules\Custom\VariantsMaterial\Plugins\VariantsMaterialPlugin;
use Okay\Modules\Custom\VariantsMaterial\Plugins\VariantsMaterialCartPlugin;
use Okay\Modules\Custom\VariantsMaterial\Plugins\VariantsMaterialOrderPlugin;
use Okay\Core\OkayContainer\Reference\ParameterReference as PR;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;

return [
    VariantsMaterialPlugin::class => [
        'class' => VariantsMaterialPlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
    VariantsMaterialCartPlugin::class => [
        'class' => VariantsMaterialCartPlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
    VariantsMaterialOrderPlugin::class => [
        'class' => VariantsMaterialOrderPlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
];