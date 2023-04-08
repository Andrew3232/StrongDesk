<?php

namespace Okay\Modules\Custom\ProductColorImages\Extenders;

use Okay\Core\Config;
use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Image;
use Okay\Core\Modules\Extender\ExtenderFacade;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Core\Request;
use Okay\Entities\VariantsEntity;
use Okay\Modules\Custom\ProductColorImages\Entities\ProductColorImagesEntity;

class BackendExtender implements ExtensionInterface
{
    private $productColorImagesEntity;
    private $variantsEntity;
    private $design;
	private $request;
	private $imageCore;
	private $entityFactory;
	private $config;

	public function __construct(EntityFactory $entityFactory, Design $design, Request $request, Image $imageCore, Config $config)
    {
	    $this->entityFactory = $entityFactory;
	    $this->productColorImagesEntity = $this->entityFactory->get(ProductColorImagesEntity::class);
	    $this->variantsEntity = $this->entityFactory->get(VariantsEntity::class);
	    $this->design = $design;
	    $this->request = $request;
	    $this->imageCore = $imageCore;
	    $this->config = $config;
    }

    public function getProduct($product)
    {
		$colors = $this->variantsEntity->cols(['id','color','product_id'])->mappedBy('color')->find(['product_id' => $product->id]);
        $productColorImages = $this->productColorImagesEntity->mappedBy('color_id')->find(['product_id' => $product->id]);
        $this->design->assign('product_color_images', $productColorImages);
        $this->design->assign('product_colors', $colors);
    }

	public function uploadProductColorImage($null, $product, $specialImages, $specDroppedImages)
	{
		if($this->request->post('delete_color_image'))
		{
			$deleteColorImages = array_filter($this->request->post('delete_color_image'));

			foreach(array_keys($deleteColorImages) as $productColor)
			{
				$productColorImage = $this->productColorImagesEntity->findOne([
					'product_id' => $product->id,
					'color_id' => $productColor
				]);

				$this->imageCore->deleteImage(
					$productColorImage->id,
					'filename',
					ProductColorImagesEntity::class,
					$this->config->get('original_product_color_images_dir'),
					$this->config->get('resized_product_color_images_dir')
				);

				$this->productColorImagesEntity->delete($productColorImage->id);
			}
		}

		$productColorImages = $this->request->files('color_image');
		$names = array_filter($productColorImages['name']);
		$tmpNames = array_filter($productColorImages['tmp_name']);
		$colorsId = array_keys($names);

		$productColorImages = array_map(function ($name, $tmpName, $color){
			return [
				'name' => $name,
				'tmp_name' => $tmpName,
				'color_id' => $color,
			];
		}, $names, $tmpNames, $colorsId);

		foreach($productColorImages as $productColorImage){
			if ($productColorImage['name'] && $filename = $this->imageCore->uploadImage($productColorImage['tmp_name'], $productColorImage['name'], $this->config->get('original_product_color_images_dir'))) {
				$image = new \stdClass();
				$image->product_id = $product->id;
				$image->color_id = $productColorImage['color_id'];
				$image->filename = $filename;
				$this->productColorImagesEntity->add($image);
			}
		}

		ExtenderFacade::execute(__METHOD__, null, func_get_args());
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