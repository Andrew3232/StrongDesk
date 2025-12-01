<div class="fp_product_data">
    <input type="hidden" name="fp_variant_id" value="{$product->variant->id}" disabled>
    <input type="hidden" name="fp_product_id" value="{$product->id}" disabled>
    <input type="hidden" name="fp_product_name" value='{$product->name}' disabled>
    <input type="hidden" name="fp_variant_name" value='{$product->variant->name}' disabled>
    <input type="hidden" name="fp_category" value="{foreach $categories_list[$product->main_category_id]->path as $p}{if $p@iteration>1}/{/if}{$p->name}{/foreach}" disabled>
    <input type="hidden" name="fp_value" value="{$product->variant->price}" disabled>
    <input type="hidden" name="fp_currency" value="{$currency->code}" disabled>
</div>
