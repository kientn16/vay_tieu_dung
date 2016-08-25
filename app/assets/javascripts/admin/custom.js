/**
 * Created by yamon on 8/25/16.
 */
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});

function accept_drawdowns(id,url) {
    var r = confirm("Are you sure Accept This Drawdowns");
    if (r == true) {
        $.ajax({
            type: "POST",
            url: url,
            data: {drawdowns_id: id},
            success: function(result) {

            }
        });
    } else {
        return
    }
}

function un_accept_drawdowns(id,url) {
    var r = confirm("Are you sure Un Accept This Drawdowns");
    if (r == true) {
        $.ajax({
            type: "POST",
            url: url,
            data: {drawdowns_id: id},
            success: function(result) {

            }
        });
    } else {
        return
    }
}