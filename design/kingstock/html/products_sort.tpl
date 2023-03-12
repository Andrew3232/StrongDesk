{if $products|count > 0}
	<span class="sort_title" data-language="products_sort_by">{$lang->products_sort_by}:</span>
	<div class="products_sort fn_ajax_buttons sort">
		<div class="products_sort__select">
			<input type="hidden" onfocus="this.blur();">
			<span class="products_sort__select_text fn_sort_text"></span>
			<div class="products_sort__select_arrow fa fa-chevron-down">
			</div>
			
		</div>
		<div class="products_sort__options">
			<div class="products_sort__option fn_sort_select">
				<form class="product_sort__form" method="post">
					<button type="submit" name="prg_seo_hide"
						class="d-inline-flex align-items-center product_sort__link{if $sort=='position'} active_up{/if} no_after"
						value="{furl sort=position page=null absolute=1}">
						<span data-language="products_by_default">{$lang->products_by_default}</span>
					</button>
				</form>
			</div>
			
			<div class="products_sort__option">
				<form class="product_sort__form" method="post">
					<button type="submit" name="prg_seo_hide"
						class="d-inline-flex align-items-center product_sort__link{if $sort=='price'} active_up{/if}"
						value="{if $sort=='price'}{furl sort=price_desc page=null absolute=1}{else}{furl sort=price page=null absolute=1}{/if}">
						<span data-language="products_by_price_up">{$lang->products_by_price_up}</span>
					</button>
				</form>
			</div>
	
			<div class="products_sort__option">
				<form class="product_sort__form" method="post">
					<button type="submit" name="prg_seo_hide"
						class="d-inline-flex align-items-center product_sort__link{if $sort=='price_desc'} active_up{/if}"
						value="{if $sort=='price'}{furl sort=price_desc page=null absolute=1}{else}{furl sort=price page=null absolute=1}{/if}">
						<span data-language="products_by_price_down">{$lang->products_by_price_down}</span>
					</button>
				</form>
			</div>
	
			<div class="products_sort__option">
				<form class="product_sort__form" method="post">
					<button type="submit" name="prg_seo_hide"
						class="d-inline-flex align-items-center product_sort__link{if $sort=='name'} active_up{elseif $sort=='name_desc'} active_down{/if}"
						value="{if $sort=='name'}{furl sort=name_desc page=null absolute=1}{else}{furl sort=name page=null absolute=1}{/if}">
						<span data-language="products_by_name">{$lang->products_by_name}</span>
					</button>
				</form>
			</div>
			<div class="products_sort__option">
				<form class="product_sort__form" method="post">
					<button type="submit" name="prg_seo_hide"
						class="d-inline-flex align-items-center product_sort__link {if $sort=='rating'} active_up{elseif $sort=='rating_desc'} active_down{/if}"
						value="{if $sort=='rating'}{furl sort=rating_desc page=null absolute=1}{else}{furl sort=rating page=null absolute=1}{/if}">
						<span data-language="products_by_rating">{$lang->products_by_rating}</span>
					</button>
				</form>
			</div>
		</div>
	</div>
	{/if}