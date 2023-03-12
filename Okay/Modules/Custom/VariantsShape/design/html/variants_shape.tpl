{if !empty($product->shapes)}
<div id="fn_shape_tab" class="product-page__tabs_shape">
    <div class="variant_shape__title" data-language="product_variant">{$lang->variant_shape_title}:</div>
    <div class="block tabs_shape fn_shape_kit">
        <div class="tabs_shape__navigation mobile_tabs_shape__navigation {if $item@first} fn_shape_active{/if}">
            {foreach $product->shapes as $shapeId=>$shape}
                <a id="fn_shape" class="shape_tabs__link fn_shape_{$shapeId} {if $product->variant->shape == $shapeId} selected{/if}"
                   data-id="{$shapeId}"
                   data-colors="{implode($shape['colors'],',')}"
                   data-sizes="{implode($shape['sizes'],',')}"
                   data-materials="{implode($shape['materials'],',')}"
                >
                    <span>{$shape_associations[{$shapeId}]->name}</span>
                </a>
            {/foreach}
        </div>
    </div>
</div>
{/if}