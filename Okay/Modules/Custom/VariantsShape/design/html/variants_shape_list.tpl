<div class="product_preview__variants {if $product->shape|count < 2} hidden{/if}">
    <div class="variant_shape variant_size_shape--mini ">
        <div class="variant_size_shape__size">
            {foreach $product->shape as $size=>$item}
                <div class="fn_shape_kit variant_size_shape__item_size">
                    <div class="fn_size  variant_size_shape__item {if $item@first} fn_size_active{/if}">
                        <span class="fn__size {if $item@first}hidden{else}{/if}">{$size}</span>
                        <span class="fn__size_name {if $item@first}{else}hidden{/if}">{$item[0]->name}</span>
                    </div>
                    <div class="variant_shape__shape">
                        {foreach $item as $key=>$variant}
                            <input id="shape_{$variant->id}" class="fn_variant variant_shape__input" name="variant"
                                type="radio" value="{$variant->id}" {if $item@first && $variant@first} checked{/if}
                                data-sizevariantid="{$variant->id}" data-price="{$variant->price|convert}"
                                data-cprice="{$variant->compare_price|convert}" data-sku="{$variant->sku}" data-size="{$size}"
                                data-shape="{$shape_associations[{$variant->shape}]->name}" data-stock="{$variant->stock}">
                            <label for="shape_{$variant->id}"
                                title="{$shape_associations[{$variant->shape}]->name}"
                                class="fn_shape variant_shape__item variant_shape__item--shape hidden">
                                {$shape_associations[{$variant->shape}]->name}
                            </label>
                        {/foreach}
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>