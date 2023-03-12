<?php

namespace Okay\Modules\Custom\VariantsMaterial\Extenders;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\Custom\VariantsMaterial\Entities\MaterialAssociationsEntity;

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
        $materialAssociations = $this->entityFactory->get(MaterialAssociationsEntity::class)->mappedBy('id')->find();
        foreach ($products as $product) {
            $tree = [];
            foreach ($product->variants as $v) {
                if (!empty($v->material)) {
                    $product->materials[$v->material]['colors'][$v->color] = $v->color;
                    $product->materials[$v->material]['sizes'][$v->size] = $v->size;
                    $product->materials[$v->material]['shapes'][$v->shape] = $v->shape;
                }
                // $v->name = $v->name .' '. (!empty($materialAssociations[$v->color]->name) ? $materialAssociations[$v->color]->name : null);
            }
            @$product->tree = $tree;
        }

        return $products;
    }

    public function getOrderPurchasesList($purchases)
    {
        $materialAssociations = $this->entityFactory->get(MaterialAssociationsEntity::class)->mappedBy('id')->find();
        foreach ($purchases as $purchase) {
            $purchase->variant->material_name = $materialAssociations[$purchase->variant->material]->name;
        }

        return $purchases;

    }

    public function getCart($cart)
    {
        $materialAssociations = $this->entityFactory->get(MaterialAssociationsEntity::class)->mappedBy('id')->find();
        foreach ($cart->purchases as $purchase) {
            $purchase->variant->material_name = !empty($materialAssociations[$purchase->variant->material]->name) ? $materialAssociations[$purchase->variant->material]->name : null;
        }

        return $cart;
    }

}