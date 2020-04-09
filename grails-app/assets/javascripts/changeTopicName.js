var a,b,c;
$(document).ready(function () {
    $(".editTopicName").click(function(){
        var a= $(this).parentsUntil("div.parentClass");
        a.find("input.newTopicName").attr("disabled",false);
        a.find("button.saveNewName").attr("disabled",false);
    });

});