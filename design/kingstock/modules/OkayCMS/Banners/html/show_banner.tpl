{if $banner_data->group_name == advantage}
	<div class="banner_advantages f_row">
		{foreach $banner_data->items as $bi}
			<div class="banner_advantages__item f_col-6 f_col-lg-3">
				<div class="banner_advantages__preview d-flex ">
					{if $bi->url}
						<a class="banner_advantages__link" aria-label="{$bi->title|escape}" href="{$bi->url|escape}"
							target="_blank"></a>
					{/if}
					<div class="banner_advantages__icon d-flex align-items-center justify-content-center">
						<picture>
							{if $settings->support_webp}
								<source type="image/webp"
									srcset="{$bi->image|resize:$bi->settings.mobile.w:$bi->settings.mobile.h:false:$config->resized_banners_images_dir|webp}"
									media="(max-width: 767px)">
								<source type="image/webp"
									srcset="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center|webp}">
							{/if}
							<source type="image/jpg"
								srcset="{$bi->image|resize:$bi->settings.mobile.w:$bi->settings.mobile.h:false:$config->resized_banners_images_dir}"
								media="(max-width: 767px)">
							<source type="image/jpg"
								srcset="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}">

							<img
								src="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}"
								data-src-retina="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}"
								alt="{$bi->alt|escape}" title="{$bi->title|escape}" />
						</picture>
					</div>
					<div class="banner_advantages__inner">
						{if $bi->title}
							<div class="banner_advantages__title">{$bi->title|escape}</div>
						{/if}

						{if $bi->description}
							<div class="banner_advantages__description">{$bi->description}</div>
						{/if}
					</div>
				</div>
			</div>
		{/foreach}
	</div>
{elseif $banner_data->group_name == 'benefits_main'}
	{foreach $banner_data->items as $bi}
		<div class="benefits_block__column anim_items anim_no_hide">
			<div class="benefits_block__item">
				<div class="benefits_block__bg _ibg">
					<img
						src="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}"
						data-src-retina="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}"
						alt="{$bi->alt|escape}" title="{$bi->title|escape}" />
				</div>
				<div class="benefits_block__inner">
					{if $bi->alt}
						<div class="benefits_block__subtitle">
							{$bi->alt} <span class="color_red">20%</span>
						</div>
					{/if}
					{if $bi->title && $bi->url}
						<h4 class="benefits_block__title">
							<a href="{$bi->url|escape}">{$bi->title|escape}</a>
						</h4>
					{elseif $bi->title}
						<h4 class="benefits_block__title">
							{$bi->title|escape}
						</h4>
					{/if}
					{if $bi->url}
						<a href="{$bi->url|escape}" class="benefits_block__button button" title="{$lang->shop_now}" target="_blank"
							<span data-language="shop_now">{$lang->shop_now}</span>
							{include file="svg.tpl" svgId="arrow_alt_right"}
						</a>
					{/if}
				</div>
			</div>
		</div>

	{/foreach}
{elseif $banner_data->group_name == 'benefits_big'}
	{foreach $banner_data->items as $bi}
		<div class="benefits_block__column anim_items anim_no_hide">
			<div class="benefits_block__item">
				<div class="benefits_block__bg _ibg">
					<img
						src="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}"
						data-src-retina="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}"
						alt="{$bi->alt|escape}" title="{$bi->title|escape}" />
				</div>
				<div class="benefits_block__inner">
					{if $bi->alt}
						<div class="benefits_block__subtitle color_red">
							{$bi->alt}
						</div>
					{/if}

					{if $bi->title && $bi->url}
						<h4 class="benefits_block__title">
							<a href="{$bi->url|escape}">{$bi->title|escape}</a>
						</h4>
					{elseif $bi->title}
						<h4 class="benefits_block__title">
							{$bi->title|escape}
						</h4>
					{/if}
					{if $bi->description}
						<div class="benefits_block__description">
							{$bi->description}
						</div>
					{/if}
					{if $bi->url}
						<a href="{$bi->url|escape}" class="benefits_block__button button button--border" title="{$lang->shop_now}"
							target="_blank" <span data-language="shop_now">{$lang->shop_now}</span>
							{include file="svg.tpl" svgId="arrow_alt_right"}
						</a>
					{/if}
				</div>
			</div>
		</div>

	{/foreach}
{elseif $banner_data->group_name == 'group_1'}
	<div class="fn_banner_{$banner_data->group_name|escape} banner_group--{$banner_data->id} main_block__slider fn_main_block_slider swiper-container">
		<div class="swiper-wrapper">
			{foreach $banner_data->items as $bi}
				<div class="main_block__slide slide_main swiper-slide banner_group-{$banner_data->id}_id-{$bi->id}"
					data-slide="{$banner_data->id}:{$bi->id}">
					<div class="slide_main__info">
						{if $bi->alt}
							<div class="slide_main__subtitle">{$bi->alt|escape}</div>
						{/if}
						{if $bi->title}
							<h2 class="slide_main__title">{$bi->title|escape}</h2>
						{/if}
						{if $bi->description}
							<div class="slide_main__descr">
								{$bi->description}
							</div>
						{/if}
						{if $bi->url}
							<a href="{$bi->url|escape}" class="slide_main__button button button--red" title="{$lang->shop_now}"
								target="_blank" aria-label="{$bi->title|escape}">
								<span data-language="shop_now">{$lang->shop_now}</span>
								{include file="svg.tpl" svgId="arrow_alt_right"}
							</a>
						{/if}
					</div>
					<div class="slide_main__content">
						<div class="slide_main__image">
						<picture>
						{if $settings->support_webp}
							 <source type="image/webp" srcset="{$bi->image|resize:$bi->settings.mobile.w:$bi->settings.mobile.mobile.h:false:$config->resized_banners_images_dir}.webp" media="(max-width: 767px)"> 
							 <source type="image/webp" srcset="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}.webp">
						{/if}
						<source type="image/jpg" srcset="{$bi->image|resize:$bi->settings.mobile.w:$bi->settings.mobile.h:false:$config->resized_banners_images_dir}" media="(max-width: 767px)">
						<source type="image/jpg" srcset="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}">
							 
						<img src="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}" data-src-retina="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}" alt="{$bi->alt|escape}" title="{$bi->title|escape}"/>
				  </picture>
						</div>
					</div>
				</div>
			{/foreach}
		</div>
		{if isset($banner_data->settings.nav) && !empty($banner_data->settings.nav)}
			<div class="swiper-button-next "></div>
			<div class="swiper-button-prev "></div>
		{/if}
		{if isset($banner_data->settings.dots) && !empty($banner_data->settings.dots)}
			<div class="swiper-pagination"></div>
		{/if}
	</div>

	{if $banner_data->settings.as_slider}
		<script>
			 document.addEventListener('DOMContentLoaded', function(){
				  $('.fn_banner_{$banner_data->group_name|escape}').each(function(){
						var swiper = new Swiper(this, {
						loop: {if isset($banner_data->settings.loop) && !empty($banner_data->settings.loop)}true{else}false{/if},
						{if isset($banner_data->settings.autoplay) && !empty($banner_data->settings.autoplay)}
							 autoplay: {
								  delay: {if isset($banner_data->settings.rotation_speed) && !empty($banner_data->settings.rotation_speed)}{$banner_data->settings.rotation_speed|intval}{else}2500{/if},
							 },
						{/if}
						{if isset($banner_data->settings.nav) && !empty($banner_data->settings.nav)}
							 navigation: {
								  nextEl: this.querySelector('.swiper-button-next'),
								  prevEl: this.querySelector('.swiper-button-prev'),
							 },
						{/if}
  
						{if isset($banner_data->settings.dots) && !empty($banner_data->settings.dots)}
						pagination: {
							 el: this.querySelector('.swiper-pagination'),
							 clickable: true,
							 },
						{/if}
						slidesPerView: 1,
						watchOverflow: true,
						// effect: 'fade',
						// fadeEffect: {
						// 	crossFade: true
						// },
						simulateTouch: false,
						spaceBetween: 70,
				  });
				  });
			 });
		</script>
		{/if}

		{else}
		<div class="fn_banner_{$banner_data->group_name|escape} banner_group banner_group--{$banner_data->id}  {if $banner_data->settings.as_slider}swiper-container{/if}">
			 {if $banner_data->settings.as_slider}<div class="swiper-wrapper">{/if}
				  {foreach $banner_data->items as $bi}
						{if $bi->settings.variant_show == Okay\Modules\OkayCMS\Banners\Entities\BannersImagesEntity::SHOW_DEFAULT}
						<div class="banner_group__item swiper-slide block--border banner_group-{$banner_data->id}_id-{$bi->id} banner_group__variant1" data-slide="{$banner_data->id}:{$bi->id}">
						{elseif $bi->settings.variant_show == Okay\Modules\OkayCMS\Banners\Entities\BannersImagesEntity::SHOW_DARK}
						<div class="banner_group__item swiper-slide block--border banner_group-{$banner_data->id}_id-{$bi->id} banner_group__variant2" data-slide="{$banner_data->id}:{$bi->id}">
						{elseif $bi->settings.variant_show == Okay\Modules\OkayCMS\Banners\Entities\BannersImagesEntity::SHOW_IMAGE_LEFT}
						<div class="banner_group__item swiper-slide block--border banner_group-{$banner_data->id}_id-{$bi->id} banner_group__variant3" data-slide="{$banner_data->id}:{$bi->id}">
						{elseif $bi->settings.variant_show == Okay\Modules\OkayCMS\Banners\Entities\BannersImagesEntity::SHOW_IMAGE_RIGHT}
						<div class="banner_group__item swiper-slide block--border banner_group-{$banner_data->id}_id-{$bi->id} banner_group__variant4" data-slide="{$banner_data->id}:{$bi->id}">
						{/if}
							 {if $bi->url}
							 <a class="banner_group__link" aria-label="{$bi->title|escape}" href="{$bi->url|escape}" target="_blank"></a>
							 {/if}
							 <div class="banner_group__image">
								  <picture>
										{if $settings->support_webp}
											 <source type="image/webp" srcset="{$bi->image|resize:$bi->settings.mobile.w:$bi->settings.mobile.h:false:$config->resized_banners_images_dir}.webp" media="(max-width: 767px)"> 
											 <source type="image/webp" srcset="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}.webp">
										{/if}
										<source type="image/jpg" srcset="{$bi->image|resize:$bi->settings.mobile.w:$bi->settings.mobile.h:false:$config->resized_banners_images_dir}" media="(max-width: 767px)">
										<source type="image/jpg" srcset="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}">
											 
										<img src="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}" data-src-retina="{$bi->image|resize:$bi->settings.desktop.w:$bi->settings.desktop.h:false:$config->resized_banners_images_dir:center:center}" alt="{$bi->alt|escape}" title="{$bi->title|escape}"/>
								  </picture>
							 </div>
							 <div class="banner_group__content">
								  <div class="banner_group__text">
										{if $bi->title}
											 <div class="banner_group__title">{$bi->title|escape}</div>
										{/if}
  
										{if $bi->description}
											 <div class="banner_group__description">{$bi->description}</div>
										{/if}
								  </div>
							 </div>
						</div>
				  {/foreach}
				  {if $banner_data->settings.as_slider}
				  </div>
				  {if isset($banner_data->settings.nav) && !empty($banner_data->settings.nav)}
						<div class="swiper-button-next "></div>
						<div class="swiper-button-prev "></div>
				  {/if}
				  {if isset($banner_data->settings.dots) && !empty($banner_data->settings.dots)}
						<div class="swiper-pagination"></div>
				  {/if}
			 {/if}
		</div>
  
  
		{if $banner_data->settings.as_slider}
		<script>
			 document.addEventListener('DOMContentLoaded', function(){
				  $('.fn_banner_{$banner_data->group_name|escape}').each(function(){
						var swiper = new Swiper(this, {
						loop: {if isset($banner_data->settings.loop) && !empty($banner_data->settings.loop)}true{else}false{/if},
						{if isset($banner_data->settings.autoplay) && !empty($banner_data->settings.autoplay)}
							 autoplay: {
								  delay: {if isset($banner_data->settings.rotation_speed) && !empty($banner_data->settings.rotation_speed)}{$banner_data->settings.rotation_speed|intval}{else}2500{/if},
							 },
						{/if}
						{if isset($banner_data->settings.nav) && !empty($banner_data->settings.nav)}
							 navigation: {
								  nextEl: this.querySelector('.swiper-button-next'),
								  prevEl: this.querySelector('.swiper-button-prev'),
							 },
						{/if}
  
						{if isset($banner_data->settings.dots) && !empty($banner_data->settings.dots)}
						pagination: {
							 el: this.querySelector('.swiper-pagination'),
							 clickable: true,
							 },
						{/if}
						slidesPerView: 1,
						watchOverflow: true,
						breakpoints: {
							 320: {
								  slidesPerView: 1,
							 },
							 991: {
								  slidesPerView: 1,
							 },
						}
				  });
				  });
			 });
		</script>
		{/if}


{/if}