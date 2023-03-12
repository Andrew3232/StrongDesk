<!-- Password remind page -->

{* The page title *}
{$meta_title = $lang->password_remind_title scope=global}

<div class="login_form login_form--remind_pass">
<div class="login_form__wrap">
    {* The page heading *}
    <div class="block__header">
        <h1 class="block__heading"><span data-language="password_remind_header">{$lang->password_remind_header}</span></h1>
    </div>

    <div class="block">
        {if $email_sent}
            <div>
                <span data-language="password_remind_on">{$lang->password_remind_on}</span> <b>{$email|escape}</b> <span data-language="password_remind_letter_sent">{$lang->password_remind_letter_sent}.</span>
            </div>
        {else}
        <div class="f_row flex-lg-row align-items-md-start">

        </div>
            <div class="form_wrap">
                <form method="post" class="form">
                    <div class="form__header">
									<span class="label_block" data-language="password_remind_enter_your_email">{$lang->password_remind_enter_your_email}</span>
                    </div>
                    <div class="form__body">
                        {* Form error messages *}
                        {if $error}
                            <div class="message_error">
                                {if $error == 'user_not_found'}
                                    <span data-language="password_remind_user_not_found">{$lang->password_remind_user_not_found}</span>
                                {else}
                                    {$error|escape}
                                {/if}
                            </div>
                        {/if}
                        <div class="form__group">
								<label class="form__group_label"> {$lang->form_email}<span>*</span></label>
                            <input id="password_remind" class="form__input" type="text" name="email" value="{$request_data.email|escape}" data-language="form_email" required>
                        </div>
                    </div>
                    <div class="form__footer">
                        {* Submit button *}
                        <button type="submit" class="form__button button button--red" value="{$lang->password_remind_remember}">
                            <span data-language="password_remind_remember">{$lang->password_remind_remember}</span>
                        </button>
                    </div>
                </form>
            </div>
        {/if}
    </div>
	 </div>
</div>