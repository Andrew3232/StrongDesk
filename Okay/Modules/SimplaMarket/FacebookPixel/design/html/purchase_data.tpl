<div class="fp_purchase_data">
    <input type="hidden" name="fp_variant_id" value="{$purchase->variant->id}" disabled>
    <input type="hidden" name="fp_category" value="{foreach $categories_list[$purchase->product->main_category_id]->path as $p}{if $p@iteration>1}/{/if}{$p->name}{/foreach}" disabled>
    <input type="hidden" name="fp_currency" value="{$currency->code}" disabled>
    <input type="hidden" name="fp_total_products" value="{$cart->total_products}" disabled>
    <input type="hidden" name="fp_currency" value="{$currency->sign|escape}" disabled>
    <input type="hidden" name="fp_total_price" value="{$cart->total_price}" disabled>
</div>