<!-- The main page template -->
{*<section class="benefits_block">*}
{*	<div class="container">*}
{*		<div class="benefits_block__body benefits_block__body--small">*}
{*			{$banner_shortcode_benefits_main}*}
{*		</div>*}
{*	</div>*}
{*</section>*}

{get_featured_products var=featured_products}
{if $featured_products}
	<section class="products_block">
		<div class="container">
			<div class="products_block__titles titles_section">
				<div class="titles_section__subtitle">
					<span data-language="featured_products">{$lang->featured_products}</span>
				</div>
				<h3 class="titles_section__title"><span data-language="popular_products">{$lang->popular_products}</span></h3>
			</div>

			<div class="products_block__body">
				<div class="products_block__slider fn_products_preview_columns swiper-container">
					<div class="swiper-wrapper">
						{foreach $featured_products as $product}
							<div class="products_block__slide swiper-slide">
								<div class="products_block__item item product_item no_hover">{include "product_list.tpl"}</div>
							</div>
						{/foreach}
					</div>
				</div>
			</div>
	</section>
{/if}

{*<section class="benefits_block">*}
{*	<div class="benefits_block__body benefits_block__body--big">*}
{*		{$banner_shortcode_benefits_big}*}
{*	</div>*}
{*</section>*}

{* New products *}
{get_new_products var=new_products limit=10}
{if $new_products}
	<section class="products_block">
		<div class="container">
			<div class="products_block__titles titles_section">
				<h3 class="titles_section__title"><span data-language="popular_products">{$lang->main_new_products}</span></h3>
			</div>

			<div class="products_block__body">
				<div class="products_block__slider fn_products_preview swiper-container">
					<div class="swiper-wrapper">
						{foreach $new_products as $product}
							<div class="products_block__slide swiper-slide">
								<div class="products_block__item item product_item no_hover">{include "product_list.tpl"}</div>
							</div>
						{/foreach}
					</div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
				</div>
			</div>
	</section>
{/if}


{* Discount products *}
{get_discounted_products var=discounted_products limit=10}
{if $discounted_products}
	<section class="products_block">
		<div class="container">
			<div class="products_block__titles titles_section">
				<h3 class="titles_section__title"><span data-language="popular_products">{$lang->main_discount_products}</span>
				</h3>
			</div>

			<div class="products_block__body">
				<div class="products_block__slider fn_products_preview swiper-container">
					<div class="swiper-wrapper">
						{foreach $discounted_products as $product}
							<div class="products_block__slide swiper-slide">
								<div class="products_block__item item product_item no_hover swiper-slide">{include "product_list.tpl"}
								</div>
							</div>
						{/foreach}
					</div>
				</div>
			</div>
	</section>
{/if}

{* Преимущества магазина *}
{if !empty($banner_shortcode_advantage)}
	<div class="banners_benefits">
		<div class="container">
			{$banner_shortcode_advantage}
		</div>
	</div>
{/if}

<section class="subscription anim_items anim_no_hide" style="background-image: url({$rootUrl}/design/{get_theme}/images/bg/subscribe-bg.jpg);">
	<div class="subscription__container container">
		<div class="subscription__body">
			<div class="subscription__titles titles_section">
				<div class="titles_section__subtitle">
					<span data-language="subtitle_subscr">{$lang->subtitle_subscr}</span>
				</div>
				<h3 class="titles_section__title"> <span data-language="title_subscr">{$lang->title_subscr}</span></h3>
			</div>
			<div id="subscribe_container" class="subscription__inner">
				<form class="fn_subscribe_form fn_validate_subscribe" method="post">
					<div class="subscription_form__group">
						<div class="subscription_form__inner">
							<div class="subscription_form__input_inner">
								<input type="hidden" name="subscribe" value="1" />
								<input class="form__input form__input_subscribe subscription__input" aria-label="subscribe"
									type="email" name="subscribe_email" value="" data-format="email"
									placeholder="{$lang->subscribe_placeholder}" />
								<i class="subscription_form__icon fa fa-envelope-open"></i>
							</div>
							<button class="subscription__button button button--red" type="submit" title="{$lang->subscribe_button}>
									<span data-language=" subscribe_button">{$lang->subscribe_button}</span>
									{include file="svg.tpl" svgId="arrow_alt_right"}
								</button>
							</div>
							<div class="fn_subscribe_success subscribe_success hidden">
								<span data-language="subscribe_sent">{$lang->index_subscribe_sent}</span>
							</div>

							<div class="fn_subscribe_error subscribe_error hidden">
								<span class="fn_error_text"></span>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>



	{* Last_posts *}


	{get_posts var=last_posts category_id=1}
	{if $last_posts}
		<div class="main-articles container">
				<div class="main-articles__titles titles_section">
					<div class="titles_section__subtitle">
						<span data-language="main_articles_subtitle">{$lang->main_articles_subtitle}</span>
					</div>
					<h3 class="titles_section__title"> <span
							data-language="main_articles_title">{$lang->main_articles_title}</span></h3>
				</div>
				<div class="block__body">
					<div class="fn_article_swiper article_list swiper-container">
						<div class="swiper-wrapper">
							{foreach $last_posts as $post}
								<div class="article_item no_hover swiper-slide">{include 'post_list.tpl'}</div>
							{/foreach}
						</div>
					</div>
				</div>
		</div>


	{/if}


	{get_brands var=all_brands visible_brand=1 limit=9}
	{* Brand list *}
	{if $all_brands}
		<section class="main_brands">
			<div class="main_brands__container container">
				<div class="main_brands__body fn_main_brands_slider swiper-container">
					<div class="swiper-wrapper">


									{foreach $all_brands as $b}
							<div class="main_brands__item swiper-slide">
								<a class="d-flex align-items-center justify-content-center main_brands__link"
									aria-label="{$b->name|escape}" href="
													{url_generator route='brand' url=$b->url}" data-brand="{$b->id}">

						{if $b->image}
						<div class="d-flex align-items-center justify-content-center main_brands__image">
							<picture>

								{if $settings->support_webp}
								<source type="image/webp"
									data-srcset="{$b->image|resize:100:50:false:$config->resized_brands_dir|webp}">

								{/if}
								<source data-srcset="{$b->image|resize:100:50:false:$config->resized_brands_dir}">
								<img class="main_brands_img lazy"
									data-src="{$b->image|resize:100:50:false:$config->resized_brands_dir}" src="{$rootUrl}/design/
													{get_theme}/images/xloading.gif" alt="{$b->name|escape}" title="{$b->name|escape}" />
							</picture>
						</div>

						{else}
						<div class="d-flex align-items-center justify-content-center main_brands__name">
										<span>{$b->name|escape}</span>
									</div>
								{/if}
							</a>
						</div>
					{/foreach}
				</div>
			</div>
		</div>
	</section>
{/if}