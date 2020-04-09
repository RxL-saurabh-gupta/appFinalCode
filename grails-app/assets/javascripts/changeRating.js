var temp,temp1;
var changeRating = function () {
    $.ajax({
        url:"/updateUserDetails/changeRating",
        type : "POST" ,
        data : {"score" : temp, "resource" : temp1},
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
    $(".ratingChange").change(function(){
        temp=$(this).find('option:selected').val();
        temp1=$("#resourceId").val();
        console.log($(this).find('option:selected').val(),temp1);
        changeRating();
        $("#errorsHere").html("<div class='alert alert-success'>Rating Saved</div>");
        //alert("changed"+$(this).val())
    });
});