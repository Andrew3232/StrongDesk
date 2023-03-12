<?php

namespace Okay\Modules\Custom\VariantsShape\Plugins;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;

class VariantsShapeCartPlugin extends Func
{
    protected $tag = 'get_cart_purchases_shape';

    protected $design;
    protected $entityFactory;

    public function __construct(Design $design, EntityFactory $entityFactory)
    {
        $this->design = $design;
        $this->entityFactory = $entityFactory;
    }

    public function run($vars)
    {
        $purchase = $vars['purchase'];
        $this->design->assign('shape_purchase', $purchase);
        return $this->design->fetch('cart_purchases_shape.tpl');

    }
}