{if $products}
    {foreach $products as $product}
        <div class="product_item f_col-6 f_col-sm-4 f_col-md-4 f_col-lg-4 ">
            {include file="product_list.tpl"}
        </div>
    {/foreach}
{else}
    <div class="f_col-xs-12">
        <div class="boxed boxed--big boxed--notify ">
            <span data-language="products_not_found">{$lang->products_not_found}</span>
        </div>
    </div>
{/if}