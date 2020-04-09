// var createTopic = function () {
//     $.ajax({
//         url:"/topics/savetopic",
//         type : "POST" ,
//         data : {"name":$("#tname").val(),"visibility":$("#visible").val()},
//         success : function (data) {
//             if(data.success==true)
//             {
//                 console.log(data);
//                 alert("Thank you"+data.user.username)}
//         } ,
//         error : function () {
//             alert("Topic Save Failed");
//         }
//     });
// };
// $(document).ready(function () {
//     $("#saveTopicButton").click(function(){
//         createTopic();
//         location.reload()
//     });
// });
