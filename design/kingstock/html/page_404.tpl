<!-- The template of page 404 -->

{* The page heading *}
{*<h1 class="h1"><span data-page="{$page->id}">{if $page->name_h1|escape}{$page->name_h1|escape}{else}{$page->name|escape}{/if}</span></h1>*}

{* The page content *}
<div class="block">
	<div class="container">
		<div class="not_found">
			<div class="not_found__title">
				404
			</div>
			<div class="not_found__description">
				{$description}
			</div>
			<div class="not_found__search">
				<form id="fn_search" class="fn_search_mob search" action="{url_generator route='products'}">
					<input class="fn_search search__input" type="text" name="keyword" value="{$keyword|escape}"
						aria-label="search" data-language="products_search" placeholder="{$lang->products_search}" />
					<button class="search__button" aria-label="search" type="submit"></button>
				</form>
			</div>
			<div class="not_found__menu">
				{$menu_404}
			</div>


		</div>
	</div>
</div>