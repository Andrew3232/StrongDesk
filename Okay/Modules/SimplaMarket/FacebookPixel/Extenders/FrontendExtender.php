<?php


namespace Okay\Modules\SimplaMarket\FacebookPixel\Extenders;


use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Core\Settings;
use Okay\Entities\CategoriesEntity;
use Okay\Entities\CurrenciesEntity;
use Okay\Entities\OrdersEntity;
use Okay\Helpers\OrdersHelper;

class FrontendExtender implements ExtensionInterface
{
    /** @var EntityFactory */
    private $entityFactory;

    /** @var Design */
    private $design;

    /** @var OrdersHelper */
    private $ordersHelper;

    public function __construct(
        EntityFactory $entityFactory,
        Design        $design,
        OrdersHelper  $ordersHelper,
        Settings      $settings
    ) {
        $this->entityFactory = $entityFactory;
        $this->design        = $design;
        $this->ordersHelper  = $ordersHelper;
        $this->settings = $settings;
    }

    public function assignPurchaseItems($paymentMethods, $order)
    {
        /** @var OrdersEntity $ordersEntity */
        $ordersEntity = $this->entityFactory->get(OrdersEntity::class);

        /** @var CurrenciesEntity $currenciesEntity */
        $currenciesEntity = $this->entityFactory->get(CurrenciesEntity::class);

        if (!$order->facebook_pixel__purchase_sended) {
            $purchases = $this->ordersHelper->getOrderPurchasesList($order->id);

            $contentIds = [];
            $contents = [];
            $numItems = 0;
            $mainCurrency =  $currenciesEntity->getMainCurrency();
            foreach ($purchases as $purchase) {
                $contentIds[] = (int) $purchase->variant->id;
                $numItems += (int) $purchase->amount;
                $contents[] = [
                    'id' => (int) $purchase->variant->id,
                    'quantity' => (int) $purchase->amount
                ];
            }
            $data = [
                'content_ids' => $contentIds,
                'content_type' => 'product',
                'contents' => $contents,
                'currency' => $mainCurrency->code,
                'num_items' => $numItems,
                'value' => (float) $order->total_price,
                'product_catalog_id'=>$this->settings->simplamarket__facebook_pixel__product_catalog_id,
            ];
            $jsonData = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            $ordersEntity->update($order->id, ['facebook_pixel__purchase_sended' => 1]);
            $this->design->assign('fp_purchase_data', $jsonData);
        }
    }

    public function assignCategoriesList()
    {
        /** @var CategoriesEntity $ordersEntity */
        $categoriesEntity = $this->entityFactory->get(CategoriesEntity::class);

        $this->design->assign('categories_list', $categoriesEntity->find());
    }
}