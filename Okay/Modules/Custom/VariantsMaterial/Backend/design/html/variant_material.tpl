<div class="okay_list_boding variants_item_name">
    <div class="heading_label">{$btr->custom_variant_material}</div>
    <select name="variants[material][]" class="form-control" >
        <option value='0' {if empty($variant->material)}selected{/if}>{$btr->custom_variant_choose_material|escape}</option>
        {function name=material_select level=0}
            {foreach from=$material_associations item=material}
                <option value='{$material->id}' {if $variant->material == $material->id}selected{/if}>{section name=sp loop=$level}&nbsp;{/section}{$material->name|escape}</option>
            {/foreach}
        {/function}
        {material_select material_associations=$material_associations}
    </select>
</div>

