{$meta_title = $btr->color_associations scope=parent}

{*Название страницы*}
<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {$btr->color_associations|escape}
            </div>
            <div class="box_btn_heading">
                <a id="add_currency" class="btn btn_small btn-info" href="{url module=FeatureAdmin return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>{$btr->add_association|escape}</span>
                </a>
            </div>
        </div>
    </div>
</div>

{*Вывод ошибок*}
{if $message_error}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="boxed boxed_warning">
                <div class="heading_box">
                    {if $message_error == 'wrong_iso'}
                        Недопустимый код ISO в
                        {foreach $wrong_iso as $w_iso}
                            <div>{$w_iso|escape}</div>
                        {/foreach}
                    {else}
                        {$message_error|escape}
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/if}

{*Главная форма страницы*}
<div class="boxed fn_toggle_wrap">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <form method=post class="fn_form_list">
                <input type="hidden" name="session_id" value="{$smarty.session.id}">
                <input type="hidden" name="lang_id" value="{$lang_id}" />
                <div class="okay_list">
                    <div class="currencies_wrap clearfix">
                        {*Шапка таблицы*}
                        <div class="okay_list_head" >
                            <div class="okay_list_heading"></div>
                            {*<div class="okay_list_heading okay_list_currency_num"></div>*}
                            <div class="okay_list_heading okay_list_currency_name" style="width: 100% !important;">{$btr->association_name|escape}</div>
                            <div class="okay_list_heading okay_list_currency_iso color_">{$btr->association_hex|escape}</div>
                            <div class="okay_list_heading okay_list_currency_name hex_">HEX</div>
                            <div class="okay_list_heading okay_list_currency_image image_">PATH</div>
                            <div class="okay_list_heading okay_list_currency_image image_">IMAGE</div>
                            <div class="okay_list_heading cur_settings"></div>
                            {*<div class="okay_list_heading okay_list_close"></div>*}
                        </div>

                        <style>

                            @media screen and (min-width: 920px) {

                                .color_ {
                                    transform: translateX(5px);
                                }

                                .hex_ {
                                    transform: translateX(15px);
                                }

                                .new_name_ {
                                    transform: translateX(-10px);
                                }
                            }

                        </style>

                        {*Параметры элемента*}
                        <div id="currencies_block" class="okay_list_body sortable">
                            {if $color_associations}
                                {foreach $color_associations as $c}
                                    <div class="okay_list_body_item">
                                        <div class="okay_list_row" style="margin-right: 20px !important;">
                                            <div class="okay_list_boding"></div>
                                            {*<div class="okay_list_boding okay_list_currency_num">*}
                                                {*<span>{$c->id}</span>*}
                                            {*</div>*}
                                            <div class="okay_list_boding okay_list_currency_name" style="width: 100% !important;">
                                                <input class="form-control" name="association[id][{$c->id}]" type="hidden" value="{$c->id|escape}"/>
                                                <input name="association[name][{$c->id}]" class="form-control" type="text" value="{$c->name|escape}"/>
                                            </div>

                                            <div class="okay_list_boding okay_list_currency_iso">
                                                <input class="form-control fn_color" type="color" name="hex[{$c->id}]" value="{$c->hex|escape}"/>
                                            </div>

                                            <div class="okay_list_boding okay_list_currency_name">
                                                <input class="form-control" type="text" name="association[hex][{$c->id}]" value="{$c->hex|escape}"/>
                                            </div>

{*                                            <div class="okay_list_boding okay_list_currency_name">*}
{*                                                <input class="form-control" type="file" name="association[image][{$c->id}]" value="{$c->hex|escape}"/>*}
{*                                            </div>*}
                                            <div class="okay_list_boding okay_list_currency_image">
                                                <input class="form-control" type="text" name="association[image][{$c->id}]" value="{$c->image|escape}"/>
                                            </div>
                                            <div class="okay_list_boding okay_list_currency_image">
{*                                                <button type="button" class="fn_remove_image remove_image"></button>*}
{*                                                <div class="fn_dropzone image_dropzone_block">*}
                                                {if $c->image}
                                                <i class="move_zone">
                                                    <img class="product_icon" width="40" height="40" src="{$color_dir}{$c->image|escape}" alt="{$c->name}">
{*                                                    <input type="hidden" name="images_ids[]" value="1">*}
                                                </i>
                                                {/if}
{*                                                    <i class="fa fa-plus font-5xl image_add" aria-hidden="true"></i>*}
{*                                                    <input class="dropinput" type="file" name="dropped_images[]" data-name="dropped_images[]"  style="display: inline-block;">*}
{*                                                </div>*}
                                            </div>


                                            <div class="okay_list_boding okay_list_close">
                                                <button data-hint="{$btr->delete_association|escape}" type="button" class=" btn_close fn_remove_currency hint-bottom-right-t-info-s-small-mobile  hint-anim" data-id="{$c->id}">
                                                    {include file='svg_icon.tpl' svgId='delete'}
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}

                            {*Сoздание нового элемента*}
                            <div id="new_currency" class="okay_list_body sortable" style="display: none">
                                <div class="okay_list_body_item">
                                    <div class="okay_list_row">
                                        <div class="okay_list_boding"></div>
                                        {*<div class="okay_list_boding okay_list_currency_num"></div>*}
                                        <div class="okay_list_boding okay_list_currency_name new_name_" style="width: 100% !important;">
                                            <input name="association[id][]" type="hidden" value=""/>
                                            <input name="association[name][]" class="form-control" type="text" value=""/>
                                        </div>

                                        <div class="okay_list_boding okay_list_currency_iso" style="margin-left: 8px !important;"></div>
                                        <div class="okay_list_boding okay_list_currency_name"></div>
                                        <div class="okay_list_boding okay_list_close"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="action" class="okay_list_footer">
                            <div class="okay_list_foot_left"></div>
                            <input type=hidden name=action value=''>
                            <input type=hidden name=action_id value=''>
                            <button id="apply_action" type="submit" class="btn btn_small btn_blue">
                                {include file='svg_icon.tpl' svgId='checked'}
                                <span>{$btr->general_apply|escape}</span>
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    var general_confirm_delete = '{$btr->general_confirm_delete|escape}';
</script>
<link rel="stylesheet" media="screen" type="text/css" href="design/js/colorpicker/css/colorpicker.css" />
<script type="text/javascript" src="design/js/colorpicker/js/colorpicker.js"></script>

{* On document load *}
{literal}
    <script>
        $(function() {
            // Добавление перевода
            var curr = $('#new_currency').clone(true);
            $('#new_currency').remove().removeAttr('id');
            $('a#add_currency').click(function() {
                $(curr).clone(true).appendTo('#currencies_block').fadeIn('slow').find("input[name*=association][name*=translate_ru]").focus();
                return false;
            });

            $(document).on("click", ".fn_remove_currency ", function () {
                $('input[type="hidden"][name="action"]').val('delete');
                $('input[type="hidden"][name="action_id"]').val($(this).data("id"));
                $(".fn_form_list").submit();
            });

            $(".fn_form_list").submit(function() {
                if($('input[type="hidden"][name="action"]').val()=='delete' && !confirm(general_confirm_delete)) {
                    return false;
                }
            });

            $(document).on("change", ".fn_color", function () {
                $(this).parents('.okay_list_row').find('input[name*="association"][name*="hex"]').val($(this).val());
            });
        });

    </script>
{/literal}
