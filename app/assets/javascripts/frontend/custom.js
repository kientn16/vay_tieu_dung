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
            setValueMoney(data);
        },
        onStart: function (data){
            setValueMoney(data);
        }
    });
    var timeValue = 3;
    $("#range-time").ionRangeSlider({
        type: "single",
        values: [
            "12 tháng", "24 tháng", "36 tháng"
        ],
        grid: true,
        hide_min_max: true,
        hide_from_to: true,
        onChange: function(data) {
            setValueTime(data);
        },
        onFinish: function (data) {
            setValueTime(data);
        },
        onStart: function (data){
            setValueTime(data);
        },
        onUpdate: function (data){
            // setValueTime(data);
            
            alert($('#range-time').val());
        }
    });
    var slider = $("#range-time").data("ionRangeSlider");
    console.log(slider);

    $('body').on('click', 'button.btn-drawdown', function(e){
        $('#range-time').val(timeValue);
    });

    function setValueMoney(data){
        var labelId = $(data.input).attr('data-label-id');
        money = data.from/1000000
        $(labelId).text(money + " Triệu");
        $(data.input).val(data.from);
    }

    function setValueTime(data){
        var labelId = $(data.input).attr('data-label-id');
        // money = data.from/1000000
        value = data.from_value.split(' ');
        if (typeof value[0] != 'undefined') {
            if (value[0] == 12) {
                value = 3;
            }else if(value[0] == 24){
                value = 2;
            } else if(value[0] == 36){
                value = 1;
            } else{
                value = 1;
            }
        }else{
            value = 3;
        }
        var id = $(data.input).attr('id');
        $('#' + id).val(value);
        timeValue = value;
        $(labelId).text(data.from_value);
    }

    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true
    });

    $(".refresh_image").click(function() {
        $('#captcha').load("/users/dashboard/refresh_captcha_div");
    });

    $(".show-drawdowns").colorbox({width:"850px"});
});

function select_district(val,url){
    $.ajax({
        type: "POST",
        url: url,
        data: {province_id: val},
        success: function(result) {
            $("#data-district").empty();
            $("#data-district").append("<option value=''>Chọn Huyện </option>");
            $.each(result, function(i, item) {
                $("#data-district").append("<option value='"+item.id+"'>"+item.name+"</option>")
            })
        }
    });
}

function select_ward(val,url){
    $.ajax({
        type: "POST",
        url: url,
        data: {province_id: val},
        success: function(result) {
            $("#data-ward").empty();
            $("#data-ward").append("<option value=''>Chọn Phường/Xã </option>");
            $.each(result, function(i, item) {
                $("#data-ward").append("<option value='"+item.id+"'>"+item.name+"</option>")
            })
        }
    });
}
