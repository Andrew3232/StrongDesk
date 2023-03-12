<div class="okay_list_boding variants_item_name">
    <div class="heading_label">{$btr->custom_variant_shape}</div>
    <select name="variants[shape][]" class="form-control" >
        <option value='0' {if empty($variant->shape)}selected{/if}>{$btr->custom_variant_choose_shape|escape}</option>
        {function name=shape_select level=0}
            {foreach from=$shape_associations item=shape}
                <option value='{$shape->id}' {if $variant->shape == $shape->id}selected{/if}>{section name=sp loop=$level}&nbsp;{/section}{$shape->name|escape}</option>
            {/foreach}
        {/function}
        {shape_select shape_associations=$shape_associations}
    </select>
</div>

