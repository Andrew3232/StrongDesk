<?php


namespace Okay\Modules\Custom\VariantsShape\Plugins;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\Custom\VariantsShape\Entities\ShapeAssociationsEntity;


class VariantsShapeOrderPlugin extends Func
{
	protected $tag = 'get_order_purchases_shape';

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

		$shapeAssociations = $this->entityFactory->get(ShapeAssociationsEntity::class)->mappedBy('id')->find();
		$this->design->assign('shape_associations', $shapeAssociations);

		$this->design->assign('shape_purchase', $purchase);

		return $this->design->fetch('order_purchases_shape.tpl');
	}
}