<?php

namespace Okay\Modules\Custom\VariantsShape\Extenders;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtenderFacade;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\Custom\VariantsShape\Entities\ShapeAssociationsEntity;

class BackendExtender implements ExtensionInterface
{
    private $shapeAssociationsEntity;
    private $design;

    public function __construct(EntityFactory $entityFactory, Design $design)
    {
        $this->shapeAssociationsEntity = $entityFactory->get(ShapeAssociationsEntity::class);
        $this->design = $design;
    }

    public function getProduct()
    {
        $shapeAssociations = $this->shapeAssociationsEntity->find();
        $this->design->assign('shape_associations', $shapeAssociations);
    }

    public function findOrder()
    {
        $shapeAssociations = $this->shapeAssociationsEntity->mappedBy('id')->find();
        $this->design->assign('shape_associations', $shapeAssociations);
    }
	
	public function parseVariantData($variant, $itemFromCsv)
	{
		if (isset($itemFromCsv['shape'])) {
			$variant['shape'] = trim($itemFromCsv['shape']);
		}
		return ExtenderFacade::execute(__METHOD__, $variant, func_get_args());
	}

	public function extendExportColumnsNames($columnsNames)
	{
		$columnsNames['shape'] = 'shape';

		return ExtenderFacade::execute(__METHOD__, $columnsNames, func_get_args());
	}

	public function extendExportPrepareVariantData($preparedVariantData, $variant)
	{
		$preparedVariantData['shape'] = $variant->shape;

		return ExtenderFacade::execute(__METHOD__, $preparedVariantData, func_get_args());
	}
}