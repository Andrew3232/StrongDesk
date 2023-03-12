// $(document).ready(function () {
//     $('.fn_size_color_kit').each(function () {
//         if ($(this).find('.fn_size').hasClass('fn_size_active')) {
//             $(this).find('.fn_size_color').removeClass('hidden');
//         }
//     });
//     $('.fn_variants').find('.details_boxed__select').hide();
//     $('.fn_variants').find('.product_preview__variants:first').hide();
// });

// $('.fn_size').on('click', function (e) {
//     $(this).closest('.fn_variants').find('.fn_size').removeClass('fn_size_active');
//     $(this).closest('.fn_variants').find('span.fn__size').removeClass('hidden');
//     $(this).closest('.fn_variants').find('span.fn__size_name').addClass('hidden');
//     $(this).addClass('fn_size_active');
//     $(this).find('span.fn__size_name').removeClass('hidden');
//     $(this).find('span.fn__size').addClass('hidden');
//     $(this).closest('.fn_variants').find('.fn_size_color').addClass('hidden');
//     $(this).closest('.fn_size_color_kit').find('.fn_size_color').removeClass('hidden');
//     $(this).closest('.fn_variants').find('[name*="variant"]').attr('checked', false).trigger('change');
//     $(this).closest('.fn_size_color_kit').find('[name*="variant"]:first').attr('checked', true).trigger('change');
//     let id = $(this).closest('.fn_size_color_kit').find('[name*="variant"]:first').val();
//     $('.fn_variant option').attr('selected', false);
//     $(`.fn_variant option[value="${id}"]`).attr('selected', true).trigger('change');
// });

$(function () {
    // var variant = $(`.fn_variant option:selected`);
    // var variantId = variant.val();
    // if($('#fn_material_tab').length){
    //     $('#fn_material').removeClass('selected');
    //     $('.fn_material_'+variant.data('material')).addClass('selected');
    // }
    // if($('#fn_color_tab').length){
    //     $('#color_'+variant.data('color')).prop("checked", true);
    // }
    // if($('#fn_size_tab').length){
    //     $('#fn_size').removeClass('selected');
    //     $('.fn_size_'+variant.data('size')).addClass('selected');
    // }

    /* Tabs */
    // if ($('.tabs_color').length) {
    //     var nav = $('.tabs_color').find('.tabs_color__navigation');
    //     var tabs = $('.tabs_color').find('.tabs_color__content');
    //
    //     if (nav.children('.selected').length > 0) {
    //         $(nav.children('.selected').attr("href")).show();
    //     } else {
    //         nav.children().first().addClass('selected');
    //         tabs.children().first().show();
    //     }
    //
    //     $('.tabs_color__navigation a').click(function (e) {
    //         e.preventDefault();
    //         if ($(this).hasClass('selected')) {
    //             return true;
    //         }
    //
    //         if ($(this).data('history_location')) {
    //             history.pushState({}, '', $(this).data('history_location'));
    //         }
    //
    //         tabs.children().hide();
    //         nav.children().removeClass('selected');
    //         $(this).addClass('selected');
    //
    //         console.log($($(this).attr('href')).find('.fn_size_color:first'))
    //         $($(this).attr('href')).find('.fn_size_color:first').trigger('click');
    //         $($(this).attr("href")).fadeIn(200);
    //     });
    //
    //     $('.fn_size_color').click(function (e) {
    //         let id = $('#'+$(this).attr('for')).val();
    //         if(typeof id !== "undefined" ) {
    //             $(`.fn_variant option`).attr('selected',false);
    //             $(`.fn_variant option[value="${id}"]`).attr('selected',true).trigger('change');
    //         }
    //     });
    // }
});