<?php

namespace Okay\Modules\Custom\ProductColorImages\Init;

use Okay\Admin\Helpers\BackendExportHelper;
use Okay\Admin\Helpers\BackendImportHelper;
use Okay\Admin\Helpers\BackendOrdersHelper;
use Okay\Admin\Helpers\BackendProductsHelper;
use Okay\Core\Cart;
use Okay\Core\Modules\EntityField;
use Okay\Core\Modules\AbstractInit;
use Okay\Helpers\OrdersHelper;
use Okay\Helpers\ProductsHelper;
use Okay\Modules\Custom\ProductColorImages\Entities\ProductColorImagesEntity;
use Okay\Modules\Custom\ProductColorImages\Extenders\BackendExtender;
use Okay\Modules\Custom\ProductColorImages\Extenders\FrontExtender;

class Init extends AbstractInit
{
    const PERMISSION = 'product_color_image';

    public function install()
    {
		if(!is_dir('files/originals/product_color_images/'))
		{
			mkdir('files/originals/product_color_images/');
		}

		if(!is_dir('files/resized/product_color_images/'))
		{
			mkdir('files/resized/product_color_images/');
		}

        $this->setBackendMainController('ModuleAdmin');

	    $this->migrateEntityTable(ProductColorImagesEntity::class, [
		    (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
		    (new EntityField('color_id'))->setTypeInt(10),
		    (new EntityField('product_id'))->setTypeInt(10),
		    (new EntityField('filename'))->setTypeVarchar(255),
	    ]);
	}

    public function init()
    {
        $this->addPermission(self::PERMISSION);

        $this->registerBackendController('ModuleAdmin');
        $this->addBackendControllerPermission('ModuleAdmin', self::PERMISSION);

        $this->registerQueueExtension(
            ['class' => BackendProductsHelper::class, 'method' => 'getProduct'],
            ['class' => BackendExtender::class, 'method' => 'getProduct']
        );

        $this->registerQueueExtension(
            ['class' => BackendProductsHelper::class, 'method' => 'updateSpecialImages'],
            ['class' => BackendExtender::class, 'method' => 'uploadProductColorImage']
        );

	    $this->addResizeObject('original_product_color_images_dir', 'resized_product_color_images_dir');
//
//        $this->registerChainExtension(
//            ['class' => ProductsHelper::class, 'method' => 'attachVariants'],
//            ['class' => FrontExtender::class, 'method' => 'attachVariants']
//        );
//
//        $this->registerChainExtension(
//            ['class' => OrdersHelper::class, 'method' => 'getOrderPurchasesList'],
//            ['class' => FrontExtender::class, 'method' => 'getOrderPurchasesList']
//        );
//
//        $this->registerChainExtension(
//            ['class' => Cart::class, 'method' => 'get'],
//            ['class' => FrontExtender::class, 'method' => 'getCart']
//        );

	    // Добавляемся в импорт
//	    $this->addBackendBlock('import_fields_association', 'import_fields_association.tpl');
//
//	    $this->registerQueueExtension(
//		    [BackendImportHelper::class, 'parseProductData'],
//		    [BackendExtender::class, 'parseProductData']
//	    );
//
//	    $this->registerChainExtension(
//		    [BackendImportHelper::class, 'parseVariantData'],
//		    [BackendExtender::class, 'parseVariantData']
//	    );
//
//	    $this->registerChainExtension(
//		    [BackendExportHelper::class, 'getColumnsNames'],
//		    [BackendExtender::class, 'getColumnsNames']
//	    );
//
//	    $this->registerChainExtension(
//		    [BackendExportHelper::class, 'prepareVariantsData'],
//		    [BackendExtender::class, 'prepareVariantsData']
//	    );
//
//        $this->addBackendBlock('product_variant', 'variant_material.tpl');
//        $this->addBackendBlock('order_variant_material', 'order_variant_material.tpl');
    }
}