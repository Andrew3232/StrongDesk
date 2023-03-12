{$meta_title = $btr->simplamarket__facebook_feed__module_title|escape scope=global}

{*Название страницы*}
<div class="row">
    <div class="col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {$btr->simplamarket__facebook_feed__module_title|escape}
            </div>
        </div>
    </div>
    <div class="col-md-12 float-xs-right"></div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="alert alert--icon">
            <div class="alert__content">
                <div class="alert__title">{$btr->simplamarket__facebook_feed__module_description_title}</div>
                <p>{$btr->simplamarket__facebook_feed__module_description_content}</p>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="alert alert--icon alert--info">
            <div class="alert__content">
                <div class="alert__title">{$btr->simplamarket__facebook_feed__module_instruction_title}</div>
                <p>{$btr->simplamarket__facebook_feed__module_instruction_content}</p>
                <p><a href="{url_generator route="Simplamarket.FacebookFeed.Feed"}" class="fn_clipboard hint-bottom-middle-t-info-s-small-mobile" data-hint="Click to copy" data-hint-copied="✔ Copied to clipboard">
                        {url_generator route="Simplamarket.FacebookFeed.Feed" absolute=true}
                    </a>
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    sclipboard();
</script>