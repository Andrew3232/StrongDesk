$(function(){
    $(document).on('click', '.fn_is_stock .product-page__button', function(){
        let settingsBlock = $(this).closest('.fn_product').find('.fp_product_data'),
            variantId = parseInt(settingsBlock.find('input[name="fp_variant_id"]').val()),
            productName = settingsBlock.find('input[name="fp_product_name"]').val(),
            variantName = settingsBlock.find('input[name="fp_variant_name"]').val(),
            value = parseFloat(settingsBlock.find('input[name="fp_value"]').val()),
            currency = settingsBlock.find('input[name="fp_currency"]').val(),
            amount = parseInt($(this).closest('.fn_product').find('.amount__input').val() ?? 1);
        var catalog_id = $('#fp_catalog_id').val();

        ttq.track('AddToCart', {
            contents: [
                {
                    content_id: variantId,
                    content_name: productName + (variantName ? ` ${variantName}` : ''),
                    quantity: amount,
                    price: value,
                }],
            content_type:'product',
            value: amount * value,
            currency: currency,
        });

        fbq('track', 'AddToCart', {
            content_ids: [variantId],
            content_name: productName + (variantName ? ` ${variantName}` : ''),
            content_type: 'product',
            contents: [{'id': variantId, 'quantity': amount}],
            currency: currency,
            value: amount * value,
            product_catalog_id : catalog_id,
        });
    })

    $(document).on('click', '.product_preview__button.fn_is_stock', function(){
        let settingsBlock = $(this).closest('.fn_product').find('.fp_product_data'),
            variantId = parseInt(settingsBlock.find('input[name="fp_variant_id"]').val()),
            productName = settingsBlock.find('input[name="fp_product_name"]').val(),
            variantName = settingsBlock.find('input[name="fp_variant_name"]').val(),
            value = parseFloat(settingsBlock.find('input[name="fp_value"]').val()),
            currency = settingsBlock.find('input[name="fp_currency"]').val();
            var catalog_id = $('#fp_catalog_id').val();

        ttq.track('AddToCart', {
            contents: [
                {
                    content_id: variantId,
                    content_name: productName + (variantName ? ` ${variantName}` : ''),
                    quantity: 1,
                    price: value,
                }],
            content_type:'product',
            value: value,
            currency: currency,
        });

        fbq('track', 'AddToCart', {
            content_ids: [variantId],
            content_name: productName + (variantName ? ` ${variantName}` : ''),
            content_type: 'product',
            contents: [{'id': variantId, 'quantity': 1}],
            currency: currency,
            value: value,
            product_catalog_id : catalog_id,
        });
    })

    $(document).on('click', '.fa-rocket', function(){
        let settingsBlock = $(this).closest('.fn_product').find('.fp_product_data'),
            variantId = parseInt(settingsBlock.find('input[name="fp_variant_id"]').val()),
            productName = settingsBlock.find('input[name="fp_product_name"]').val(),
            variantName = settingsBlock.find('input[name="fp_variant_name"]').val(),
            category = settingsBlock.find('input[name="fp_category"]').val(),
            value = parseFloat(settingsBlock.find('input[name="fp_value"]').val()),
            currency = settingsBlock.find('input[name="fp_currency"]').val();
        var catalog_id = $('#fp_catalog_id').val();

        ttq.track('AddToCart', {
            contents: [
                {
                    content_id: variantId,
                    content_name: productName + (variantName ? ` ${variantName}` : ''),
                    content_category: category,
                    quantity: 1,
                    price: value,
                }],
            content_type:'product',
            value: value,
            currency: currency,
        });

        fbq('track', 'AddToCart', {
            content_ids: [variantId],
            content_name: productName + (variantName ? ` ${variantName}` : ''),
            content_type: 'product',
            contents: [{'id': variantId, 'quantity': 1}],
            currency: currency,
            value: value,
            product_catalog_id : catalog_id,
        });
    })

    $(document).on('click', '.fn_wishlist', function(){
        if (!$(this).hasClass('selected')) {
            let settingsBlock = $(this).closest('.fn_product').find('.fp_product_data'),
                variantId = parseInt(settingsBlock.find('input[name="fp_variant_id"]').val()),
                productName = settingsBlock.find('input[name="fp_product_name"]').val(),
                variantName = settingsBlock.find('input[name="fp_variant_name"]').val(),
                category = settingsBlock.find('input[name="fp_category"]').val(),
                value = parseFloat(settingsBlock.find('input[name="fp_value"]').val()),
                currency = settingsBlock.find('input[name="fp_currency"]').val();
            var catalog_id = $('#fp_catalog_id').val();

            ttq.track('AddToWishlist', {
                contents: [
                    {
                        content_id: variantId,
                        content_name: productName + (variantName ? ` ${variantName}` : ''),
                        content_category: category,
                        quantity: 1,
                        price: value,
                    }],
                content_type:'product',
                value: value,
                currency: currency,
            });

            fbq('track', 'AddToWishlist', {
                content_ids: [variantId],
                content_name: productName + (variantName ? ` ${variantName}` : ''),
                content_category: category,
                contents: [{'id': variantId, 'quantity': 1}],
                currency: currency,
                value: value,
                product_catalog_id : catalog_id,
            });
        }
    })
});