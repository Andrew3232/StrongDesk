<?php


namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Plugins;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;


class VariantsSizeColorCartPlugin extends Func
{
    protected $tag = 'get_cart_purchases_color';

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
        $this->design->assign('color_purchase', $purchase);
        $this->design->assign('color_dir', '/files/originals/colors/');
        return $this->design->fetch('cart_purchases_color.tpl');

    }
}