<?php

namespace Okay\Modules\Custom\VariantsShape\Plugins;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\Custom\VariantsShape\Entities\ShapeAssociationsEntity;

class VariantsShapePlugin extends Func
{
    protected $tag = 'get_variants_shape';

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

        $shapeAssociations = $this->entityFactory->get(ShapeAssociationsEntity::class)->mappedBy('id')->find();
        $this->design->assign('shape_associations', $shapeAssociations);

        if ($vars['type'] == 'product_list') {
            $this->design->assign('product_shape', $product);
            return $this->design->fetch('variants_shape_list.tpl');
        }

        return $this->design->fetch('variants_shape.tpl');

    }
}