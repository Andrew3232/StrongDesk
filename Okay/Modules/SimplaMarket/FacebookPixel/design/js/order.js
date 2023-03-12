$(document).ready(function(){
    var variantId = $('#fn_purchases').find('.fp_purchase_data input[name="fp_variant_id"]');
    var category = $('#fn_purchases').find('.fp_purchase_data input[name="fp_category"]');
    var ids = [];
    var categories = [];
    var total_products = $('#fn_purchases').find('.fp_purchase_data input[name="fp_total_products"]').val();
    var currency = $('#fn_purchases').find('.fp_purchase_data input[name="fp_currency"]').val();
    var total_price = $('#fn_purchases').find('.fp_purchase_data input[name="fp_total_price"]').val();
    var catalog_id = $('#fp_catalog_id').val();

    $.each(variantId,function(index, value) {
        ids.push($(value).val());
    });
    $.each(category,function(index, value) {
        categories.push($(value).val());
    });



    fbq('track', 'InitiateCheckout', {
        content_type: 'product',
         content_category :categories ,   //категория товаров
        content_id: ids,   //id variants
        num_items : total_products ,    // количество товаров в корзине
        contents: [{'id': ids, 'quantity': total_products}],
        currency: currency,
        value : total_price,
        product_catalog_id : catalog_id,

    });
});