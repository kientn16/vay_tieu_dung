$(document).ready(function() {
    $('body').on('click', '.btn-upload-file', function(e) {
        e.preventDefault();
        var id = $(this).attr('data-item-id');
        if(typeof id !== 'undefined') {
            $(id).click();
        }
    });
    $('body').on('click', '.btn-draft', function(e){
        e.preventDefault();
        $('#input-hidden-draft').val(1);
        $(this).parents('form').submit();
    });

    $('body').on('click', '.btn-send', function(e){
        e.preventDefault();
        $('#input-hidden-draft').val(0);
        $(this).parents('form').submit();
    });
    $("#range-money").ionRangeSlider({
        type: "single",
        min: 0,
        max: 10000000,
        from: 2000000,
        to: 5000000,
        grid: true,
        grid_num: 5,
        step: 500000,
        prettify_enabled: true,
        prettify_separator: ' ',
        postfix: 'VNĐ',
        to_shadow: true,
        hide_min_max: true,
        hide_from_to: true,
        onChange: function(data) {
            var labelId = $(data.input).attr('data-label-id');
            money = data.from/1000000
            $(labelId).text(money + " Triệu");
        },
        onStart: function (data){
            var labelId = $(data.input).attr('data-label-id');
            money = data.from/1000000
            $(labelId).text(money + " Triệu");
        }
    });
    $("#range-time").ionRangeSlider({
        type: "single",
        values: [
            "12 tháng", "18 tháng", "24 tháng"
        ],
        grid: true,
        hide_min_max: true,
        hide_from_to: true,
        onChange: function(data) {
            var labelId = $(data.input).attr('data-label-id');
            // money = data.from/1000000
            $(labelId).text(data.from_value);
        },
        onStart: function (data){
            var labelId = $(data.input).attr('data-label-id');
            $(labelId).text(data.from_value);
        }
    });

    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true
    });

    $(".refresh_image").click(function() {
        $('#captcha').load("/users/dashboard/refresh_captcha_div");
    });
})
