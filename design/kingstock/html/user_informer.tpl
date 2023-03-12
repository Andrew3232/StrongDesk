<!-- User account -->
{if $user}
	<a class="d-inline-flex align-items-center account__link" href="{url_generator route='user'}">
		{include file="svg.tpl" svgId="user_icon"}

		<span>{$user->name|escape}</span>
	</a>
{else}
	<a class="d-inline-flex align-items-center account__link" href="javascript:;" onclick="document.location.href = '{url_generator route="login"}'" title="{$lang->index_login}">
		<i class="fa fa-user-circle-o"></i>
	</a>
{/if}