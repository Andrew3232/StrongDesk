{if !empty($product->materials)}
<div id="fn_material_tab" class="product-page__tabs_material">
    <div class="variant_material__title" data-language="product_variant">{$lang->variant_material_title}:</div>
    <div class="block tabs_material fn_material_kit">
        <div class="tabs_material__navigation mobile_tabs_material__navigation {if $item@first} fn_material_active{/if}">
            {foreach $product->materials as $materialId=>$material}
                <a id="fn_material" class="material_tabs__link fn_material_{$materialId} {if $product->variant->material == $materialId} selected{/if}"
                   data-id="{$materialId}"
                   data-colors="{implode($material['colors'],',')}"
                   data-sizes="{implode($material['sizes'],',')}"
                   data-shapes="{implode($material['shapes'],',')}"
                >
                    <span>{$material_associations[{$materialId}]->name}</span>
                </a>
            {/foreach}
        </div>
    </div>
</div>
{/if}

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
  /* Переключення на конкретний варіант з параметрів url */
  $(document).ready(function(){
    var urlParams = new URLSearchParams(window.location.search);
    if(urlParams.toString()){
      var selectVariant = '';
      urlParams.forEach(function (value, key){
        selectVariant += '[data-' + key + '="' + value + '"]';
      })
      if(selectVariant)
        {
          $('.fn_variants.product_detail_page select.variant_select option'+selectVariant).attr('selected',true).trigger('change');
        }
    }
  });
</script>