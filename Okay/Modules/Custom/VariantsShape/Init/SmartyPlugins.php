<?php


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Modules\Custom\VariantsShape\Plugins\VariantsShapePlugin;
use Okay\Modules\Custom\VariantsShape\Plugins\VariantsShapeCartPlugin;
use Okay\Modules\Custom\VariantsShape\Plugins\VariantsShapeOrderPlugin;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;

return [
	VariantsShapePlugin::class => [
		'class' => VariantsShapePlugin::class,
		'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
	VariantsShapeCartPlugin::class => [
		'class' => VariantsShapeCartPlugin::class,
		'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
	VariantsShapeOrderPlugin::class => [
		'class' => VariantsShapeOrderPlugin::class,
		'arguments' => [
            new SR(Design::class),
            new SR(EntityFactory::class),
        ],
    ],
];