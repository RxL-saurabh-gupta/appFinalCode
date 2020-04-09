<%--
  Created by IntelliJ IDEA.
  User1: saurabh
  Date: 19/03/20
  Time: 9:48 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>
        Home Page
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
        .panel-default
        {
            border-color:black;
            border-width: 1px;
        }
        .imageborder{
            border: solid;
            border-color: black;
            border-width: 1px;
        }
        hr{
            height:1px;
            background: black;
        }
    </style>
</head>
<body>



    <g:if test="${flash.message}">
        <div class="alert alert-danger"> ${flash.message}</div>
    </g:if>


    <g:render template="navbar"/>
    <div class="container">
        <div class="row">
            <div class="col-lg-7">
                <div class="panel panel-default ">
                    <div class="panel-heading text">
                        <b>Recent Shares</b>
                    </div>
                    <g:each in="${list}" var="u" status="i">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-2">
        %{--                            <h3>${u?.createdBy.id}</h3>--}%
                                    <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:u?.createdBy?.id]">
                                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: u?.createdBy.id]"/>"/>
                                    </g:link>
                                </div>
                                <div class="col-xs-10">
                                <div class="row">
                                    <div class="col-xs-4"><b>${u?.createdBy?.firstName} ${u?.createdBy?.lastName}</b></div>
                                    <div class="col-xs-5">
                                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:u?.createdBy?.id]">
                                            ${u?.createdBy?.username}
                                        </g:link>
                                    </div>
                                    <div style="float: right" class="col-xs-3">
                                        <g:link controller="topics" action="topicsShow" params="[topicShowId:u?.topic.id]">
                                            ${u?.topic.name}
                                        </g:link>
                                    </div>
                                </div>
                                    <br>
                                <div class="row">
                                    <div class="col-xs-12">
                                    <g:if test="${u?.description}">${u?.description}</g:if>
                                    </div>

                                </div>
                                    <br>
                                <div class="row">
                                    <div class="col-xs-12">
                                    <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:u?.id]">
                                        View Post
                                    </g:link>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                        <hr/>
                    </g:each>
                </div>
                <g:render template="topPosts"/>
            </div>
            <div class="col-lg-5">
                <g:render template="loginRegister"/>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#btnSubmit").click(function () {
                var password = $("#txtPassword").val();
                var confirmPassword = $("#txtConfirmPassword").val();
                if (password != confirmPassword) {
                    document.getElementById("errordisplay").innerHTML="Passwords do not match";
                    $("#errordisplay").html("<div class='alert alert-danger'>Passwords do not match</div>");
                    //window.scrollTo(0, 0);
                    return false;
                }
                return true;
            });
        });
    </script>
    <g:render template="forgotPasswordModal"/>

</body>
</html>