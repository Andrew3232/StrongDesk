<?php


namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Extenders;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtenderFacade;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;

class BackendExtender implements ExtensionInterface
{
    private $colorAssociationsEntity;
    private $design;

    public function __construct(EntityFactory $entityFactory, Design $design)
    {
        $this->colorAssociationsEntity = $entityFactory->get(ColorAssociationsEntity::class);
        $this->design = $design;
    }

    public function getProduct()
    {
        $colorAssociations = $this->colorAssociationsEntity->mappedBy('id')->find();
        $this->design->assign('color_associations', $colorAssociations);
    }

    public function findOrder()
    {
        $colorAssociations = $this->colorAssociationsEntity->mappedBy('id')->find();
        $this->design->assign('color_associations', $colorAssociations);
    }

	public function parseVariantData($variant, $itemFromCsv)
	{
		if (isset($itemFromCsv['color'])) {
			$variant['color'] = trim($itemFromCsv['color']);
		}
		if (isset($itemFromCsv['size'])) {
			$variant['size'] = trim($itemFromCsv['size']);
		}

		return ExtenderFacade::execute(__METHOD__, $variant, func_get_args());
	}

	public function extendExportColumnsNames($columnsNames)
	{
		$columnsNames['color'] = 'color';
		$columnsNames['size'] = 'size';

		return ExtenderFacade::execute(__METHOD__, $columnsNames, func_get_args());
	}

	public function extendExportPrepareVariantData($preparedVariantData, $variant)
	{
		$preparedVariantData['color'] = $variant->color;
		$preparedVariantData['size'] = $variant->size;

		return ExtenderFacade::execute(__METHOD__, $preparedVariantData, func_get_args());
	}
}