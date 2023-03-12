<?php

namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Init;

use Okay\Admin\Helpers\BackendExportHelper;
use Okay\Admin\Helpers\BackendImportHelper;
use Okay\Admin\Helpers\BackendOrdersHelper;
use Okay\Admin\Helpers\BackendProductsHelper;
use Okay\Core\Cart;
use Okay\Core\Modules\EntityField;
use Okay\Core\Modules\AbstractInit;
use Okay\Entities\VariantsEntity;
use Okay\Helpers\OrdersHelper;
use Okay\Helpers\ProductsHelper;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Extenders\BackendExtender;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Extenders\FrontExtender;

class Init extends AbstractInit
{

    public function install()
    {
        $this->setBackendMainController('DescriptionAdmin');
        $this->migrateEntityField(VariantsEntity::class,  (new EntityField('color'))->setTypeInt(10));
        $this->migrateEntityField(VariantsEntity::class,  (new EntityField('size'))->setTypeInt(10));
		
	    $this->migrateEntityTable(ColorAssociationsEntity::class, [
		    (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
		    (new EntityField('name'))->setTypeVarchar(255)->setIsLang(),
		    (new EntityField('hex'))->setTypeVarchar(255),
		    (new EntityField('image'))->setTypeVarchar(255),
	    ]);
    }
    
    public function init()
    {
        $this->registerBackendController('DescriptionAdmin');
        $this->addBackendControllerPermission('DescriptionAdmin', 'simplamarket_variants_size_color');

        $this->registerBackendController('ColorAssociationsAdmin');
        $this->addBackendControllerPermission('ColorAssociationsAdmin', 'simplamarket_variants_size_color');

        $this->registerEntityField(VariantsEntity::class, 'color');
        $this->registerEntityField(VariantsEntity::class, 'size');

        $this->registerQueueExtension(
            ['class' => BackendProductsHelper::class, 'method' => 'getProduct'],
            ['class' => BackendExtender::class, 'method' => 'getProduct']
        );

        $this->registerQueueExtension(
            ['class' => BackendOrdersHelper::class, 'method' => 'findOrder'],
            ['class' => BackendExtender::class, 'method' => 'findOrder']
        );

        $this->registerChainExtension(
            ['class' => ProductsHelper::class, 'method' => 'attachVariants'],
            ['class' => FrontExtender::class, 'method' => 'attachVariants']
        );

        $this->registerChainExtension(
            ['class' => OrdersHelper::class, 'method' => 'getOrderPurchasesList'],
            ['class' => FrontExtender::class, 'method' => 'getOrderPurchasesList']
        );

        $this->registerChainExtension(
            ['class' => Cart::class, 'method' => 'get'],
            ['class' => FrontExtender::class, 'method' => 'getCart']
        );

	    // Добавляемся в импорт
	    $this->addBackendBlock('import_fields_association', 'import_fields_association.tpl');
		
	    $this->registerChainExtension(
		    [BackendImportHelper::class, 'parseVariantData'],
		    [BackendExtender::class, 'parseVariantData']
	    );

	    $this->registerChainExtension(
		    [BackendExportHelper::class, 'getColumnsNames'],
		    [BackendExtender::class, 'extendExportColumnsNames']
	    );

	    $this->registerChainExtension(
		    [BackendExportHelper::class, 'prepareVariantsData'],
		    [BackendExtender::class, 'extendExportPrepareVariantData']
	    );

        $this->extendBackendMenu('left_settings', [
            'left_variant_color_settings' => ['ColorAssociationsAdmin'],
        ]);

        $this->addBackendBlock('product_variant', 'variant_size_color.tpl');
        $this->addBackendBlock('order_variant_color', 'order_variant_size_color.tpl');

    }
}