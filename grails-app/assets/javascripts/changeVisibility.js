var temp3,temp4,temp5;
var changeVisibility = function () {
    $.ajax({
        url:"/topics/changeVisibility",
        type : "POST" ,
        data : {"se" : temp5, "topic" : temp4},
        success : function (data) {
            if(data.success==true)
            {

                //alert("Changes Saved");
            }
        } ,
        error : function () {
            //alert("Failed");
        }
    });
};


$(document).ready(function () {
    $(".visibilityChange").change(function(){
        temp3=$(this);
        temp4=$(temp3).siblings().val();
        temp5=$(this).find('option:selected').val();
        console.log($(this).find('option:selected').val(),$(temp).siblings().val());
        changeVisibility();
        $("#errorsHere").html("<div class='alert alert-success'>Visibility Changed</div>");
    });
});