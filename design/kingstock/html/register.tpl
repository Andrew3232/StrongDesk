<!-- Registration page -->

{* The page title *}
{$meta_title = $lang->form_enter_name scope=global}

<div class="login_form">
	<div class="login_form__wrap">
		<form id="captcha_id" method="post" class="login_form__form fn_validate_register form">
			{if $settings->captcha_type == "v3"}
				<input type="hidden" class="fn_recaptcha_token fn_recaptchav3" name="recaptcha_token" />
			{/if}
			<div class="form__header">
				<h1 class="form__title"><span data-language="register_header">{$lang->register_header}</span></h1>
			</div>
			<div class="form__body">
				{* Form error messages *}
				{if $error}
					<div class="message_error">
						{if $error == 'empty_name'}
							<span data-language="form_enter_name">{$lang->form_enter_name}</span>
						{elseif $error == 'empty_email'}
							<span data-language="form_enter_email">{$lang->form_enter_email}</span>
						{elseif $error == 'empty_password'}
							<span data-language="form_enter_password">{$lang->form_enter_password}</span>
						{elseif $error == 'user_exists'}
							<span data-language="register_user_registered">{$lang->register_user_registered}</span>
						{elseif $error == 'captcha'}
							<span data-language="form_error_captcha">{$lang->form_error_captcha}</span>
						{else}
							{$error|escape}
						{/if}
					</div>
				{/if}

				{* User's  name *}
				<div class="form__group">
					<label class="form__group_label"> {$lang->form_name} <span>*</span></label>
					<input class="form__input" type="text" name="name" value="{$request_data.name|escape}"
						data-language="form_name" placeholder="{$lang->form_enter_name}" />
				</div>

				{* User's  last name *}
				<div class="form__group">
					<label class="form__group_label"> {$lang->form_last_name}</label>
					<input class="form__input" type="text" name="last_name" value="{$request_data.name|escape}"
						data-language="form_last_name" placeholder="{$lang->form_enter_last_name}" />
				</div>

				{* User's  email *}
				<div class="form__group">
					<label class="form__group_label"> {$lang->form_email} <span>*</span></label>
					<input class="form__input" type="email" name="email" value="{$request_data.email|escape}"
						data-language="form_email" placeholder="{$lang->form_enter_email}" />
				</div>

				{* User's  phone *}
				<div class="form__group">
					<label class="form__group_label"> {$lang->form_phone}</label>
					<input class="form__input" type="tel" name="phone" value="{$request_data.phone|escape}"
						data-language="form_email" placeholder="{$lang->form_enter_phone}" />
				</div>

				{* User's  address *}
				<div class="form__group">
					<label class="form__group_label"> {$lang->form_address}</label>
					<input class="form__input" type="text" name="address" value="{$request_data.address|escape}"
						data-language="form_email" placeholder="{$lang->form_enter_address}" />
				</div>

				{* User's  password *}
				<div class="form__group">
					<label class="form__group_label"> {$lang->form_password} <span>*</span></label>
					<input class="form__input" type="password" name="password" value=""
						data-language="form_email" placeholder="{$lang->form_enter_password}" />
				</div>
			</div>
			<div class="form__footer">

			{if $settings->captcha_register}
				{if $settings->captcha_type == "v2"}
					<div class="captcha">
						<div id="recaptcha1"></div>
					</div>
				{elseif $settings->captcha_type == "default"}
					{get_captcha var="captcha_register"}
					<div class="captcha">
						<div class="secret_number">{$captcha_register[0]|escape} + ? = {$captcha_register[1]|escape}</div>
						<span class="form__captcha">
						<label class="form__group_label"> {$lang->form_enter_captcha} <span>**</span></label>
							<input class="form__input form__input_captcha" type="text"
								name="captcha_code" value="" data-language="form_enter_captcha" placeholder="{$lang->form_enter_captcha}">
						</span>
					</div>
				{/if}
			{/if}
			<input name="register" type="hidden" value="1">
			{* Submit button *}
			<button type="submit" value="{$lang->register_create_account}"
				class="form__button button g-recaptcha" name="register"
				{if $settings->captcha_type == "invisible"}data-sitekey="{$settings->public_recaptcha_invisible}"
				data-badge='bottomleft' data-callback="onSubmit" {/if}>
				<span data-language="register_create_account">{$lang->register_create_account}</span>
			</button>
			</div>
		</form>
		<div class="login_form__separetor">
			<span data-language="or_text">{$lang->or_text}</span>
		</div>
		<a href="{url_generator route="login"}" class="form__button button button--red"
			data-language="login_sign_in">{$lang->login_sign_in}</a>
	</div>
</div>