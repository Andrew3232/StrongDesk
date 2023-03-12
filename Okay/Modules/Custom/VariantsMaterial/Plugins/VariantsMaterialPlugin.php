<?php


namespace Okay\Modules\Custom\VariantsMaterial\Plugins;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\Custom\VariantsMaterial\Entities\MaterialAssociationsEntity;


class VariantsMaterialPlugin extends Func
{
    protected $tag = 'get_variants_material';

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

        $materialAssociations = $this->entityFactory->get(MaterialAssociationsEntity::class)->mappedBy('id')->find();
        $this->design->assign('material_associations', $materialAssociations);

        if ($vars['type'] == 'product_list') {
            $this->design->assign('product_material', $product);
            return $this->design->fetch('variants_material_list.tpl');
        }

        return $this->design->fetch('variants_material.tpl');

    }
}