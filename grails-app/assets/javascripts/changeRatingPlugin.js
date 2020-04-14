var rating,temp1
var changeRating = function () {
    $.ajax({
        url:"/updateUserDetails/changeRating",
        type : "POST" ,
        data : {"score" : rating, "resource" : temp1},
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






$(function () {
    var ratingOld=$("#presentRating").val();
    //console.log(ratingOld);
    if(!ratingOld)
    {
        ratingOld=0;
    }
    var $rateYo = $("#rateYo").rateYo({
        precision:0,
        rating:ratingOld});

    $("#rateYo").click(function () {

        /* get rating */
        rating = $rateYo.rateYo("rating");
        temp1=$("#resourceId").val();
        changeRating();
        //window.alert("Its " + rating + " Yo!");
    });

});