<?php

namespace Okay\Modules\Custom\VariantsShape\Extenders;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\Custom\VariantsShape\Entities\ShapeAssociationsEntity;

class FrontExtender implements ExtensionInterface
{
    private $entityFactory;
    private $design;

    public function __construct(EntityFactory $entityFactory, Design $design)
    {
        $this->entityFactory = $entityFactory;
        $this->design = $design;
    }

    public function attachVariants($products)
    {
        $shapeAssociations = $this->entityFactory->get(ShapeAssociationsEntity::class)->mappedBy('id')->find();
        foreach ($products as $product) {
            $tree = [];
            foreach ($product->variants as $v) {
                if (!empty($v->shape)) {
                    $product->shapes[$v->shape]['colors'][$v->color] = $v->color;
                    $product->shapes[$v->shape]['sizes'][$v->size] = $v->size;
                    $product->shapes[$v->shape]['materials'][$v->material] = $v->material;
                }
                // $v->name = $v->name .' '. (!empty($shapeAssociations[$v->color]->name) ? $shapeAssociations[$v->color]->name : null);
            }
            @$product->tree = $tree;
        }

        return $products;
    }

    public function getOrderPurchasesList($purchases)
    {
        $shapeAssociations = $this->entityFactory->get(ShapeAssociationsEntity::class)->mappedBy('id')->find();
        foreach ($purchases as $purchase) {
            $purchase->variant->shape_name = $shapeAssociations[$purchase->variant->shape]->name;
        }

        return $purchases;

    }

    public function getCart($cart)
    {
        $shapeAssociations = $this->entityFactory->get(ShapeAssociationsEntity::class)->mappedBy('id')->find();
        foreach ($cart->purchases as $purchase) {
            $purchase->variant->shape_name = !empty($shapeAssociations[$purchase->variant->shape]->name) ? $shapeAssociations[$purchase->variant->shape]->name : null;
        }

        return $cart;
    }

}