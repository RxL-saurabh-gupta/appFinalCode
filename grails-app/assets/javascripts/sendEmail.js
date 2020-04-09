var temp,temp1,temp2;


$(document).ready(function () {
    $(".topicChange").change(function(){
        $("#emailSubject").val("You are invited to subscribe this topic");
        temp=$(this).find('option:selected').val();
        temp2="1.You first need to login(register if not a member to subscribe)"+"\n"+"2.Then click on the link given below";
        temp1="http://localhost:9090/topics/topicsShow?topicShowId=";
        var newValue = temp2+"\n"+temp1+temp;
        $("#emailMessage").val(newValue);
        console.log($(this).find('option:selected').val(),temp1);


        //alert("changed"+$(this).val())
    });
});