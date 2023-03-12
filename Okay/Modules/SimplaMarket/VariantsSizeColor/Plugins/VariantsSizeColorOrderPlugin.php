<?php


namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Plugins;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;


class VariantsSizeColorOrderPlugin extends Func
{
    protected $tag = 'get_order_purchases_color';

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

        $colorAssociations = $this->entityFactory->get(ColorAssociationsEntity::class)->mappedBy('id')->find();
        $this->design->assign('color_associations', $colorAssociations);
	    $this->design->assign('color_dir', '/files/originals/colors/');

        $this->design->assign('color_purchase', $purchase);
        return $this->design->fetch('order_purchases_color.tpl');
    }
}