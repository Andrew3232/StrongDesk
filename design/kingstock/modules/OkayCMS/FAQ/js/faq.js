$(document).on('click', '.faq__question', function() {
    var outerBox = $(this).parents('.fn_faq');
    var target = $(this).closest('.faq__item');

    $(outerBox).find('.faq__content').slideUp(300);

    if($(this).hasClass('active')){
        $(outerBox).find('.faq__item').removeClass('active');
        $(outerBox).find('.faq__item.visible').removeClass('active');
        $(this).removeClass('active');
        $(target).removeClass('visible');
    }
    else
    {
        $(outerBox).find('.faq__item .faq__question').removeClass('active');
        $(this).addClass('active');
        $(target).addClass('visible');
        $(this).next('.faq__content').slideDown(300);
    }
});