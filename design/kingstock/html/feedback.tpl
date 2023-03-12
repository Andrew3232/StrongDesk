<!-- Feedback page -->

<div class="block">


	{* The page content *}
	<div class="block__body contacts_page">
		<div class="f_row contacts_page__row">
			{if $description}
				<div class="contacts_page__column f_col-xl-4  f_col-lg-4  f_col-md-12  f_col-sm-12 f_col-12">
					{* The page heading *}
					<h1 class="contacts_page__title">
						<span>{if $page->name_h1|escape}{$page->name_h1|escape}{else}{$page->name|escape}{/if}</span>
					</h1>
					<div class="contacts_page__description">{$description}</div>
					{* Social buttons *}
					{if $site_social}
						<div class="contacts_page__social social">
							<div class="social__title d-flex align-items-center justify-content-between">
								<span data-language="index_in_networks">{$lang->index_in_networks}</span>
							</div>
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
				</div>
			{/if}
			<div class="contacts_page__column f_col-xl-8  f_col-lg-8  f_col-md-12 f_col-sm-12 f_col-12">
				{* Form heading *}
				{if $message_sent}
					<div class="form contacts_page__form">
						<div class="contacts_page__title">
							<span data-language="feedback_feedback">{$lang->feedback_feedback}</span>
						</div>
						<div class="message_success">
							<b>{$request_data.name|escape},</b> <span
								data-language="feedback_message_sent">{$lang->feedback_message_sent}.</span>
						</div>
					</div>
				{else}
					{* Feedback form *}
					<form id="captcha_id" method="post" class="contacts_page__form fn_validate_feedback form">
						{if $settings->captcha_type == "v3"}
							<input type="hidden" class="fn_recaptcha_token fn_recaptchav3" name="recaptcha_token" />
						{/if}

						<div class="contacts_page__header">
							<div class="contacts_page__title">
								<span data-language="feedback_feedback">{$lang->feedback_feedback}</span>
							</div>

							{* Form error messages *}
							{if $error}
								<div class="message_error">
									{if $error=='captcha'}
										<span data-language="form_error_captcha">{$lang->form_error_captcha}</span>
									{elseif $error=='empty_name'}
										<span data-language="form_enter_name">{$lang->form_enter_name}</span>
									{elseif $error=='empty_email'}
										<span data-language="form_enter_email">{$lang->form_enter_email}</span>
									{elseif $error=='empty_text'}
										<span data-language="form_enter_message">{$lang->form_enter_message}</span>
									{/if}
								</div>
							{/if}
						</div>

						<div class="contacts_page__body">
							<div class="form_row d-flex">
								{* User's name *}
								<div class="form__group">
									<input class="form__input form__placeholder--focus"
										value="{if $request_data.name}{$request_data.name|escape}{elseif $user->name}{$user->name|escape}{/if}"
										name="name" type="text" data-language="form_name" placeholder="{$lang->form_name}*" />
								</div>

								{* User's email *}
								<div class="form__group">
									<input class="form__input"
										value="{if $request_data.email}{$request_data.email|escape}{elseif $user->email}{$user->email|escape}{/if}"
										name="email" type="text" data-language="form_email" placeholder="{$lang->form_email}*" />
								</div>
							</div>

							{* User's comment *}
							<div class="form__group">
								<textarea class="form__textarea" rows="3" name="message" data-language="form_enter_message"
									placeholder="{$lang->form_enter_message}">{$request_data.message|escape}</textarea>
							</div>
						</div>

						<div class="form__footer">
							{* Captcha *}
							{if $settings->captcha_feedback}
								{if $settings->captcha_type == "v2"}
									<div class="captcha" style="">
										<div id="recaptcha1"></div>
									</div>
								{elseif $settings->captcha_type == "default"}
									{get_captcha var="captcha_feedback"}
									<div class="captcha">
										<div class="secret_number">{$captcha_feedback[0]|escape} + ? = {$captcha_feedback[1]|escape}</div>
										<span class="form__captcha">
											<input class="form__input form__input_captcha form__placeholder--focus" type="text"
												name="captcha_code" value="" data-language="form_enter_captcha" />
											<span class="form__placeholder">{$lang->form_enter_captcha}*</span>
										</span>
									</div>
								{/if}
							{/if}
							<input type="hidden" name="feedback" value="1">

							{* Submit button *}
							<button class="form__button button button--red g-recaptcha" type="submit" name="feedback"
								{if $settings->captcha_type == "invisible"}data-sitekey="{$settings->public_recaptcha_invisible}"
								data-badge='bottomleft' data-callback="onSubmit" {/if} value="{$lang->form_send}">
								<span data-language="form_send">{$lang->form_send}
									{include file="svg.tpl" svgId="arrow_alt_right"}</span>
							</button>
						</div>
					</form>
				{/if}
			</div>
		</div>
	</div>
</div>
</div>
</div>

{* Map *}
{if $settings->iframe_map_code}
	<div class="contacts_map {if $settings->site_working_hours && $settings->site_phones && $settings->site_email}p_top{/if}">
		{if $settings->site_working_hours && $settings->site_phones && $settings->site_email}
			<div class="container">
				<div class="contacts_map__contacts">
					<div class="contacts_map__column">
						<div class="contacts_map__item">
							<div class="contacts_map__icon"><i class="fa fa-map-marker"></i></div>
							<div class="contacts_map__info">
								<div class="contacts_map__title">
									<span data-language="contacts_title_address">{$lang->contacts_title_address}</span>
								</div>
								<div class="contacts_map__text">
									<span class="contacts_map__text_item" data-language="location_text">{$lang->location_text}</span>
									<span class="contacts_map__text_item">
										{$settings->site_working_hours}
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="contacts_map__column">
						<div class="contacts_map__item">
							<div class="contacts_map__icon"><i class="fa fa-phone fa-phone-alt"></i></div>
							<div class="contacts_map__info">
								<div class="contacts_map__title">
									<span data-language="form_phone">{$lang->form_phone}</span>
								</div>
								<div class="contacts_map__text">
									{foreach $settings->site_phones as $phone}
										<a class="contacts_map__text_item" href="tel:{preg_replace('~[^0-9\+]~', '', $phone)}">
											<span>{$phone|escape}</span>
										</a>
									{/foreach}
								</div>
							</div>
						</div>
					</div>
					<div class="contacts_map__column">
						<div class="contacts_map__item">
							<div class="contacts_map__icon"><i class="fa fa-envelope"></i></div>
							<div class="contacts_map__info">
								<div class="contacts_map__title">
									<span data-language="contacts_title_email">{$lang->contacts_title_email}</span>
								</div>
								<div class="contacts_map__text">
									<a class="contacts_map__text_item" href="mailto:{$settings->site_email|escape}">
										<span>{$settings->site_email|escape}</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		{/if}

		<div class="contacts_map__map">
			{$settings->iframe_map_code}
		</div>
	</div>
{/if}