$(document).ready(function() {
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
})
