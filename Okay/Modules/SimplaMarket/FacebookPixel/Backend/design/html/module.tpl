{$meta_title = $btr->simplamarket__facebook_pixel__module_title|escape scope=global}

{*Название страницы*}
<div class="row">
    <div class="col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {$btr->simplamarket__facebook_pixel__module_title|escape}
            </div>
        </div>
    </div>
    <div class="col-md-12 float-xs-right"></div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="alert alert--icon">
            <div class="alert__content">
                <div class="alert__title">{$btr->simplamarket__facebook_pixel__module_description_title}</div>
                <p>{$btr->simplamarket__facebook_pixel__module_description_content}</p>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="alert alert--icon alert--info">
            <div class="alert__content">
                <div class="alert__title">{$btr->simplamarket__facebook_pixel__module_instruction_title}</div>
                <p>{$btr->simplamarket__facebook_pixel__module_instruction_content}</p>
            </div>
        </div>
    </div>
    <form method="POST">
        <input type=hidden name="session_id" value="{$smarty.session.id}">
        <div class="col-md-12">
            <div class="boxed">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <div class="heading_label heading_label--required">
                                <span>{$btr->simplamarket__facebook_pixel__module_account}</span>
                            </div>
                            <input class="form-control" type="text" name="account"
                                   value="{$settings->simplamarket__facebook_pixel__account_id}">
                            <div class="heading_label heading_label--required">
                                <span>{$btr->simplamarket__facebook_pixel__module_catalog}</span>
                            </div>
                            <input class="form-control" type="text" name="product_catalog_id"
                                   value="{$settings->simplamarket__facebook_pixel__product_catalog_id}">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="row">
                <div class="col-lg-12 col-md-12 mt-1">
                    <button type="submit" class="fn_step-15 btn btn_small btn_blue float-md-right">
                        {include file='svg_icon.tpl' svgId='checked'}
                        <span>{$btr->general_apply|escape}</span>
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
