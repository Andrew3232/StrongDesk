<?php

namespace Okay\Modules\Custom\VariantsShape\Init;

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
use Okay\Modules\Custom\VariantsShape\Entities\ShapeAssociationsEntity;
use Okay\Modules\Custom\VariantsShape\Extenders\BackendExtender;
use Okay\Modules\Custom\VariantsShape\Extenders\FrontExtender;

class Init extends AbstractInit
{
    const PERMISSION = 'features';

    public function install()
    {
        $this->setBackendMainController('ModuleAdmin');
        $this->migrateEntityField(VariantsEntity::class,  (new EntityField('shape'))->setTypeInt(10));

	    $this->migrateEntityTable(ShapeAssociationsEntity::class, [
		    (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
		    (new EntityField('name'))->setTypeVarchar(255)->setIsLang(),
	    ]);
    }
    
    public function init()
    {
        $this->addPermission(self::PERMISSION);

        $this->registerBackendController('ModuleAdmin');
        $this->addBackendControllerPermission('ModuleAdmin', self::PERMISSION);

        $this->registerBackendController('ShapeAssociationsAdmin');
        $this->addBackendControllerPermission('ShapeAssociationsAdmin', self::PERMISSION);

        $this->registerEntityField(VariantsEntity::class, 'shape');

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
            'left_variant_shape_settings' => ['ShapeAssociationsAdmin'],
        ]);

        $this->addBackendBlock('product_variant', 'variant_shape.tpl');
        $this->addBackendBlock('order_variant_shape', 'order_variant_shape.tpl');
    }
}