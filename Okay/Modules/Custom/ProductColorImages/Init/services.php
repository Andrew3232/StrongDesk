<?php

namespace Okay\Modules\Custom\ProductColorImages;

use Okay\Core\Config;
use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Image;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;
use Okay\Core\Request;
use Okay\Modules\Custom\ProductColorImages\Extenders\BackendExtender;
use Okay\Modules\Custom\ProductColorImages\Extenders\FrontExtender;

return [
    BackendExtender::class => [
        'class' => BackendExtender::class,
        'arguments' => [
            new SR(EntityFactory::class),
            new SR(Design::class),
            new SR(Request::class),
            new SR(Image::class),
            new SR(Config::class),
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