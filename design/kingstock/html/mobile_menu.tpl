<ul class="top-nav">
	<li data-nav-custom-content>
		<div class="top-nav__logo">
			{if !empty({$settings->site_logo})}
				<a class="mobile__link "
					href="{if $controller=='MainController'}javascript:;{else}{url_generator route="main"}{/if}">
					<img src="{$rootUrl}/{$config->design_images}{$settings->site_logo}?v={$settings->site_logo_version}"
						alt="{$settings->site_name|escape}" />
				</a>
			{/if}
		</div>
		<div class="top-nav__close">
			<a class="fn_nav_btn_close top-nav__close" data-nav-close="true" href="#" title="{$lang->mobile_menu_close}">
				{include file="svg.tpl" svgId="close_icon"}
			</a>
		</div>
	</li>
</ul>

{$menu_mobile}

{* Currencies *}
{if $currencies|count > 1}
	<ul class="currencies-nav">
		<li class="">

		<div class="currencies_wrap"><span data-language="mobile_menu_currency"><i class="fa fa-money"></i></span>
				{$currency->name}</div>
			<ul class="">
				{foreach $currencies as $c}
					{if $c->enabled}
						<li>
							<a class="{if $currency->id== $c->id} active{/if}" href="#"
								onclick="document.location.href = '{url currency_id=$c->id}'">
								<span class="">{$c->name} </span> <span class=""> ({$c->sign})</span>
							</a>
						</li>
					{/if}
				{/foreach}
			</ul>
		</li>
	</ul>
{/if}

{if $languages|count > 1}
	{$cnt = 0}
	{foreach $languages as $ln}
		{if $ln->enabled}
			{$cnt = $cnt+1}
		{/if}
	{/foreach}
	{if $cnt>1}
		<ul class="language-nav">
			<li class="">
				{if is_file("{$config->lang_images_dir}{$language->label}.png")}
					<img alt="{$language->current_name}" src="{("{$language->label}.png"
			)|resize:20:20:false:$config->lang_resized_dir}" />
				{/if}
				<span class="">{$language->name}</span>
				<ul class="">
					{foreach $languages as $l}
						{if $l->enabled}
							<li>
								<a class=" {if $language->id == $l->id} active{/if}" href="{preg_replace('/^(.+)\/$/', '$1', $l->url)}">
									{if is_file("{$config->lang_images_dir}{$l->label}.png")}
										<img alt="{$l->current_name}" src="{("{$l->label}.png" )|resize:20:20:false:$config->lang_resized_dir}"
										/>
									{/if}
									<span class="">{$l->name}</span>
									{*<span class="">{$l->label}</span>*}
								</a>
							</li>
						{/if}
					{/foreach}
				</ul>
			</li>
		</ul>
	{/if}
{/if}

{if $settings->site_phones}
	{foreach $settings->site_phones as $phone}
		<ul>
			<li>
				<a class="burger_menu__contact phone icon icon-phone-callback" href="tel:{preg_replace('~[^0-9\+]~', '', $phone)}">
				<i class="fa fa-phone"></i>
					<span>{$phone|escape}</span>
				</a>
			</li>
		</ul>

	{/foreach}
{/if}
{if $settings->site_email}
	<ul>
		<li>
			<a class="burger_menu__contact email icon icon-mail-outline" href="mailto:{$settings->site_email|escape}">
			<i class="fa fa-envelope-o"></i>
				<span>{$settings->site_email|escape}</span>
			</a>
		</li>
	</ul>
{/if}

<ul>
	<li data-nav-custom-content>
	{if $settings->site_working_hours}
	<div class="{if !$settings->site_phones && !$settings->site_email} header-contact__item--visible{/if}">
		 <div class="d-flex align-items-center header-contact__section">
			  <div class="header-contact__title-s">{$settings->site_working_hours}</div>
		 </div>
	</div>
	{/if}
	</li>
</ul>





<ul class="bottom-nav social">
	{*Домен некоторых соц. сетей не соответствует стилям font-awesome, для них сделаны эти алиасы*}
	{$social_aliases.ok = 'odnoklassniki'}

	{foreach $settings->site_social_links as $social_link}
		{$social_domain = preg_replace('~(https?://)?(www\.)?([^\.]+)?\..*~', '$3', $social_link)}
		{if isset($social_aliases.$social_domain) || $social_domain}
			<li class="">
				<a class="{if isset($social_aliases.$social_domain)}{$social_aliases.$social_domain}{else}{$social_domain}{/if}"
					href="{if !preg_match('~^https?://.*$~', $social_link)}https://{/if}{$social_link|escape}" target="_blank"
					title="{$social_domain}">
					<i
						class="fa fa-{if isset($social_aliases.$social_domain)}{$social_aliases.$social_domain}{else}{$social_domain}{/if}"></i>
				</a>
			</li>

		{/if}
	{/foreach}
</ul>