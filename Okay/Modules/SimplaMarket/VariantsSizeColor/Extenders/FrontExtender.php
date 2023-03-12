<?php

namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Extenders;

use Okay\Core\Design;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;

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
        $colorAssociations = $this->entityFactory->get(ColorAssociationsEntity::class)->mappedBy('id')->find();
        foreach($products as $product)
        {
            foreach($product->variants as $v)
            {
                if(!empty($v->color))
                {
                    $product->size_color[$v->size][] = $v;

                    $product->colors[$v->color]['sizes'][$v->size] = $v->size;
                    $product->colors[$v->color]['materials'][$v->material] = $v->material;
                    $product->colors[$v->color]['shapes'][$v->shape] = $v->shape;
                    @$v->color_hex = $colorAssociations[$v->color]->hex;
                }

                if(!empty($v->size)){
                    $product->sizes[$v->size]['colors'][$v->color] = $v->color;
                    $product->sizes[$v->size]['materials'][$v->material] = $v->material;
	                $product->sizes[$v->size]['shapes'][$v->shape] = $v->shape;
                }
            }
        }

        return $products;
    }

    public function getOrderPurchasesList($purchases)
    {
        $colorAssociations = $this->entityFactory->get(ColorAssociationsEntity::class)->mappedBy('id')->find();
        foreach($purchases as $purchase)
        {
            $purchase->variant->color_name = $colorAssociations[$purchase->variant->color]->name;
            $purchase->variant->color_hex = $colorAssociations[$purchase->variant->color]->hex;
            $purchase->variant->color_image = $colorAssociations[$purchase->variant->color]->image;
        }

        return $purchases;
    }

    public function getCart($cart)
    {
        $colorAssociations = $this->entityFactory->get(ColorAssociationsEntity::class)->mappedBy('id')->find();
        foreach($cart->purchases as $purchase)
        {
            $purchase->variant->color_hex = !empty($colorAssociations[$purchase->variant->color]->hex) ? $colorAssociations[$purchase->variant->color]->hex : null;
            $purchase->variant->color_name = !empty($colorAssociations[$purchase->variant->color]->name) ? $colorAssociations[$purchase->variant->color]->name : null;
            $purchase->variant->color_image = !empty($colorAssociations[$purchase->variant->color]->image) ? $colorAssociations[$purchase->variant->color]->image : null;
        }

        return $cart;
    }

}