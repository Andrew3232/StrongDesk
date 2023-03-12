<div class="product_preview__variants {if $product_size_color->size_color|count < 2} hidden{/if}">
    <div class="variant_size_color variant_size_color--mini ">
        <div class="variant_size_color__size">
            {foreach $product_size_color->size_color as $size=>$item}
                <div class="fn_size_color_kit variant_size_color__item_size">
                    <div class="fn_size  variant_size_color__item {if $item@first} fn_size_active{/if}">
                        <span class="fn__size {if $item@first}hidden{else}{/if}">{$size}</span>
                        <span class="fn__size_name {if $item@first}{else}hidden{/if}">{$item[0]->name}</span>
                    </div>
                    <div class="variant_size_color__color">
                        {foreach $item as $key=>$variant}
                            <input id="color_{$variant->id}" class="fn_variant variant_size_color__input" name="variant"
                                type="radio" value="{$variant->id}" {if $item@first && $variant@first} checked{/if}
                                data-sizevariantid="{$variant->id}" data-price="{$variant->price|convert}"
                                data-cprice="{$variant->compare_price|convert}" data-sku="{$variant->sku}" data-size="{$size}"
                                data-color="{$color_associations[{$variant->color}]->name}" data-stock="{$variant->stock}">
                            <label for="color_{$variant->id}" style="background: {$variant->color_hex}"
                                title="{$color_associations[{$variant->color}]->name}"
                                class="fn_size_color variant_size_color__item variant_size_color__item--color hidden">
                            </label>
                        {/foreach}
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>