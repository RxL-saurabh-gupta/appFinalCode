
var temp,temp1,temp2;
var changeSeriousness = function () {
    $.ajax({
        url:"/topics/changeSeriousness",
        type : "POST" ,
        data : {"se" : temp2, "topic" : temp1},
        success : function (data) {
            if(data.success==true)
            {

                //alert("Changes Saved")
            }
        } ,
        error : function () {
            //alert("Failed");
        }
    });
};


$(document).ready(function () {
    $(".seriousnessChange").change(function(){
    temp=$(this);
    temp1=$(temp).siblings().val()
        temp2=$(this).find('option:selected').val()
        console.log($(this).find('option:selected').val(),$(temp).siblings().val());
        changeSeriousness();
        $("#errorsHere").html("<div class='alert alert-success'>Seriousness Changed</div>");
    });
});
