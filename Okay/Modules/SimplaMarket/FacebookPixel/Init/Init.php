<?php


namespace Okay\Modules\SimplaMarket\FacebookPixel\Init;


use Okay\Helpers\CartHelper;
use Okay\Core\Modules\AbstractInit;
use Okay\Core\Modules\EntityField;
use Okay\Entities\OrdersEntity;
use Okay\Helpers\MainHelper;
use Okay\Helpers\OrdersHelper;
use Okay\Modules\SimplaMarket\FacebookPixel\Extenders\FrontendExtender;
use Okay\Core\Design;
use Okay\Entities\CurrenciesEntity;
use Okay\Core\Settings;

class Init extends AbstractInit
{
    const PERMISSION = 'simplamarket__facebook_pixel';

    public function install()
    {
        $this->setBackendMainController('ModuleAdmin');

        $this->migrateEntityField(OrdersEntity::class,
            (new EntityField('facebook_pixel__purchase_sended'))->setTypeTinyInt(1, false)->setDefault(0));
    }

    public function init()
    {
        $this->registerEntityField(OrdersEntity::class, 'facebook_pixel__purchase_sended');

        $this->addPermission(self::PERMISSION);
        $this->registerBackendController('ModuleAdmin');
        $this->addBackendControllerPermission('ModuleAdmin', self::PERMISSION);

        $this->addFrontBlock(
            'front_before_footer_content',
            'event_view_content_product.tpl',
            function(
                Design $design,
                CurrenciesEntity $currenciesEntity,
                Settings $settings
            ) {
                $product = $design->getVar('product');
                $category = $design->getVar('category');
                $categoryPath = [];

                if($category) {
                    foreach ($category->path as $p) {
                        $categoryPath[] = $p->name;
                    }
                    $mainCurrency = $currenciesEntity->getMainCurrency();
                    $data = [
                        'content_category' => implode('/', $categoryPath),
                        'content_name' => ($product->name . ($product->variant->name ? " {$product->variant->name}" : "")),
                        'content_type' => 'product',
                        'content_ids' => [(int)$product->variant->id],
                        'product_catalog_id'=>$settings->simplamarket__facebook_pixel__product_catalog_id,
                        'contents' => [
                            [
                                'id' => (int)$product->variant->id,
                                'quantity' => 1
                            ]
                        ],
                        'currency' => $mainCurrency->code,
                        'value' => $product->variant->price
                    ];
                    $jsonData = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
                    $design->assign('fp_content_data', $jsonData);
                }
            }
        );


        $this->registerQueueExtension(
            [OrdersHelper::class, 'getOrderPaymentMethodsList'],
            [FrontendExtender::class, 'assignPurchaseItems']
        );

        $this->registerQueueExtension(
            [MainHelper::class, 'setDesignDataProcedure'],
            [FrontendExtender::class, 'assignCategoriesList']
        );
    }
}