<!-- Page template -->

{if $page->url == '404'}
    {include file='page_404.tpl'}
{else}
	<div class="block">
		{* The page heading *}
		<div class="block__header">
			<h1 class="block__heading">
				<span data-page="{$page->id}">{if $page->name_h1|escape}{$page->name_h1|escape}{else}{$page->name|escape}{/if}</span>
			</h1>
		</div>

		{* The page content *}
		<div class="block">
			<div class="block__description">{$description}</div>
		</div>
    </div>
{/if}
