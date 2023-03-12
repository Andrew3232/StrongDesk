<div class="okay_list_boding variants_item_size">
    <div class="heading_label">{$btr->simplamarket_variant_size}</div>
    <input class="variant_input" name="variants[size][]" type="text" value="{$variant->size|escape}" />
</div>
<div class="okay_list_boding variants_item_name">
    <div class="heading_label">{$btr->simplamarket_variant_color}</div>
{*    {$variant->color}*}
{*    {$color_associations|@print_r}*}
    <select name="variants[color][]" class="form-control">
        <option value='0' {if empty($variant->color)}selected{/if}>{$btr->simplamarket_variant_choose_color|escape}</option>
{*        {function name=color_select level=0}*}
            {foreach from=$color_associations item=color}
                <option value='{$color->id}' {if $variant->color == $color->id}selected{/if}>{$color->name|escape}</option>
            {/foreach}
{*        {/function}*}
{*        {color_select color_associations=$color_associations}*}
    </select>
</div>

