{if !empty($product->sizes)}
<div id="fn_size_tab" class="product-page__tabs_color">
    <div class="variant_size_color__title" data-language="product_variant">{$lang->variant_size_title}:</div>
    <div class="block tabs_color fn_size_color_kit">
        <div class="tabs_color__navigation mobile_tabs_color__navigation {if $item@first} fn_size_active{/if}">
{*            {foreach $product->size_color as $size=>$item name=foo}*}
            {foreach $product->sizes as $key=>$size}
                <a id="fn_size" class="color_tabs__link size_tabs__link fn_size_{$key} {if $product->variant->size == $key} selected{/if}"
                   data-id="{$key}"
                   data-colors="{implode($size['colors'],',')}"
                   data-materials="{implode($size['materials'],',')}"
                   data-shapes="{implode($size['shapes'],',')}"
                >
                    <span>{$key}</span>
                </a>
            {/foreach}
        </div>
    </div>
</div>
{/if}

{if !empty($product->colors)}
<div id="fn_color_tab" class="product-page__tabs_color">
    <div class="variant_size_color__title" data-language="product_variant">{$lang->variant_color_title}:</div>
    <div class="block tabs_color fn_size_color_kit">
        <div class="tabs_color__content">
        {*            {foreach $product->size_color as $size=>$item name=foo}*}
        <div class="tabs_color-item">
            <ul>
                {foreach $product->colors as $colorId=>$color}
                    <li>
                        <input id="color_{$colorId}"
                               class="fn_variant variant_size_color__input"
                               name="color"
                               type="radio"
                               value="{$colorId}"
                               data-sizes="{implode($color['sizes'],',')}"
                               data-materials="{implode($color['materials'],',')}"
                               data-shapes="{implode($color['shapes'],',')}"
                                {if $product->variant->color == $colorId} checked{/if}
                                {*                                    data-sizevariantid="{$variant->id}" *}
                                {*                                       data-price="{$variant->price|convert}"*}
                                {*                                    data-cprice="{$variant->compare_price|convert}" *}
                                {*                                       data-sku="{$variant->sku}"*}
                                {*                                    data-stock="{$variant->stock}"*}
                        >
                        <label for="color_{$colorId}" style="background-image: url('{$color_dir}{$color_associations[{$colorId}]->image}')"
                               title="{$color_associations[{$colorId}]->name}"
                               class="fn_size_color variant_size_color__item variant_size_color__item--color hidden">
                        </label>
                    </li>
                {/foreach}
            </ul>
        </div>
        {*            {/foreach}*}
        </div>
    </div>
</div>
{/if}