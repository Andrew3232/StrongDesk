{* Login page *}

{* The page title *}
{$meta_title = $lang->login_title scope=global}

<div class="login_form">
<div class="login_form__wrap">
	<form method="post" class="login_form__form fn_validate_login form">
		<div class="form__header">
			<h1 class="form__title"><span data-language="login_enter">{$lang->login_enter}</span></h1>
		</div>
		<div class="form__body">
			{* Form error messages *}
			{if $error}
				<div class="message_error">
					{if $error == 'login_incorrect'}
						<span data-language="login_error_pass">{$lang->login_error_pass}</span>
					{else}
						{$error|escape}
					{/if}
				</div>
			{/if}

			{* User's email *}
			<div class="form__group">
				<label class="form__group_label"> {$lang->form_email} <span>**</span></label>
				<input class="form__input" type="email" name="email" value="{$request_data.email|escape}"
					data-language="form_email" placeholder="{$lang->form_enter_email}" />
			</div>
			{* User's password *}
			<div class="form__group">
				<label class="form__group_label"> {$lang->form_password} <span>**</span></label>
				<input class="form__input" type="password" name="password" value="" data-language="form_password"
					placeholder="{$lang->form_enter_password}" />
				{*  Remind password link *}
				<a class="password_remind" href="{url_generator route="password_remind"}">
					<span data-language="login_remind">{$lang->login_remind}</span>
				</a>
			</div>
		</div>
		<div class="form__footer">
			{* Submit button *}
			<button type="submit" class="form__button button" name="login" value="{$lang->login_sign_in}">
				<span data-language="login_sign_in">{$lang->login_sign_in}</span>
			</button>
		</div>
	</form>
	<div class="login_form__separetor">
			<span data-language="or_text">{$lang->or_text}</span>
	</div>
	<a href="{url_generator route="register"}" class="form__button button button--red"
		data-language="login_registration">{$lang->login_registration}</a>
		</div>
</div>