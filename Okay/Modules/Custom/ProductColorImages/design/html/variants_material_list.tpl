<div class="product_preview__variants {if $product->material|count < 2} hidden{/if}">
    <div class="variant_material variant_size_material--mini ">
        <div class="variant_size_material__size">
            {foreach $product->material as $size=>$item}
                <div class="fn_material_kit variant_size_material__item_size">
                    <div class="fn_size  variant_size_material__item {if $item@first} fn_size_active{/if}">
                        <span class="fn__size {if $item@first}hidden{else}{/if}">{$size}</span>
                        <span class="fn__size_name {if $item@first}{else}hidden{/if}">{$item[0]->name}</span>
                    </div>
                    <div class="variant_material__material">
                        {foreach $item as $key=>$variant}
                            <input id="material_{$variant->id}" class="fn_variant variant_material__input" name="variant"
                                type="radio" value="{$variant->id}" {if $item@first && $variant@first} checked{/if}
                                data-sizevariantid="{$variant->id}" data-price="{$variant->price|convert}"
                                data-cprice="{$variant->compare_price|convert}" data-sku="{$variant->sku}" data-size="{$size}"
                                data-material="{$material_associations[{$variant->material}]->name}" data-stock="{$variant->stock}">
                            <label for="material_{$variant->id}"
                                title="{$material_associations[{$variant->material}]->name}"
                                class="fn_material variant_material__item variant_material__item--material hidden">
                                {$material_associations[{$variant->material}]->name}
                            </label>
                        {/foreach}
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>