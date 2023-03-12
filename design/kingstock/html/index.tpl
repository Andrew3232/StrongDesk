<!DOCTYPE html>
<html {if $language->href_lang} lang="{$language->href_lang|escape}" {/if} prefix="og: http://ogp.me/ns#">

<head>
	{* Meta data *}
	{get_design_block block="front_before_head_content"}
	{include "head.tpl"}
	{get_design_block block="front_after_head_content"}
</head>

<body
	class="d-flex flex-column {if $controller == 'MainController'}main_page{elseif $controller == 'CartController'}cart_page{else}other_page{/if} {if $page->url == 'faq'}inner_bg{/if}">
	{if !empty($counters['body_top'])}
		{foreach $counters['body_top'] as $counter}
			{$counter->code}
		{/foreach}
	{/if}

	{if $block = {get_design_block block="front_start_body_content"} }
		<div>
			{$block}
		</div>
	{/if}
	{if $controller == 'CartController SSS'}
		<header class="header">
			{if $is_mobile == false || $is_tablet == true}
				<div class="header__top hidden-md-down">
					<div class="container">
						<div class="f_row align-items-center flex-nowrap justify-content-between">
							{* Account *}
							<div id="account" class="d-flex align-items-center f_col">
								{include file="user_informer.tpl"}
							</div>
							<div class="d-flex align-items-center f_col justify-content-end">
								{* Callback *}
								<a class="fn_callback callback d-inline-flex align-items-center" href="#fn_callback"
									data-language="index_back_call">
									{include file="svg.tpl" svgId="support_icon"}
									<span>{$lang->index_back_call}</span>
								</a>
								{* Language & Currency *}
								<div class="switcher d-flex align-items-center">
									{include file="switcher.tpl"}
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="header__center hidden-md-down">
					<div class="container">
						<div class="f_row no_gutters flex-nowrap align-items-center justify-content-between">
							{* Menu button*}
							<div class="fn_menu_switch menu_switcher"></div>
							{* Logo *}
							<div class="header__logo logo">
								{if !empty({$settings->site_logo})}
									<a class="logo__link "
										href="{if $controller=='MainController'}javascript:;{else}{url_generator route='main'}{/if}">
										{if strtolower(pathinfo($settings->site_logo, $smarty.const.PATHINFO_EXTENSION)) == 'svg'}
											{$settings->site_logo|read_svg:$config->design_images}
										{else}
											<img
												src="{$rootUrl}/{$config->design_images|escape}{$settings->site_logo|escape}?v={$settings->site_logo_version|escape}"
												alt="{$settings->site_name|escape}" />
										{/if}
									</a>
								{/if}
							</div>
							{* Main menu *}
							<div class="header__menu d-flex flex-wrap">
								{$menu_header}
							</div>
							{* header contacts *}
							<div class="header-contact">
								<div
									class="header-contact__inner {if !$settings->site_phones && !$settings->site_email} header-contact__inner--adress{/if}">
									{if $settings->site_phones}
										{foreach $settings->site_phones as $phone}
											<div
												class="header-contact__item header-contact--phone{if $phone@first} header-contact__item--visible{/if}">
												<a class="d-flex align-items-center header-contact__section"
													href="tel:{preg_replace('~[^0-9\+]~', '', $phone)}">
													{include file="svg.tpl" svgId="phone_icon"}
													<span>{$phone|escape}</span>
												</a>
											</div>
										{/foreach}
									{/if}
									{if $settings->site_email}
										<div
											class="header-contact__item header-contact--email {if !$settings->site_phones} header-contact__item--visible{/if}">
											<a class="d-flex align-items-center header-contact__section"
												href="mailto:{$settings->site_email|escape}">
												<span>{$settings->site_email|escape}</span>
											</a>
										</div>
									{/if}
									{if $settings->site_working_hours}
										<div
											class="header-contact__item header-contact--time {if !$settings->site_phones && !$settings->site_email} header-contact__item--visible{/if}">
											<div class="d-flex align-items-center header-contact__section">
												<div class="header-contact__title-s">{$settings->site_working_hours}</div>
											</div>
										</div>
									{/if}
								</div>
							</div>
						</div>
					</div>
				</div>
			{/if}
			<div class="header__bottom">
				<div class="{if $controller != 'MainController'}fn_header__sticky {/if}" data-margin-top="0"
					data-sticky-for="991" data-sticky-class="is-sticky">
					<div class="container">
						<div
							class="header__bottom_panel f_row no_gutters flex-nowrap align-content-stretch justify-content-between">
							{* Mobile menu button*}
							<div class="fn_menu_switch menu_switcher hidden-lg-up">
								<div class="menu_switcher__heading d-flex align-items-center">
									<span class="" data-language="index_mobile_menu">{$lang->index_mobile_menu}</span>
								</div>
							</div>
							{* Catalog heading *}
							<div
								class="{if $controller != 'MainController' || empty($global_banners)}fn_catalog_switch button--blick{/if} catalog_button d-lg-flex hidden-md-down ">
								<div class="catalog_button__heading d-flex align-items-center ">
									<i class="fa fa-bars catalog_icon"></i>
									<span class="" data-language="index_categories">{$lang->index_categories}</span>
									{if $controller != 'MainController' || empty($global_banners)}
										<span class="catalog_button__arrow">{include file="svg.tpl" svgId="arrow_right"}</span>
									{/if}
								</div>
							</div>
							{* Search form *}
							<form id="fn_search" class="fn_search_mob search d-md-flex" action="{url_generator route='products'}">
								<input class="fn_search search__input" type="text" name="keyword" value="{$keyword|escape}"
									aria-label="search" data-language="products_search" placeholder="{$lang->products_search}" />
								<button class="search__button d-flex align-items-center justify-content-center" aria-label="search"
									type="submit"></button>
							</form>
							<div class="header_informers d-flex align-items-center">
								{* Mobile search toggle *}
								<div
									class="fn_search_toggle header_informers__item d-flex align-items-center justify-content-center hidden-md-up">
									{include file="svg.tpl" svgId="search_icon"}</div>
								{* Wishlist informer *}
								<div id="wishlist" class="header_informers__item d-flex align-items-center justify-content-center">
									{include file="wishlist_informer.tpl"}</div>
								{* Comparison informer *}
								<div id="comparison"
									class="header_informers__item d-flex align-items-center justify-content-center">
									{include "comparison_informer.tpl"}</div>
								{* Cart informer*}
								<div id="cart_informer"
									class="header_informers__item d-flex align-items-center justify-content-center">
									{include file='cart_informer.tpl'}</div>
							</div>
							{* Categories menu *}
							{if $is_mobile == false || $is_tablet == true}
								<nav
									class="fn_catalog_menu categories_nav hidden-md-down {if $controller == 'MainController' && !empty($global_banners)}categories_nav--show{/if}">
									{include file="desktop_categories.tpl"}
								</nav>
							{/if}
						</div>
					</div>
				</div>
			</div>
		</header>
	{/if}

	<header class="header">
		<div class="header__wrapper">
			<div class="header__container container">
				<div class="header__body">
					{* Logo *}
					<div class="header__logo logo">
						{if !empty({$settings->site_logo})}
							<a class="logo__link"
								href="{if $controller=='MainController'}javascript:;{else}{url_generator route='main'}{/if}">
								{if strtolower(pathinfo($settings->site_logo, $smarty.const.PATHINFO_EXTENSION)) == 'svg'}
									{$settings->site_logo|read_svg:$config->design_images}
								{else}
									<img
										src="{$rootUrl}/{$config->design_images|escape}{$settings->site_logo|escape}?v={$settings->site_logo_version|escape}"
										alt="{$settings->site_name|escape}" />
								{/if}
							</a>
						{/if}
					</div>
					{* Main menu *}
					<div class="header__menu d-flex flex-wrap">
						{$menu_header}
					</div>
					<div class="header__search">
						{* Search form *}
						<form id="fn_search" class="fn_search_mob search" action="{url_generator route='products'}">
							<input class="fn_search search__input" type="text" name="keyword" value="{$keyword|escape}"
								aria-label="search" data-language="products_search" placeholder="{$lang->products_search}" />
							<button class="search__button" aria-label="search" type="submit"></button>
						</form>
					</div>
					<div class="header_informers">
						{* Cart informer*}
						<div id="cart_informer" class="header_informers__item">
							{include file='cart_informer.tpl'}
						</div>
						{* Wishlist informer *}
						<div id="wishlist" class="header_informers__item">
							{include file="wishlist_informer.tpl"}
						</div>
						{* Comparison informer *}
						<div id="comparison" class="header_informers__item">{include "comparison_informer.tpl"}</div>
						{* Mobile search toggle *}
						{* <div
							class="fn_search_toggle header_informers__item ">
							{include file="svg.tpl" svgId="search_icon"}
						</div> *}
						{* Account *}
						<div id="account" class="header_informers__item">
							{include file="user_informer.tpl"}
						</div>
					</div>

					{* Mobile menu button*}
					<div class="fn_menu_switch header__icon">
						<div class="menu_switcher__heading">
							<span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>

	{* Тело сайта *}
	<div class="main {if $controller == 'MainController'}no_padding{/if}">

		{if $controller == 'MainController'}
			<section class="main_block main_block--home"
				style="background-image: url({$rootUrl}/design/{get_theme}/images/slider/slider-bg.jpg);">
				<div class="container">
					<div class="main_block__body">
						{$global_banners}
					</div>
				</div>
			</section>
			{* {elseif $page || $product}
			<section class="main_block add_padding"
				style="background-image: url({$rootUrl}/design/{get_theme}/images/slider/page-bg.jpg);">
				<div class="container">
					<div class="main_block__circle circle-shape">
						<span class="circle-shape__element"></span>
					</div>
					<div class="main_block__body">
						<h2 class="main_block__title title_main">
							{if $controller == 'ProductController'}
								{$product->name}
							{else}
								{$page->name}
							{/if}


						</h2>
						<div class="main_block__breadcrumb">
							{include file='breadcrumb.tpl'}
						</div>
					</div>
				</div>
			</section> *}
		{/if}


		{* Include module banner *}
		{* {if !empty($global_banners)}
			<div class="container">
				<div>

				</div>
			</div>
		{/if} *}

		{* Контент сайта *}
		{if $controller == "MainController" || $controller == "CartController" || (!empty($page) && $page->url == '404')}
			<div class="fn_ajax_content">
				{$content}
			</div>
		{else}
			<div class="container">
				{include file='breadcrumb.tpl'}
				<div class="fn_ajax_content">
					{$content}
				</div>
			</div>
		{/if}
		{* Преимущества магазина *}
		{if !empty($banner_shortcode_advantage) && $controller != 'MainController'}
			<div class="banners_benefits">
				<div class="container">
					{$banner_shortcode_advantage}
				</div>
			</div>
		{/if}
	</div>

	<!--  ====== preloader start ======================================  -->
	<div class="fn_preloader preloader">
		<div class="preloader__center">
			<div class="preloader__elements">
				<div class="preloader__element"></div>
				<div class="preloader__element"></div>
				<div class="preloader__element"></div>
				<div class="preloader__element"></div>
			</div>
		</div>
	</div>
	<!--  preloader-end -->

	{* Кнопка на верх *}
	<div class="fn_to_top to_top">
		{include file="svg.tpl" svgId="double_arrow"}
	</div>

	<div>
		{get_design_block block="front_before_footer_content"}
	</div>

	{* Footer *}
	{if $controller != 'CartController'}
		<footer class="footer">
			<div class="container">
				<div class="f_row flex-column flex-md-row justify-content-md-between align-items-start footer__row">
					{* Footer contacts *}
					<div class="f_col-lg">

						<div class="footer__content">
							<div class="footer__contact_item">
								<div class="footer__logo logo">
									{if !empty({$settings->site_logo})}
										<a class="logo__link"
											href="{if $controller=='MainController'}javascript:;{else}{url_generator route='main'}{/if}">
											{if strtolower(pathinfo($settings->site_logo, $smarty.const.PATHINFO_EXTENSION)) == 'svg'}
												{$settings->site_logo|read_svg:$config->design_images}
											{else}
												<img
													src="{$rootUrl}/{$config->design_images|escape}{$settings->site_logo|escape}?v={$settings->site_logo_version|escape}"
													alt="{$settings->site_name|escape}" />
											{/if}
										</a>
									{/if}
								</div>
							</div>
							{if $settings->site_working_hours}
								<div class="footer__contact_item">
									<div class="d-flex align-items-start open_hours">
										{include file="svg.tpl" svgId="time_icon"}
										{$settings->site_working_hours}
									</div>
								</div>
							{/if}

							<div class="footer__contact_item">
								<div class="d-flex location align-items-center">
									{include file="svg.tpl" svgId="location_icon"}
									<span data-language="location_text">{$lang->location_text}</span>
								</div>
							</div>
							{if $settings->site_email}
								<div class="footer__contact_item">
									<a class="d-flex email align-items-center" href="mailto:{$settings->site_email|escape}">
										{include file="svg.tpl" svgId="email_icon"}
										<span>{$settings->site_email|escape}</span>
									</a>
								</div>
							{/if}
							{if $settings->site_phones}
								{foreach $settings->site_phones as $phone}
									<div class="footer__contact_item">
										<a class="d-flex align-items-center phone" href="tel:{preg_replace('~[^0-9\+]~', '', $phone)}">
											{include file="svg.tpl" svgId="phone_icon"}
											<span>{$phone|escape}</span>
										</a>
									</div>
								{/foreach}
							{/if}

						</div>
					</div>
					{* Main menu *}
					<div class="f_col-lg">
						<div class="footer__title d-flex align-items-center justify-content-between">
							<span data-language="index_about_store">{$lang->index_about_store}</span>
							<span
								class="fn_switch_parent footer__title_arrow hidden-lg-up">{include file="svg.tpl" svgId="arrow_right"}</span>
						</div>
						<div class="footer__content footer__menu footer__hidden">
							{$menu_footer}
						</div>
					</div>
					{* Subscribing *}
					<div class="f_col-lg">
                                         {* Contact Information *}
						<div class="footer__title footer__title d-flex align-items-center justify-content-between">
							<span data-language="index_categories">Контакти</span>
						</div>
						 <div class="footer__content" style="font-size:12px;">ФОП «Кошляк Борис Степанович»,<br>ЄДРПОУ: 3562501417<br> Адреса: Україна, 35000, Рівненська обл., м. Костопіль, вул. Степанська 22А</div>
					     <hr style="margin: 10px 0;">
						 <div class="footer__content" " style="font-size:12px">Private Entrepreneur Koshliak Borys Stepanovych <br>EDRPOU: 3562501417<br>Location: Ukraine, 35000,<br> Rivne region, Kostopil city, Stepanska Str. 22A
						 </div>
					</div>
					
					<div class="f_col-lg">
						{* Social buttons *}
						{if $site_social}
							<div class="footer__title d-flex align-items-center justify-content-between">
								<span data-language="index_in_networks">{$lang->index_in_networks}</span>
							</div>
							<div class="footer__content  social">
								<div class="social__wrapper">
									{foreach $site_social as $social}
										<a class="social__link {$social.domain|escape}" rel="noreferrer" aria-label="{$social_domain}"
											href="{if !preg_match('~^https?://.*$~', $social.url)}https://{/if}{$social.url|escape}"
											target="_blank" title="{$social.domain|escape}">
											<i class="fa fa-{$social.domain|escape}"></i>
										</a>
									{/foreach}
								</div>
							</div>
						{/if}
						{* Payments *}
						{if $payment_methods}
							<div class="footer__title d-flex align-items-center justify-content-between">
								<span data-language="payment_methods_title">{$lang->payment_methods_title}</span>
							</div>
							<div class="footer__payments payments">
								<ul class="payments__list d-flex align-items-center">
									{foreach $payment_methods as $payment_method}
										{if !$payment_method->image}{continue}{/if}
										<li class="d-flex justify-content-center align-items-center payments__item"
											title="{$payment_method->name|escape}">
											<picture>
												{if $settings->support_webp}
													<source type="image/webp"
														data-srcset="{$payment_method->image|resize:80:30:false:$config->resized_payments_dir|webp}">
												{/if}
												<source
													data-srcset="{$payment_method->image|resize:80:30:false:$config->resized_payments_dir}">
												<img class="lazy"
													data-src="{$payment_method->image|resize:80:30:false:$config->resized_payments_dir}"
													src="{$rootUrl}/design/{get_theme}/images/xloading.gif"
													alt="{$payment_method->name|escape}" title="{$payment_method->name|escape}" />
											</picture>
										</li>
									{/foreach}
								</ul>
							</div>
						{/if}


					</div>
				</div>
			</div>
			<div class="footer__copyright">
				<div class="container">
					<div
						class="f_row flex-column flex-md-row justify-content-center justify-content-md-between align-items-center">
						{* Copyright *}
						<div class="f_col-md d-flex align-items-center justify-content-center copyright">
							<div class="d-flex align-items-center">
								<span>© {$smarty.now|date_format:"%Y"}</span>
								<span data-language="index_copyright">{$lang->index_copyright}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</footer>
	{/if}

	<div class="fn_mobile_menu hidden">
		{include file="mobile_menu.tpl"}
	</div>

	{* Форма обратного звонка *}
	{include file='callback.tpl'}

	{* Всплывающая корзина *}
	{if $route_name != 'cart'}
		<div id="fn_pop_up_cart_wrap" class="popup_animated" style="display: none;">
			<div id="fn_pop_up_cart" class="popup_animated">
				{include file='pop_up_cart.tpl'}
			</div>
		</div>
	{/if}

	{* Уведомления о добавление в сравнение *}
	<div id="fn_compare_confirm" class="popup_bg popup_animated" style="display: none;">
		<div class="popup_confirm__title">
			{include file="svg.tpl" svgId="success_icon"}
			<span data-language="popup_add_to_compare">{$lang->popup_add_to_compare}</span>
		</div>
	</div>

	{* Уведомления о добавление в избранное *}
	<div id="fn_wishlist_confirm" class="popup_bg popup_animated" style="display: none;">
		<div class="popup_confirm__title">
			{include file="svg.tpl" svgId="success_icon"}
			<span data-language="popup_add_to_wishlist">{$lang->popup_add_to_wishlist}</span>
		</div>
	</div>

	<div id="cookies-notification" class="cky-consent-container cky-classic-bottom" style="display: none;">
		<div class="cky-consent-bar">
			<div class="cky-notice">
				<p class="cky-title">Цей веб-сайт використовує файли cookie🍪</p>
				<div class="cky-notice-group">
					<div class="cky-notice-des" data-cky-tag="description" style="color: #212121;">
						<p>Ми використовуємо файли cookie, щоб дізнатися, як ви взаємодієте з нашим вмістом, і показувати вам відповідний вміст і рекламу на основі вашої історії веб-перегляду. Натиснувши «Прийняти», ви погоджуєтеся на використання файлів cookie.&nbsp;
							Наша <a href="/cookie-policy/"
							   class="cky-policy"
							   aria-label="Cookie Policy"
							   target="_blank"
							   rel="noopener"
							   style="color: #1863dc; border-color: transparent; background-color: transparent;">«Політика файлів cookie»</a>
						</p>
					</div>
					<div class="cky-notice-btn-wrapper " data-cky-tag="notice-buttons">
						<button class="form__button button--blick cky-btn cky-btn-accept"
								id="cookieSubmit"
								type="button"
								aria-label="Прийняти">Прийняти
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		ut_tracker.start('parsing:body_bottom:scripts');
	</script>

	{if $controller == 'ProductController' || $controller == "BlogController"}
		{js file="jssocials.min.js" dir='js_libraries/js_socials/js' defer=true}
	{/if}

	{$ok_footer}

	{if $controller == 'ProductController' || $controller == "BlogController"}
		{css file='jssocials.css' dir='js_libraries/js_socials/css'}
		{if $settings->social_share_theme}
			{css file="jssocials-theme-{$settings->social_share_theme|escape}.css" dir='js_libraries/js_socials/css'}
		{/if}
	{/if}
	<script>
		ut_tracker.end('parsing:body_bottom:scripts');
	</script>

	{if !empty($counters['body_bottom'])}
		<script>
			ut_tracker.start('parsing:body_bottom:counters');
		</script>
		{foreach $counters['body_bottom'] as $counter}
			{$counter->code}
		{/foreach}
		<script>
			ut_tracker.end('parsing:body_bottom:counters');
		</script>
	{/if}

	<script>
		ut_tracker.end('parsing:page');
	</script>

	<div>
		{get_design_block block="front_after_footer_content"}
	</div>

	{if $debug_bar_renderer}
		{$debug_bar_renderer->render()}
	{/if}

</body>
</html>