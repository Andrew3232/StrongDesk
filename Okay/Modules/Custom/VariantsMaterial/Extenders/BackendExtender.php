<?php

namespace Okay\Modules\Custom\VariantsMaterial\Extenders;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtenderFacade;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\Custom\VariantsMaterial\Entities\MaterialAssociationsEntity;

class BackendExtender implements ExtensionInterface
{
    private $materialAssociationsEntity;
    private $design;

    public function __construct(EntityFactory $entityFactory, Design $design)
    {
        $this->materialAssociationsEntity = $entityFactory->get(MaterialAssociationsEntity::class);
        $this->design = $design;
    }

    public function getProduct()
    {
        $materialAssociations = $this->materialAssociationsEntity->find();
        $this->design->assign('material_associations', $materialAssociations);
    }

    public function findOrder()
    {
        $materialAssociations = $this->materialAssociationsEntity->mappedBy('id')->find();
        $this->design->assign('material_associations', $materialAssociations);
    }

	private function parseProductData($product, $itemFromCsv)
	{
		if (isset($itemFromCsv['productid'])) {
			$itemFromCsv['id'] = trim($itemFromCsv['productid']);
		}

		return ExtenderFacade::execute(__METHOD__, $itemFromCsv, func_get_args());
	}

	public function parseVariantData($variant, $itemFromCsv)
	{
		if (isset($itemFromCsv['material'])) {
			$variant['material'] = trim($itemFromCsv['material']);
		}
		return ExtenderFacade::execute(__METHOD__, $variant, func_get_args());
	}

	public function getColumnsNames($columnsNames)
	{
		$columnsNames['id'] = 'productId';
		$columnsNames['material'] = 'material';

		return ExtenderFacade::execute(__METHOD__, $columnsNames, func_get_args());
	}

	public function prepareVariantsData($preparedVariantData, $variant)
	{
		$preparedVariantData['material'] = $variant->material;
		$preparedVariantData['id'] = $variant->product_id;

		return ExtenderFacade::execute(__METHOD__, $preparedVariantData, func_get_args());
	}
}