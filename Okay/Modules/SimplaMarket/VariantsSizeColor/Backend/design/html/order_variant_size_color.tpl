{if $variant->size}<div class="mt-q font_12"><span class="text_grey" data-language="product_variant">{$btr->simplamarket_variant_size}:</span>{$variant->size}</div>{/if}
{if $variant->color}<div class="mt-q font_12"><span class="text_grey" data-language="product_variant">{$btr->simplamarket_variant_color}:</span><span class="variant_size_color__cart" style="background: url('/files/originals/colors/{$color_associations[$variant->color]->image}');" title="{$color_associations[$variant->color]->name}"></span></div>{/if}
<style>
    .variant_size_color__cart {
        border: none;
        opacity: 1;
        border-radius: 3px;
        display: inline-block;
        vertical-align: middle;
        height: 20px;
        width: 20px;
        margin: -3px 5px 0;
    }
</style>
