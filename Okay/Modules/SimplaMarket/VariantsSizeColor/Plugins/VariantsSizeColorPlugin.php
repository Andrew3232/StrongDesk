<?php


namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Plugins;


use Okay\Core\Config;
use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;


class VariantsSizeColorPlugin extends Func
{
    protected $tag = 'get_variants_size_color';

    protected $design;
    protected $entityFactory;

    public function __construct(Design $design, EntityFactory $entityFactory)
    {
        $this->design = $design;
        $this->entityFactory = $entityFactory;
    }

    public function run($vars)
    {
        $product = $vars['product'];

        $colorAssociations = $this->entityFactory->get(ColorAssociationsEntity::class)->mappedBy('id')->find();
        $this->design->assign('color_associations', $colorAssociations);
	    $this->design->assign('color_dir', '/files/originals/colors/');

        if ($vars['type'] == 'product_list') {
            $this->design->assign('product_size_color', $product);
            return $this->design->fetch('variants_size_color_list.tpl');
        }

        return $this->design->fetch('variants_size_color.tpl');

    }
}