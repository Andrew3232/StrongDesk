<?php

namespace Okay\Modules\Custom\VariantsMaterial\Init;

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
use Okay\Modules\Custom\VariantsMaterial\Entities\MaterialAssociationsEntity;
use Okay\Modules\Custom\VariantsMaterial\Extenders\BackendExtender;
use Okay\Modules\Custom\VariantsMaterial\Extenders\FrontExtender;

class Init extends AbstractInit
{
    const PERMISSION = 'features';

    public function install()
    {
        $this->setBackendMainController('ModuleAdmin');
        $this->migrateEntityField(VariantsEntity::class,  (new EntityField('material'))->setTypeInt(10));

	    $this->migrateEntityTable(MaterialAssociationsEntity::class, [
		    (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
		    (new EntityField('name'))->setTypeVarchar(255)->setIsLang(),
	    ]);
	}
    
    public function init()
    {
        $this->addPermission(self::PERMISSION);

        $this->registerBackendController('ModuleAdmin');
        $this->addBackendControllerPermission('ModuleAdmin', self::PERMISSION);

        $this->registerBackendController('MaterialAssociationsAdmin');
        $this->addBackendControllerPermission('MaterialAssociationsAdmin', self::PERMISSION);

        $this->registerEntityField(VariantsEntity::class, 'material');

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

	    $this->registerQueueExtension(
		    [BackendImportHelper::class, 'parseProductData'],
		    [BackendExtender::class, 'parseProductData']
	    );

	    $this->registerChainExtension(
		    [BackendImportHelper::class, 'parseVariantData'],
		    [BackendExtender::class, 'parseVariantData']
	    );

	    $this->registerChainExtension(
		    [BackendExportHelper::class, 'getColumnsNames'],
		    [BackendExtender::class, 'getColumnsNames']
	    );

	    $this->registerChainExtension(
		    [BackendExportHelper::class, 'prepareVariantsData'],
		    [BackendExtender::class, 'prepareVariantsData']
	    );

        $this->extendBackendMenu('left_settings', [
            'left_variant_material_settings' => ['MaterialAssociationsAdmin'],
        ]);

        $this->addBackendBlock('product_variant', 'variant_material.tpl');
        $this->addBackendBlock('order_variant_material', 'order_variant_material.tpl');
    }
}