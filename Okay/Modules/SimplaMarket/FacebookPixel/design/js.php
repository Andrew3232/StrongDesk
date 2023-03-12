<?php

use Okay\Core\TemplateConfig\Js;
use Okay\Core\Router;

if (Router::getCurrentRouteName() == 'cart') {
return [new Js('order.js')];
}
return [
    new Js('facebook_pixel.js'),
];
