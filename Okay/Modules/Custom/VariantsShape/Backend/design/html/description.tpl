{$meta_title = $btr->custom_variants_shape_title scope=global}

{*Название страницы*}
<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {$btr->custom_variants_shape_title|escape}
            </div>
        </div>
    </div>
</div>

<div class="alert alert--icon">
    <div class="alert__content">
        <div class="alert__title">{$btr->general_module_description}</div>
        <p>{$btr->custom_variants_shape_description}</p>
    </div>
</div>

<div class="alert alert--icon alert--info">
    <div class="alert__content">
        <div class="alert__title">{$btr->general_module_instruction}</div>
        <p>{$btr->custom_variants_shape_instruction}</p>
    </div>
</div>
