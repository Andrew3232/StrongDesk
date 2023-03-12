/* Начальное кол-во для смены в карточке и корзине */
okay.amount = 1;

/* Аяксовая корзина */
$(document).on('submit', '.fn_variants', function(e) {
    e.preventDefault();
    var variant,
        amount;
    /* Вариант */
    if($(this).find('input[name=variant]:checked').length > 0 ) {
        variant = $(this).find('input[name=variant]:checked').val();
    } else if($(this ).find('input[name=variant]').length > 0 ) {
        variant = $(this).find('input[name=variant]').val();
    } else if($(this).find('select[name=variant]').length > 0 ) {
        variant = $(this).find('select[name=variant]').val();
    }
    /* Кол-во */
    if($(this).find('input[name=amount]').length>0) {
        amount = $(this).find('input[name=amount]').val();
    } else {
        amount = 1;
    }
    /* ajax запрос */
    $.ajax({
        url: okay.router['cart_ajax'],
        data: {
            action: 'add_citem',
            variant_id: variant,
            amount: amount
        },
        dataType: 'json',
        success: function(data) {
            $( '#cart_informer' ).html( data.cart_informer );
            $( '#fn_pop_up_cart' ).html( data.pop_up_cart );
            $.fancybox.open({
                'src': '#fn_pop_up_cart_wrap',
                opts: {
                    touch: false
                }
            });
        }
    });
});

function hideColors(colors = []){
  (colors.length == 1 && colors[0] == 0) ?
      $('#fn_color_tab').addClass('hidden') :
      $('#fn_color_tab').removeClass('hidden');
  $('.variant_size_color__input').each(function(index){
    if(colors.includes($(this).val()))
    {
      $(this).closest('li').show();
    }
    else{
      $(this).closest('li').hide();
    }
  });
}

function hideMaterials(materials = []){
  (materials.length == 1 && materials[0] == 0) ?
      $('#fn_material_tab').addClass('hidden') :
      $('#fn_material_tab').removeClass('hidden');
  $('.material_tabs__link').each(function(index){
    if(materials.includes($(this).data('id').toString()))
    {
      $(this).show();
    }
    else{
      $(this).hide();
    }
  });
}

function hideShapes(shapes = []){
  (shapes.length == 1 && shapes[0] == 0) ?
      $('#fn_shape_tab').addClass('hidden') :
      $('#fn_shape_tab').removeClass('hidden');
  $('.shape_tabs__link').each(function(index){
    if(shapes.includes($(this).data('id').toString()))
    {
      $(this).show();
    }
    else{
      $(this).hide();
    }
  });
}

function hideSizes(sizes = []){
  sizes.length == 1 && sizes[0] == 0 ?
      $('#fn_size_tab').addClass('hidden') :
      $('#fn_size_tab').removeClass('hidden');

  $('.size_tabs__link').each(function(index){
    if(sizes.includes($(this).data('id').toString()))
    {
      $(this).show();
    }
    else{
      $(this).hide();
    }
  });
}

function mergeArray(a = [], b = [], c = []){
  return $.merge(a, b, c);
}

function removeDuplicates(arr = []){
  return arr.filter((item, index) => arr.indexOf(item) == index);
}

function getDuplicates(arr = []){
  return arr.filter((item, index) => arr.indexOf(item) != index);
}

function switchVariants(material, size, color, size){

}
// $(document).on('change', '.fn_variant', function(){
//     let settingsBlock = $(this).closest('.fn_product').find('.fp_product_data');
//     settingsBlock.find('input[name="fp_variant_id"]').val($(this).val());
//     settingsBlock.find('input[name="fp_variant_name"]').val($(this).find('option:selected').html().trim());
//     settingsBlock.find('input[name="fp_value"]').val($(this).find('option:selected').data('price').replace(' ', ''));
// })

$(function(){

  /* Cookies */
  let cookieExist = getCookie('username');
  console.log('strongdesk');
  console.log(cookieExist);
  if(cookieExist != 'strongdesk')
  {
    $('#cookies-notification').show();
  }

  $('#cookieSubmit').on('click', function(){
    setCookie('username','strongdesk',90);
    $('#cookies-notification').hide();
  })

  /* переключення матеріалів */
  $('.material_tabs__link').click(function (e) {
    if($(this).hasClass('selected'))
    {
      return;
    }
    let material = $(this).data('id');

    let color = $('[name="color"]:checked');
    let shape = $('.shape_tabs__link.selected');
    let size = $('.size_tabs__link.selected');

    let colorsArrayMaterial = material.length ? material.data('colors').toString().split(',') : [];
    let colorsArrayShape = shape.length ? shape.data('colors').toString().split(',') : [];
    let colorsArraySize = size.length ? size.data('colors').toString().split(',') : [];
    let colors = mergeArray(colorsArrayMaterial, colorsArrayShape, colorsArraySize);

    let shapesArrayColor = color.length ? color.data('shapes').toString().split(',') : [];
    let shapesArrayMaterial = material.length ? material.data('shapes').toString().split(',') : [];
    let shapesArraySize = size.length ? size.data('shapes').toString().split(',') : [];
    let shapes = mergeArray(shapesArrayColor, shapesArrayMaterial, shapesArraySize);

    let sizesArrayColor = color.length ? color.data('sizes').toString().split(',') : [];
    let sizesArrayMaterial = material.length ? material.data('sizes').toString().split(',') : [];
    let sizesArrayShape = shape.length ? shape.data('sizes').toString().split(',') : [];
    let sizes = mergeArray(sizesArrayColor, sizesArrayShape, sizesArrayMaterial);

    colors = removeDuplicates(colors).sort();
    shapes = removeDuplicates(shapes).sort();
    sizes = removeDuplicates(sizes).sort();

    color = !colors.includes(color.val().toString()) ? colors[0] : color.val();
    shape = !shapes.includes(shape.data('id').toString()) ? shapes[0] : shape.data('id');
    size = !sizes.includes(size.data('id').toString()) ? sizes[0] : size.data('id');

    hideColors(colors);
    hideSizes(sizes);
    hideShapes(shapes);
    if(typeof material !== "undefined" ) {
        $(`.variant_select option`).attr('selected',false);
        $('.variant_select option[data-color="'+color+'"][data-material="'+material+'"][data-shape="'+shape+'"][data-size="'+size+'"]').attr('selected',true).trigger('change');
    }
  });

  // Переключення крок цв'яхів
  $('.size_tabs__link').click(function (e) {
    if($(this).hasClass('selected'))
    {
      return;
    }
    let size = $(this).data('id');

    let color = $('[name="color"]:checked');
    let material = $('.material_tabs__link.selected');
    let shape = $('.shape_tabs__link.selected');

    let colorsArrayMaterial = material.length ? material.data('colors').toString().split(',') : [];
    let colorsArrayShape = shape.length ? shape.data('colors').toString().split(',') : [];
    let colorsArraySize = size.length ? size.data('colors').toString().split(',') : [];
    let colors = mergeArray(colorsArrayMaterial, colorsArrayShape, colorsArraySize);

    let materialsArrayColor = color.length ? color.data('materials').toString().split(',') : [];
    let materialsArrayShape = shape.length ? shape.data('materials').toString().split(',') : [];
    let materialsArraySize = size.length ? size.data('materials').toString().split(',') : [];
    let materials = mergeArray(materialsArrayColor, materialsArrayShape, materialsArraySize);

    let shapesArrayColor = color.length ? color.data('shapes').toString().split(',') : [];
    let shapesArrayMaterial = material.length ? material.data('shapes').toString().split(',') : [];
    let shapesArraySize = size.length ? size.data('shapes').toString().split(',') : [];
    let shapes = mergeArray(shapesArrayColor, shapesArrayMaterial, shapesArraySize);

    colors = removeDuplicates(colors).sort();
    materials = removeDuplicates(materials).sort();
    shapes = removeDuplicates(shapes).sort();

    color = !colors.includes(color.val().toString()) ? colors[0] : color.val();
    material = !materials.includes(material.data('id').toString()) ? materials[0] : material.data('id');
    shape = !shapes.includes(shape.data('id').toString()) ? shapes[0] : shape.data('id');

    hideColors(colors);
    hideMaterials(materials);
    hideShapes(shapes);
    if(typeof size !== "undefined" ) {
        $(`.variant_select option`).attr('selected',false);
        $('.variant_select option[data-color="'+color+'"][data-material="'+material+'"][data-shape="'+shape+'"][data-size="'+size+'"]').attr('selected',true).trigger('change');
    }
  });

  // Переключення кольорів
  $('.variant_size_color__item').click(function (e) {
    if($(this).hasClass('selected'))
    {
      return;
    }
    let color = $(this).siblings('input');

    let size = $('.size_tabs__link.selected');
    let shape = $('.shape_tabs__link.selected');
    let material = $('.material_tabs__link.selected');

    let materialsArrayColor = color.length ? color.data('materials').toString().split(',') : [];
    let materialsArrayShape = shape.length ? shape.data('materials').toString().split(',') : [];
    let materialsArraySize = size.length ? size.data('materials').toString().split(',') : [];
    let materials = mergeArray(materialsArrayColor, materialsArrayShape, materialsArraySize);

    let shapesArrayColor = color.length ? color.data('shapes').toString().split(',') : [];
    let shapesArrayMaterial = material.length ? material.data('shapes').toString().split(',') : [];
    let shapesArraySize = size.length ? size.data('shapes').toString().split(',') : [];
    let shapes = mergeArray(shapesArrayColor, shapesArrayMaterial, shapesArraySize);

    let sizesArrayColor = color.length ? color.data('sizes').toString().split(',') : [];
    let sizesArrayMaterial = material.length ? material.data('sizes').toString().split(',') : [];
    let sizesArrayShape = shape.length ? shape.data('sizes').toString().split(',') : [];
    let sizes = mergeArray(sizesArrayColor, sizesArrayShape, sizesArrayMaterial);

    materials = removeDuplicates(materials).sort();
    shapes = removeDuplicates(shapes).sort();
    sizes = removeDuplicates(sizes).sort();

    color = color.val();
    size = !sizes.includes(size.data('id').toString()) ? sizes[0] : size.data('id');
    material = !materials.includes(material.data('id').toString()) ? materials[0] : material.data('id');
    shape = !shapes.includes(shape.data('id').toString()) ? shapes[0] : shape.data('id');

    hideSizes(sizes);
    hideMaterials(materials);
    hideShapes(shapes);
    if(typeof color !== "undefined" ) {
        $(`.variant_select option`).attr('selected',false);
        $('.variant_select option[data-color="'+color+'"][data-material="'+material+'"][data-shape="'+shape+'"][data-size="'+size+'"]').attr('selected',true).trigger('change');
    }
  });

  /* переключення форми */
  $('.shape_tabs__link').click(function (e) {
    if($(this).hasClass('selected'))
    {
      return;
    }
    let shape = $(this).data('id');

    let color = $('[name="color"]:checked');
    let size = $('.size_tabs__link.selected');
    let material = $('.material_tabs__link.selected');

    let colorsArrayMaterial = material.length ? material.data('colors').toString().split(',') : [];
    let colorsArrayShape = shape.length ? shape.data('colors').toString().split(',') : [];
    let colorsArraySize = size.length ? size.data('colors').toString().split(',') : [];
    let colors = mergeArray(colorsArrayMaterial, colorsArrayShape, colorsArraySize);

    let materialsArrayColor = color.length ? color.data('materials').toString().split(',') : [];
    let materialsArrayShape = shape.length ? shape.data('materials').toString().split(',') : [];
    let materialsArraySize = size.length ? size.data('materials').toString().split(',') : [];
    let materials = mergeArray(materialsArrayColor, materialsArrayShape, materialsArraySize);

    let sizesArrayColor = color.length ? color.data('sizes').toString().split(',') : [];
    let sizesArrayMaterial = material.length ? material.data('sizes').toString().split(',') : [];
    let sizesArrayShape = shape.length ? shape.data('sizes').toString().split(',') : [];
    let sizes = mergeArray(sizesArrayColor, sizesArrayShape, sizesArrayMaterial);

    colors = removeDuplicates(colors).sort();
    materials = removeDuplicates(materials).sort();
    sizes = removeDuplicates(sizes).sort();

    color = !colors.includes(color.val().toString()) ? colors[0] : color.val();
    material = !materials.includes(material.data('id').toString()) ? materials[0] : material.data('id');
    size = !sizes.includes(size.data('id').toString()) ? sizes[0] : size.data('id');

    hideColors(colors);
    hideSizes(sizes);
    hideMaterials(materials);
    if(typeof material !== "undefined" ) {
      $(`.variant_select option`).attr('selected',false);
      $('.variant_select option[data-color="'+color+'"][data-material="'+material+'"][data-shape="'+shape+'"][data-size="'+size+'"]').attr('selected',true).trigger('change');
    }
  });
});

/* Смена варианта в превью товара и в карточке */
$(document).on('change', '.variant_select', function() {
    var selected = $( this ).children( ':selected' ),
        parent = selected.closest( '.fn_product' ),
        price = parent.find( '.fn_price' ),
        cprice = parent.find( '.fn_old_price' ),
        sku = parent.find( '.fn_sku' ),
        stock = parseInt( selected.data( 'stock' ) ),
        amount = parent.find( 'input[name="amount"]' ),
        camoun = parseInt( amount.val()),
        material = parseInt(selected.data( 'material' )),
        shape = parseInt(selected.data( 'shape' )),
        size = parseInt(selected.data( 'size' )),
        color = parseInt(selected.data( 'color' )),
        units = selected.data('units');
    price.html( selected.data( 'price' ) );
    amount.data('max', stock);

    /* подсветка активних опций варианта */
    if($('#fn_material_tab').length){
      $('.material_tabs__link ').removeClass('selected');
      $('.fn_material_'+material).addClass('selected');
    }
    if($('#fn_shape_tab').length){
      $('.shape_tabs__link ').removeClass('selected');
      $('.fn_shape_'+shape).addClass('selected');
    }
    if($('#fn_color_tab').length){
      $('#color_'+color).prop("checked", true);
    }
    if($('#fn_size_tab').length){
      $('.color_tabs__link').removeClass('selected');
      $('.fn_size_'+size).addClass('selected');
    }

    /* Количество товаров */
    if ( stock < camoun ) {
        amount.val( stock );
    } else if ( okay.amount > camoun ) {
        amount.val( okay.amount );
    }
    else if(isNaN(camoun)){
        amount.val( okay.amount );
    }
    /* Цены */
    if( selected.data( 'cprice' ) ) {
        cprice.html( selected.data( 'cprice' ) );
        cprice.parent().removeClass( 'hidden-xs-up' );
    } else {
        cprice.parent().addClass( 'hidden-xs-up' );
    }
    if( selected.data( 'discount' ) ) {
        parent.find('.fn_discount_label').html(selected.data( 'discount' )).removeClass( 'hidden-xs-up' );
    } else {
        parent.find('.fn_discount_label').addClass( 'hidden-xs-up' );
    }
    /* Артикул */
    if( typeof(selected.data( 'sku' )) != 'undefined' ) {
        sku.text( selected.data( 'sku' ) );
        sku.parent().removeClass( 'hidden-xs-up' );
    } else {
        sku.text( '' );
        sku.parent().addClass( 'hidden-xs-up' );
    }
    /* Наличие на складе */
    if (stock == 0) {
        parent.find('.fn_not_stock').removeClass('hidden-xs-up');
        parent.find('.fn_in_stock').addClass('hidden-xs-up');
    } else {
        parent.find('.fn_in_stock').removeClass('hidden-xs-up');
        parent.find('.fn_not_stock').addClass('hidden-xs-up');
    }
    /* Предзаказ */
    if (stock == 0 && okay.is_preorder) {
        parent.find('.fn_is_preorder').removeClass('hidden-xs-up');
        parent.find('.fn_is_stock, .fn_not_preorder').addClass('hidden-xs-up');
    } else if (stock == 0 && !okay.is_preorder) {
        parent.find('.fn_not_preorder').removeClass('hidden-xs-up');
        parent.find('.fn_is_stock, .fn_is_preorder').addClass('hidden-xs-up');
    } else {
        parent.find('.fn_is_stock').removeClass('hidden-xs-up');
        parent.find('.fn_is_preorder, .fn_not_preorder').addClass('hidden-xs-up');
    }
    /* Единица измерения */
    if( typeof(units) != 'undefined' ) {
        parent.find('.fn_units').text(', ' + units);
    } else {
        parent.find('.fn_units').text('');
    }
});

/* Количество товара в карточке и корзине */
$( document ).on( 'click', '.fn_product_amount span', function() {
    var input = $( this ).parent().find( 'input' ),
        action;
    if ( $( this ).hasClass( 'fn_plus' ) ) {
        action = 'plus';
    } else if ( $( this ).hasClass( 'fn_minus' ) ) {
        action = 'minus';
    }
    amount_change( input, action );
});

$(document).on('submit', '.fn_subscribe_form', function(e) {
    e.preventDefault();
    
    let successBlock = $('.fn_subscribe_success'),
        errorBlock = $('.fn_subscribe_error'),
        form = $(this),
        formData = form.serialize();
    
    $.ajax({
        url: okay.router['ajax_subscribe'],
        data: formData,
        'type': 'post',
        dataType: 'json',
        success: function(data) {
            
            if (data.hasOwnProperty('success')) {
                errorBlock.hide();
                successBlock.show();
                form.find('[name="subscribe_email"]').val('');
            } else if (data.hasOwnProperty('error')) {
                successBlock.hide();
                errorBlock.children('.fn_error_text').text(data.error);
                errorBlock.show();
            }
        }
    });
});

/* Функция добавления / удаления в папку сравнения */
$(document).on('click', '.fn_comparison', function(e){
    e.preventDefault();
    var button = $( this ),
        action = $( this ).hasClass( 'selected' ) ? 'delete' : 'add',
        product = parseInt( $( this ).data( 'id' ) );
    /* ajax запрос */
    $.ajax( {
        url: okay.router['comparison_ajax'],
        data: { product: product, action: action },
        dataType: 'json',
        success: function(data) {
            $( '#comparison' ).html( data.template );
            /* Смена класса кнопки */
            if( action == 'add' ) {
                button.addClass( 'selected' );
            } else if( action == 'delete' ) {
                button.removeClass( 'selected' );
            }
            /* Смена тайтла */
            if( button.attr( 'title' ) ) {
                var text = button.data( 'result-text' ),
                    title = button.attr( 'title' );
                button.data( 'result-text', title );
                button.attr( 'title', text );
            }
            /* Если находимся на странице сравнения - перезагрузить */
            if( $( '.fn_comparison_products' ).length ) {
                window.location = window.location;
            }
        }
    });
    /* Попап Товар добавлен в сравнение */
    if( !button.hasClass( 'selected' ) ) {
        $.fancybox.open({
            src: '#fn_compare_confirm',
            type : 'inline',
            opts : {
                afterLoad : function() {
                    setTimeout( function() {$.fancybox.close(); },1500);
                }
            }
        });
    }
});

/* Функция добавления / удаления в папку избранного */
$(document).on('click', '.fn_wishlist', function(e){
    e.preventDefault();
    var button = $( this ),
        action = $( this ).hasClass( 'selected' ) ? 'delete' : '';
    /* ajax запрос */
    $.ajax( {
        url: okay.router['wishlist_ajax'],
        data: { id: $( this ).data( 'id' ), action: action },
        dataType: 'json',
        success: function(data) {
            $( '#wishlist' ).html( data.wishlist_informer );
            /* Смена класса кнопки */
            if (action == '') {
                button.addClass( 'selected' );
            } else {
                button.removeClass( 'selected' );
            }
            /* Смена тайтла */
            if( button.attr( 'title' ) ) {
                var text = button.data( 'result-text' ),
                    title = button.attr( 'title' );
                button.data( 'result-text', title );
                button.attr( 'title', text );
            }
            /* Если находимся на странице сравнения - перезагрузить */
            if( $( '.fn_wishlist_page' ).length ) {
                window.location = window.location;
            }
        }
    });
    /* Попап Товар добавлен в избранное */
    if( !button.hasClass( 'selected' ) ) {
        $.fancybox.open({
            src: '#fn_wishlist_confirm',
            type : 'inline',
            opts : {
                afterLoad : function() {
                    setTimeout( function() {$.fancybox.close(); },1500);
                }
            }
        });
    }
});

/* Отправка купона по нажатию на enter */
$( document ).on( 'keypress', '.fn_coupon', function(e) {
    if( e.keyCode == 13 ) {
        e.preventDefault();
        ajax_coupon();
    }
});

/* Отправка купона по нажатию на кнопку */
$( document ).on( 'click', '.fn_sub_coupon', function(e) {
    ajax_coupon();
});

/* Функция фильтра по цене */
function price_slider_init() {
    let stepsSlider = document.getElementById('fn_slider_price');
    
    if (stepsSlider === null) {
        return;
    }
    
    let slider_min = document.getElementById('fn_slider_min'),
        slider_max = document.getElementById('fn_slider_max'),
        slider_all = [slider_min, slider_max],
        current_min = slider_min.value,
        current_max = slider_max.value,
        range_min = slider_min.dataset.price,
        range_max = slider_max.dataset.price,
        ajax_slider = function() {
            let link = $(stepsSlider).data('href').replace(/price-min_max/, 'price-'+slider_min.value+'_'+slider_max.value);

            $.ajax( {
                url: link,
                data: {
                    ajax: 1
                },
                dataType: 'json',
                success: function(data) {
                    window.history.pushState({}, '', link);

                    if ((window.featuresCache !== undefined) && window.featuresCache.timeout > 0) {
                        window.featuresCache.set(okay.filterCacheKey, {
                            features: data.features,
                            selected_features: data.selected_features,
                        });
                    }
                    
                    $('#fn_products_content').html( data.products_content );
                    $('.fn_pagination').html( data.products_pagination );
                    $('.fn_products_sort').html(data.products_sort);
                    $('.fn_features').html(data.features);
                    $('.fn_selected_features').html(data.selected_features);
                    // Выпадающие блоки
                    $(".lazy").each(function(){
                        var myLazyLoad = new LazyLoad({
                            elements_selector: ".lazy"
                        });
                    });
                    $(".fn_select2").each(function(){
                        $(this).select2({
                            minimumResultsForSearch: 20,
                            dropdownParent: $(this).next('.dropDownSelect2')
                        });
                    });

                    price_slider_init();
                    
                    $('.fn_ajax_wait').remove();
                    
                }
            } );
        };
    
    function setSliderHandle(i, value) {
        var r = [null, null];
        r[i] = value;
        stepsSlider.noUiSlider.set(r);
        $('.fn_categories').append('<div class="fn_ajax_wait"></div>');
        ajax_slider();
    }

    let sliderConfig = {
        start: [current_min, current_max],
        connect: true,
        range: {
            'min': parseFloat(range_min),
            'max': parseFloat(range_max)
        }
    };

    if (!Number(okay.currency_cents)) {
        sliderConfig.step = 1;
    }

    noUiSlider.create(stepsSlider, sliderConfig);

    stepsSlider.noUiSlider.on('update', function (values, handle) {
        slider_all[handle].value = Number(values[handle]).toFixed(Number(okay.currency_cents));
    });

    stepsSlider.noUiSlider.on('end', function (values, handle) {
        $('.fn_categories').append('<div class="fn_ajax_wait"></div>');
        ajax_slider();
    });
    
    slider_all.forEach(function (input, handle) {

        input.addEventListener('change', function () {
            setSliderHandle(handle, this.value);
        });
        input.addEventListener('keydown', function (e) {
            var values = stepsSlider.noUiSlider.get();
            var value = Number(values[handle]);
            // [[handle0_down, handle0_up], [handle1_down, handle1_up]]
            var steps = stepsSlider.noUiSlider.steps();
            // [down, up]
            var step = steps[handle];
            var position;
            switch (e.which) {
                case 13:
                    setSliderHandle(handle, this.value);
                    break;
                case 38:
                    // Get step to go increase slider value (up)
                    position = step[1];
                    // false = no step is set
                    if (position === false) {
                        position = 1;
                    }
                    // null = edge of slider
                    if (position !== null) {
                        setSliderHandle(handle, value + position);
                    }
                    break;
                case 40:
                    position = step[0];
                    if (position === false) {
                        position = 1;
                    }
                    if (position !== null) {
                        setSliderHandle(handle, value - position);
                    }
                break;
            }
        });
    });
}

/* Document ready */
$(function(){

	// zoomImagesProduct();
	selectSort();

	$('.fn_nav_btn_close').click(function(e) {
		e.preventDefault();
	});

	// **** #Select for products sort *************************************************************
	function selectSort() {
		let selectContainer = document.querySelector(".products_sort");
		let select = document.querySelector(".products_sort__select");
		let input = document.querySelector(".products_sort__select input");
		let options = document.querySelectorAll(".products_sort__option");

				
		if (select) {
			const sortWrap = document.querySelector('.fn_products_sort');
			sortWrap.addEventListener("click", function(e) {
				selectContainer.classList.toggle("active");
			});
		}

		const optionTitles = document.querySelectorAll('.product_sort__link');
			if (optionTitles) {
				optionTitles.forEach(optionTitle => {
					if (optionTitle.classList.contains('active_up') || optionTitle.classList.contains('active_dowm')) {
						let titleSort = document.querySelector(".fn_sort_text");
						titleSort.textContent = optionTitle.children[0].textContent;
					}
				});	
			}

		if (options) {
			options.forEach((e) => {
				e.addEventListener("click", (el) => {
					input.value = e.innerText;
					selectContainer.classList.remove("active");
					options.forEach((e) => {
						e.classList.remove("selected");
					});
					e.classList.add("selected");
				});
			});
		}
	}

	// function zoomImagesProduct() {
	// 	const buttons = document.querySelectorAll('.fn_button_zoom_product'),
	// 			images = document.querySelectorAll('.gallery-top__image');
	// 			buttons.forEach(button => {
	// 				button.addEventListener("click", function(e) {
	// 					images.forEach(image => {
	// 						const dataAttr = image.dataset.zoomHref;
	// 						image.setAttribute("href", dataAttr);
	// 						image.setAttribute("data-fancybox", "we2");
	// 						$.fancybox.defaults.beforeClose = function(){ 
	// 							$('.gallery-top__image').removeAttr("href");
	// 							$('.gallery-top__image').removeAttr("data-fancybox");
	// 							$('.gallery-top__image').addClass("no_click");
	// 						};
	// 					});
	// 				});
	// 			});
	// }
	
	if ($('.fn_article_swiper').length) {
		var articleSlider = new Swiper('.fn_article_swiper', {
			spaceBetween: 15,
			loop: true,
			observer: true,
			observeParents: true,
			speed: 800,
			breakpoints: {
				320: {
					 slidesPerView: 1,

				},
				374: {
					slidesPerView: 1,
				},
				460: {
					 slidesPerView: 2,
				},
				992: {
					spaceBetween: 30,
					slidesPerView: 3,
			  },
		  }
		});
	}

		
	if ($('.fn_main_brands_slider').length) {
		var mainBrandsSlider = new Swiper('.fn_main_brands_slider', {
			spaceBetween: 15,
			loop: true,
			speed: 800,
			observer: true,
			observeParents: true,
			autoplay: {
				delay: 5000,
			},
			speed: 800,
			breakpoints: {
				320: {
					 slidesPerView: 2,
				},
				460: {
					slidesPerView: 3,
			  },
				768: {
					 slidesPerView: 4,
				},
				992: {
					slidesPerView: 5,
			  },
				1200: {
					slidesPerView: 6,
			  },
		  }
		});
	}
	


	if ($('.fn_products_preview_columns').length) {
	var productsPreviewColumnsSlider = new Swiper('.fn_products_preview_columns', {
		spaceBetween: 15,
		speed: 800,
		observer: true,
		observeParents: true,
		loop: false,
		breakpoints: {
			320: {
				 slidesPerView: 1,
			},
			374: {
				slidesPerView: 1,
			},
			480: {
				slidesPerView: 2,
			},
			768: {
				 slidesPerView: 3,
			},
			1200: {
				slidesPerView: 4,
				slidesPerColumn: 2,
				slidesPerColumnFill: 'row',
				spaceBetween: 30,
			},
	  }
	});
}

if ($('.fn_products_preview').length) {
	var productsPreviewSlider = new Swiper('.fn_products_preview', {
		spaceBetween: 15,
		speed: 800,
		observer: true,
		observeParents: true,
		loop: true,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
		breakpoints: {
			320: {
				slidesPerView: 1,
		  },
		  374: {
			  slidesPerView: 1,
		  },
		  480: {
			  slidesPerView: 2,
		  },
		  768: {
				slidesPerView: 3,
		  },
		1200: {
			slidesPerView: 4,
			spaceBetween: 30,
		},
		},
	});
}


 const preloader = document.querySelector('.fn_preloader');

 const fadeOutEffect = setInterval(() => {
	if (!preloader.style.opacity) {
	  preloader.style.opacity = 1;
	  preloader.style.pointerEvents = 'none';
	  setInterval(() => {
		preloader.style.display = 'none';
	  },100);
	}
	if (preloader.style.opacity > 0) {
	  preloader.style.opacity -= 0.1;
	} else {
	  clearInterval();
	}
 }, 5);
 
function bodyLock() {
	const body = document.querySelector('body');
	const animElemets = document.querySelectorAll('.anim_items');
	if (animElemets.length > 1) {
		body.classList.add('lock')
	}
}

bodyLock();


		//header sticky
		let header = $('.header__wrapper'),
		scrollPrev = 0;

	$(window).scroll(function() {
		var scrolled = $(window).scrollTop();
		const nav = document.querySelector('.mobile_nav');
	
		if ( scrolled > 90 && scrolled > scrollPrev ||  nav.classList.contains('nav-open')) {
			header.addClass('scroll_header');
		} else if (scrolled < 90 && scrolled < scrollPrev) {
			header.removeClass('scroll_header');
		}

		scrollPrev = scrolled;
	});

    update_delivery_module_data();
    
    /* Мега меню */
        $('.fn_category_scroll').each(function() {
            if ($(this).children('li').length > 11) {
                $(this).addClass('scroll');
            }
        });
        $('.fn_category_scroll.scroll').append('<li class="hover_scroll hover_scroll_up"></li>');
        $('.fn_category_scroll.scroll').append('<li class="hover_scroll hover_scroll_down"></li>');
        $('.hover_scroll_up').hide();
        var scrolling = false;
        $(".hover_scroll_up").bind("mouseover", function(event) {
            scrolling = true;
            scrollContent("up", this);
        }).bind("mouseout", function(event) {
            scrolling = false;
        });
        $(".hover_scroll_down").bind("mouseover", function(event) {
            scrolling = true;
            scrollContent("down", this);
        }).bind("mouseout", function(event) {
            scrolling = false;
        });

        $('.scroll').on("scroll", function() {
            var maxScrollHeight = this.scrollHeight - this.clientHeight;

            if ($(this).scrollTop() == 0) {
                $(this).find('.hover_scroll_up').hide();
            } else if (Math.round($(this).scrollTop()) == Math.round(maxScrollHeight)) {
                $(this).find('.hover_scroll_down').hide();
            } else  {
                $(this).find('.hover_scroll').show();
            }
        });
        function scrollContent(direction, test) {
            var test2 = $(test).parent();
            var amount = (direction === "up" ? "-=5px" : "+=5px");
            $(test2).animate({
                scrollTop: amount
            }, 1, function() {
                if (scrolling) {
                    scrollContent(direction, test);
                }
            });
        }


    /* Carousel products */
    if( $('.fn_products_slide').length ) {
        $('.fn_products_slide').each(function(){
        var swiper = new Swiper(this, {
            slidesPerView: 1,
            pagination: {
                el: this.querySelector('.swiper-pagination'),
                clickable: true,
            },
            navigation: {
              nextEl: ".swiper-button-next",
              prevEl: ".swiper-button-prev",
            },
            watchOverflow: true,
            breakpoints: {
                320: {
                    slidesPerView: 1,
                },
                360: {
                    slidesPerView: 2,
                },
                576: {
                    slidesPerView: 3,
                },
                768: {
                    slidesPerView: 3,
                },
                768: {
                    slidesPerView: 4,
                },
                1200: {
                    slidesPerView: 5,
                },
            }
          });
        });
    }

    /* Gallery images for product */
    if( $('.gallery-thumbs').length ) {
        var galleryThumbs = new Swiper('.gallery-thumbs', {
            spaceBetween: 30,
            slidesPerView: 3,
            loop: false,
            mousewheel: true,
            scrollbar: {
                el: '.swiper-scrollbar',
                hide: false,
              },
            breakpoints: {
                768: {
                    slidesPerView: 2,
                },
                992: {
                    slidesPerView: 3,
                }
            }
        });
        var galleryTop = new Swiper('.gallery-top', {
            spaceBetween: 0,
            loop: false,
				effect: 'fade',
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            thumbs: {
                swiper: galleryThumbs,
            },
        });
    }


    /* Mobile search */
    $(document).on("click", ".fn_search_toggle", function() {
        $(".fn_search_mob").slideToggle(300);
        return false;
    });

    /* Lazy load */
    if( $('.lazy').length ) {
        var myLazyLoad = new LazyLoad({
            elements_selector: ".lazy",
            load_delay: 100
        });
    }



    /* Select2 */
    if( $('.fn_select2').length ) {
        $(".fn_select2").each(function(){
            $(this).select2({
                minimumResultsForSearch: 20,
                dropdownParent: $(this).next('.dropDownSelect2')
            });
        });
    }

    /* Hiding blocks with great text */
    if( $('.fn_readmore').length ) {
        $('.fn_readmore').readmore({
            collapsedHeight: 215,
            lessLink: '<a href="#"><span>-</span></a>',
            moreLink: '<a href="#"><span>+</span></a>',
            afterToggle: function(trigger, element, expanded) {
                if(! expanded) { // The "Close" link was clicked
                  $('html, body').animate( { scrollTop: element.offset().top - 100 }, {duration: 300 } );
                }
              }
        });
    }

    /* Anchor to reviews */
    if( $('.fn_anchor_comments').length ) {
        $('.fn_anchor_comments').click(function(){
            $("#fn_tab_comments").trigger("click");
            var target = "[id='"+$(this).attr("href").substr(1)+"']",
                destination = $(target).offset().top - 110;
            $('body, html').animate( { scrollTop: destination }, 1000 );
            return false;
        });
    }

    /* Callback */
    $('.fn_callback').fancybox();

    // Drop down blocks
    $(document).on('click', '.fn_switch', function (e) {
        e.preventDefault();

        $(this).next().slideToggle(300);

        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
        }
        else {
            $(this).addClass('active');
        }
    });

    /* Drop down categories */
    $('.fn_catalog_switch').click(function(e){
        e.preventDefault();

        $('.fn_catalog_menu').slideToggle(300);

        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
        }
        else {
            $(this).addClass('active');
        }
    });

    /* Mobile filters */
    $('.fn_switch_mobile_filter').click(function(){

        if ($('.fn_mobile_toogle').hasClass('opened')) {
            $('.fn_mobile_toogle').removeClass('opened');
				$('body').removeClass('overlay');
        }
        else {
            $('.fn_mobile_toogle').addClass('opened');
				$('body').addClass('overlay');
        }
    });

	 $(document).on('click', function(e) {
		if (!$(e.target).closest(".fn_switch_mobile_filter,.fn_mobile_toogle").length)   {
			$('.fn_mobile_toogle').removeClass('opened');
			$('body').removeClass('overlay');
		 } 
	  });
	

    //Show list orders in user
    $( document ).on( 'click', 'a.fn_user_orders_switch', function(e) {
        e.preventDefault();
        var parent_switch = $(this).closest('tr');

        if (parent_switch.hasClass('fn_user_orders_active')) {
            parent_switch.removeClass('fn_user_orders_active');
            parent_switch.next().removeClass('fn_user_orders_show');
        }
        else {
            parent_switch.addClass('fn_user_orders_active');
            parent_switch.next().addClass('fn_user_orders_show');
        }
    });

    //Фильтры мобильные, каталог мобильные
    $(document).on('click', '.fn_switch_parent', function () {
        $(this).parent().next().slideToggle(500);
        $(this).toggleClass('down');
    });
    $('.blog_catalog .selected').parents('.parent').addClass('opened').find('> .switch').addClass('active');


    /* Tabs */
    if( $('.tabs').length ) {
        var nav = $('.tabs').find('.tabs__navigation');
        var tabs = $('.tabs').find('.tabs__content');

        if(nav.children('.selected').length > 0) {
            $(nav.children('.selected').attr("href")).show();
        } else {
            nav.children().first().addClass('selected');
            tabs.children().first().show();
        }

        $('.tabs__navigation a').click(function(e){
            e.preventDefault();
            if ($(this).hasClass('selected')){
                return true;
            }
            
            if ($(this).data('history_location')) {
                history.pushState({}, '', $(this).data('history_location'));
            }
            
            tabs.children().hide();
            nav.children().removeClass('selected');
            $(this).addClass('selected');
            $($(this).attr("href")).fadeIn(200);
        });
    }

    /* Accordion */
    if( $('.fn_accordion').length ) {
        $(".fn_accordion").on('click', '.accordion__title', function() {
            var outerBox = $(this).parents('.fn_accordion');
            var target = $(this).parents('.accordion__item');

            if($(this).hasClass('active')!==true){
                $(outerBox).find('.accordion__item .accordion__title').removeClass('active');
            }

            if ($(this).next('.accordion__content').is(':visible')){
                return false;
            }else{
                $(this).addClass('active');
                $(outerBox).children('.accordion__item').removeClass('visible');
                $(outerBox).find('.accordion__item').children('.accordion__content').slideUp(300);
                target.addClass('visible');
                $(this).next('.accordion__content').slideDown(300);
            }
        });
    }

    /* To top button */
    $(window).scroll(function () {
        var scroll_height = $(window).height();

        if ($(this).scrollTop() >= scroll_height) {
            $('.fn_to_top').addClass('show');
        } else {
            $('.fn_to_top').removeClass('show');
        }
    });

    $('.fn_to_top').click(function(){
        $("html, body").animate({scrollTop: 0}, 500);
    });

    /* Checking fields for placeholders */
    $('.form__placeholder--focus').on('blur', function() {
        if( $(this).val().trim().length > 0 ) {
            $(this).parent().addClass('filled');
        } else {
            $(this).parent().removeClass('filled');
        }
    });

    $('.form__placeholder--focus').each(function() {
        if( $(this).val().trim().length > 0 ) {
            $(this).parent().addClass('filled');
        }
    });

    $.fancybox.defaults.hash = false;
    $.fancybox.defaults.backFocus = false;

    /* Аяксовый фильтр по цене */
    if( $( '#fn_slider_price' ).length ) {

        price_slider_init();
        
        // Если после фильтрации у нас осталось товаров на несколько страниц, то постраничную навигацию мы тоже проведем с помощью ajax чтоб не сбить фильтр по цене
        $( document ).on( 'click', 'a.fn_sort_pagination_link', function(e) {
            if ($(this).closest('.fn_ajax_buttons').hasClass('fn_is_ajax')) {
                e.preventDefault();
                var link = $(this).data('href') ? $(this).data('href') : $(this).attr('href');

                $('.fn_categories').append('<div class="fn_ajax_wait"></div>');
                var send_min = $("#fn_slider_min").val();
                send_max = $("#fn_slider_max").val();
                $.ajax({
                    url: link,
                    data: {ajax: 1, 'p[min]': send_min, 'p[max]': send_max},
                    dataType: 'json',
                    success: function (data) {
                        $('#fn_products_content').html(data.products_content);
                        $('.fn_pagination').html(data.products_pagination);
                        $('.fn_products_sort').html(data.products_sort);
                        $('.fn_features').html(data.features);
                        $('.fn_selected_features').html(data.selected_features);
                        $(".fn_select2").each(function(){
                            $(this).select2({
                                minimumResultsForSearch: 20,
                                dropdownParent: $(this).next('.dropDownSelect2')
                            });
                        });
                        $(".lazy").each(function(){
                            var myLazyLoad = new LazyLoad({
                                elements_selector: ".lazy"
                            });
                        });
                        price_slider_init();

                        $('.fn_ajax_wait').remove();
                    }
                });
            }
        } );
    }


    /* Автозаполнитель поиска */
    $( ".fn_search" ).devbridgeAutocomplete( {
        serviceUrl: okay.router['ajax_search'],
        minChars: 1,
        appendTo: "#fn_search",
        maxHeight: 320,
        noCache: true,
		onSearchStart: function(params) {
            ut_tracker.start('search_products');
        },
        onSearchComplete: function(params) {
            ut_tracker.end('search_products');
        },
        onSelect: function(suggestion) {
            $( "#fn_search" ).submit();
        },
        transformResult: function(result, query) {
            var data = JSON.parse(result);
            $(".fn_search").devbridgeAutocomplete('setOptions', {triggerSelectOnValidInput: data.suggestions.length == 1});
            return data;
        },
        formatResult: function(suggestion, currentValue) {
            var reEscape = new RegExp( '(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join( '|\\' ) + ')', 'g' );
            var pattern = '(' + currentValue.replace( reEscape, '\\$1' ) + ')';
            return "<div>" + (suggestion.data.image ? "<img align='middle' src='" + suggestion.data.image + "'> " : '') + "</div>" + "<a href=" + suggestion.data.url + '>' + suggestion.value.replace( new RegExp( pattern, 'gi' ), '<strong>$1<\/strong>' ) + '<\/a>' + "<span>" + suggestion.price + " " + suggestion.currency + "</span>";
        }
    } );

    /* Слайдер в сравнении */
    if( $( '.fn_comparison_products' ).length ) {
        /* Carousel products */
        var swiper = new Swiper('.fn_comparison_products', {
            loop:false,
            slidesPerView: 1,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            watchOverflow: true,
            breakpoints: {
                320: {
                    slidesPerView: 1,
                },
                360: {
                    slidesPerView: 1,
                },
                576: {
                    slidesPerView: 2,
                },
                768: {
                    slidesPerView: 2,
                },
                992: {
                    slidesPerView: 2,
                },
                1200: {
                    slidesPerView: 3,
                },
            }
          });

        resize_comparison();

        /* Показать / скрыть одинаковые характеристики в сравнении */
        $( document ).on( 'click', '.fn_show a', function(e) {
            e.preventDefault();
            $( '.fn_show a.active' ).removeClass( 'active' );
            $( this ).addClass( 'active' );
            if( $( this ).hasClass( 'unique' ) ) {
                $( '.cell.not_unique' ).hide();
            } else {
                $( '.cell.not_unique' ).show();
            }
        } );

        /* Формирование ровных строчек для характеристик */
        function resize_comparison() {
            var minHeightHead = 0;
            $('.fn_resize' ).each(function(){
                if( $(this ).height() > minHeightHead ) {
                    minHeightHead = $(this ).height();
                }
            });
            $('.fn_resize' ).height(minHeightHead);
            if ($('[data-use]').length) {
                $('[data-use]').each(function () {
                    var use = '.' + $(this).data('use');
                    var minHeight = $(this).height();
                    if ($(use).length) {
                        $(use).each(function () {
                            if ($(this).height() >= minHeight) {
                                minHeight = $(this).height();
                            }
                        });
                        $(use).height(minHeight);
                    }
                });
            }
        }

        /* В сравнении выравниваем строки */
        if( $( '.fn_comparison_products' ).length ) {
            $(window).on('load', resize_comparison);
        }
    };

    /* Переключатель способа оплаты */
    $( document ).on( 'click', '[name="payment_method_id"]', function() {
        $( '[name="payment_method_id"]' ).parent().removeClass( 'active' );
        $( this ).parent().addClass( 'active' );
    } );
});

/* Обновление блоков: cart_informer, cart_purchases, cart_deliveries */
function ajax_set_result(data) {
    $( '#cart_informer' ).html( data.cart_informer );
    $( '#fn_purchases' ).html( data.cart_purchases );
    $( '#fn_pop_up_cart' ).html( data.pop_up_cart );
    
    if (data.cart_coupon) {
        $( '#fn_cart_coupon' ).html(data.cart_coupon);
    }
    if (data.deliveries_data) {
        for (let i in data.deliveries_data) {
            let delivery_data = data.deliveries_data[i];
            let delivery_block = $('#deliveries_' + delivery_data.id).closest('.fn_delivery_item');
            delivery_block.find('input[name="delivery_id"]').data('total_price', delivery_data.total_price_with_delivery)
                .data('delivery_price', delivery_data.price)
                .data('is_free_delivery', delivery_data.is_free_delivery);
            delivery_block.find('.fn_delivery_price').html(delivery_data.delivery_price_text);
        }
    }
    $('input[name="delivery_id"]:checked').trigger('change');
}

/* Аяксовое изменение кол-ва товаров в корзине */
function ajax_change_amount(object, variant_id) {
    let amount = $( object ).val();
    /* ajax запрос */
    $.ajax( {
        url: okay.router['cart_ajax'],
        data: {
            action: 'update_citem',
            variant_id: variant_id,
            amount: amount
        },
        dataType: 'json',
        success: function(data) {
            if( data.result == 1 ) {
                ajax_set_result( data );
            } else {
                $( '#cart_informer' ).html( data.cart_informer );
                $(".fn_ajax_content").html( data.content );
            }
        }
    } );
}

/* Функция изменения количества товаров */
function amount_change(input, action) {
    var max_val,
        curr_val = parseFloat( input.val() ),
        step = 1,
        id = input.data('id');
    if(isNaN(curr_val)){
        curr_val = okay.amount;
    }

    /* Если включен предзаказ макс. кол-во товаров ставим максимально количество товаров в заказе */
    if ( input.parent().hasClass('fn_is_preorder')) {
        max_val = okay.max_order_amount;
    } else {
        max_val = parseFloat( input.data( 'max' ) );
    }
    /* Изменение кол-ва товара */
    if( action == 'plus' ) {
        input.val( Math.min( max_val, Math.max( 1, curr_val + step ) ) );
        input.trigger('change');
    } else if( action == 'minus' ) {
        input.val( Math.min( max_val, Math.max( 1, (curr_val - step) ) ) );
        input.trigger('change');
    } else if( action == 'keyup' ) {
        input.val( Math.min( max_val, Math.max( 1, curr_val ) ) );
        input.trigger('change');
    }
    okay.amount = parseInt( input.val() );
    
    if( ($('div').is('#fn_purchases') || $('div').is('#fn_pop_up_cart:visible')) && ((max_val != curr_val && action == 'plus' ) || ( curr_val != 1 && action == 'minus' ) ) ) {
        ajax_change_amount( input, id );
    }
}

/* Аяксовый купон */
function ajax_coupon() {
    let coupon_code = $('input[name="coupon_code"]').val();
    /* ajax запрос */
    $.ajax( {
        url: okay.router['cart_ajax'],
        data: {
            coupon_code: coupon_code,
            action: 'coupon_apply'
        },
        dataType: 'json',
        success: function(data) {
            if( data.result == 1 ) {
                ajax_set_result( data );
            } else {
                $( '#cart_informer' ).html( data.cart_informer );
                $(".fn_ajax_content").html( data.content );
            }
        }
    } );
}

function update_delivery_module_data() {

    let delivery_input = $('input[name="delivery_id"]:checked');
    let delivery_id    = delivery_input.val();

    const hide_price                     = delivery_input.data('hide_front_delivery_price');
    const $fn_total_delivery_price_block = $('#fn_total_delivery_price_block');

    if (hide_price) {
        $fn_total_delivery_price_block.hide();
    } else {
        $fn_total_delivery_price_block.show();
    }

    $( '.fn_delivery_module_html input, .fn_delivery_module_html select, .fn_delivery_module_html textarea' ).attr('disabled', true);

    let delivery_block = $( '#deliveries_' + delivery_id ).closest( '.delivery__item' );
    $( delivery_block ).find('.fn_delivery_module_html input').attr('disabled', false);
    $( delivery_block ).find('.fn_delivery_module_html select').attr('disabled', false);
    $( delivery_block ).find('.fn_delivery_module_html textarea').attr('disabled', false);
}

/* Аяксовое удаление товаров в корзине */
function ajax_remove(variant_id) {
    /* ajax запрос */
    $.ajax( {
        url: okay.router['cart_ajax'],
        data: {
            action: 'remove_citem',
            variant_id: variant_id
        },
        dataType: 'json',
        success: function(data) {
            if( data.result == 1 || ($('div').is('#fn_pop_up_cart:visible'))) {
                
                ajax_set_result( data );
            } else {
                $( '#cart_informer' ).html( data.cart_informer );
                $(".fn_ajax_content").html( data.content );
            }
        }
    } );
}

/* Адаптивное видео и таблицы tiny MCE */
if( $('.block__description' ).length ) {
    $('.block__description').find('iframe').wrap('<p class="video"></p>');
    $('.block__description').find('table').wrap('<div class="table_responsive"></div>');

    $(document).ready(function() {
        $('img.fn_img_zoom').each(function(i){
            if(this.parentNode.tagName!='A'){
                $(this).wrap('<a class="fn_image_zoom" data-fancybox="fn_image_zoom'+i+'" rel="fancybox_'+i+'" href="'+this.src+'" target="_blank"/>');
            }
        });
        $('img.fn_img_gallery').each(function(i){
            if(this.parentNode.tagName!='A'){
                $(this).wrap('<a class="fn_image_gallery swiper-slide" data-fancybox="fn_image_gallery" rel="image_gallery" href="'+this.src+'" target="_blank"/>');
            }
        });
        $('img.fn_img_gallery_2').each(function(i){
            if(this.parentNode.tagName!='A'){
                $(this).wrap('<a class="fn_image_gallery_2 swiper-slide" data-fancybox="fn_image_gallery_2" rel="image_gallery_2" href="'+this.src+'" target="_blank"/>');
            }
        });
        $('img.fn_img_slider').each(function(i){
            if(this.parentNode.tagName!='A'){
                $(this).wrap('<a class="fn_image_slider swiper-slide" data-fancybox="fn_image_slider" rel="image_slider" href="'+this.src+'" target="_blank"/>');
            }
        });

        $("a.fn_image_gallery").wrapAll("<div class='fn_slider_gallery swiper-container'><div class='swiper-wrapper'></div><div class='swiper-button-next'></div><div class='swiper-button-prev'></div></div>");

        $("a.fn_image_gallery_2").wrapAll("<div class='fn_slider_gallery_2 swiper-container'><div class='swiper-wrapper'></div><div class='swiper-button-next'></div><div class='swiper-button-prev'></div></div>");
        

        $("a.fn_image_slider").wrapAll("<div class='fn_slider_mce swiper-container'><div class='swiper-wrapper'></div><div class='swiper-button-next'></div><div class='swiper-button-prev'></div></div>");


        if( $('.fn_slider_gallery').length ) {
            $('.fn_slider_gallery').each(function(){
                var swiper = new Swiper(this, {
                loop:false,
                navigation: {
                    nextEl: this.querySelector('.swiper-button-next'),
                    prevEl: this.querySelector('.swiper-button-prev'),
                },
                slidesPerView: 1,
                watchOverflow: true,
                breakpoints: {
                    768:{
                        slidesPerView: 1,
                    },
                    992:{slidesPerView: 2,}
                }
            });
        });
        }

        if( $('.fn_slider_gallery_2').length ) {
            $('.fn_slider_gallery_2').each(function(){
                var swiper = new Swiper(this, {
                loop:false,
                navigation: {
                    nextEl: this.querySelector('.swiper-button-next'),
                    prevEl: this.querySelector('.swiper-button-prev'),
                },
                slidesPerView: 1,
                watchOverflow: true,
                breakpoints: {
                    768:{
                        slidesPerView: 1,
                    },
                    992:{slidesPerView: 2,}
                }
            });
        });
        }
        
        if( $('.fn_slider_mce').length ) {
            $('.fn_slider_mce').each(function(){
                var swiper = new Swiper(this, {
                loop:false,
                navigation: {
                    nextEl: this.querySelector('.swiper-button-next'),
                    prevEl: this.querySelector('.swiper-button-prev'),
                },
                slidesPerView: 1,
                watchOverflow: true
            });
        });
        }
    });

}

//Автопереход на оплату из корзины
$(function(){
    let simpleSubmit = false;
    $(document).on('submit', 'form[name="cart"]', function(e){
        let cartForm = this;
        if (!simpleSubmit && $(this).find('input[name="payment_method_id"]:checked').data('auto_submit')) {
            e.preventDefault();
            let formData = new FormData(this);
            formData.set('ajax', 1);
            $.ajax({
                url: window.location.pathname,
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            }).done(function(response){
                if (response.hasOwnProperty('auto_submit')) {
                    if (response.auto_submit === true) {
                        e.preventDefault();
                        history.pushState({}, 'order', response.url);
                        $('<div>' + response.form + '</div>').appendTo('body').find('form').submit();
                    } else {
                        window.location = response.url;
                    }
                } else {
                    console.log('test')
                    submitted_cart = false;
                    simpleSubmit = true;
                    $(cartForm).submit();
                }
            });
        }
    });
});


function setCookie(cname, cvalue, exdays) {
  const d = new Date();
  d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
  let expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
function getCookie(cname) {
  let name = cname + "=";
  let ca = document.cookie.split(';');
  for(let i = 0; i < ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}