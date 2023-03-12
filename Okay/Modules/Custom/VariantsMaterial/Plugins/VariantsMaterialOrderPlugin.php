<?php


namespace Okay\Modules\Custom\VariantsMaterial\Plugins;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\Custom\VariantsMaterial\Entities\MaterialAssociationsEntity;


class VariantsMaterialOrderPlugin extends Func
{
    protected $tag = 'get_order_purchases_material';

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

        $materialAssociations = $this->entityFactory->get(MaterialAssociationsEntity::class)->mappedBy('id')->find();
        $this->design->assign('material_associations', $materialAssociations);

        $this->design->assign('material_purchase', $purchase);
        return $this->design->fetch('order_purchases_material.tpl');
    }
}