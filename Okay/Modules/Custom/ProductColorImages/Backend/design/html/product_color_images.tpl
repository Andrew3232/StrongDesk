<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="fn_step-16 boxed fn_toggle_wrap min_height_230px">
            <div class="heading_box">
                {$btr->backend_product_color_images_title|escape}
                <i class="fn_tooltips" title="{$btr->tooltip_product_images|escape}">
                    {include file='svg_icon.tpl' svgId='icon_tooltips'}
                </i>
                <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                    <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                </div>
            </div>

            <div class="toggle_body_wrap fn_card on">
                {foreach $product_colors as $color}
                    {if (($color@iteration - 1) % 2) == 0}
                    <div class="row boxed">
                    {/if}
                        <div class="col-md-3">
                            <div class="heading_box">
                                <div class="">{$color_associations[$color->color]->name}</div>
                                <div class="">
                                    <img src="/{$config->original_color_images_dir|escape}{$color_associations[$color->color]->image}"
                                         width="80" height="80"
                                         alt="{$color_associations[$color->color]->name}"
                                         title="{$color_associations[$color->color]->name}"
                                    >
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="fn_step-4 fn_toggle_wrap">
                                <div class="toggle_body_wrap on fn_card">
                                    <ul class="category_images_list">
                                        <li class="category_image_item fn_image_block">
                                            {if $product_color_images[$color->color]->filename}
                                                <input type="hidden" class="fn_accept_delete" name="delete_color_image[{$color->color}]" value="">
                                                <div class="fn_parent_image">
                                                    <div class="category_image image_wrapper fn_image_wrapper text-xs-center">
                                                        <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                                        <img src="{$product_color_images[$color->color]->filename|resize:300:120:false:$config->resized_product_color_images_dir}" alt="" />
                                                    </div>
                                                </div>
                                            {else}
                                                <div class="fn_parent_image"></div>
                                            {/if}
                                            <div class="fn_upload_image dropzone_block_image {if $product_color_images[$color->color]->filename} hidden{/if}">
                                                <i class="fa fa-plus font-5xl" aria-hidden="true"></i>
                                                <input class="dropzone_image" name="color_image[{$color->color}]" type="file" />
                                            </div>
                                            <div class="category_image image_wrapper fn_image_wrapper fn_new_image text-xs-center hidden">
                                                <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                                <img src="" alt="" />
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    {if ($color@iteration % 2) == 0 || $color@last}
                    </div>
                    {/if}
                {/foreach}
            </div>
            {get_design_block block="product_color_images"}
        </div>
    </div>
</div>

<script>
    $(function(){
        $('.fn_step-16 .remove_image').on('click',function(){
            $('.fn_fast_save').show();
        })
    })
</script>