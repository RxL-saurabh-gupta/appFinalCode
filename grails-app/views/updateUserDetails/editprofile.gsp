<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 23/03/20
  Time: 5:17 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>
        Edit Profile
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>

</head>
<body>
<g:if test="${flash.updateUnameUnique}">
<div class="alert alert-danger">
    ${flash.updateUnameUnique}</div>
</g:if>
<div id="errordisplay"></div>
<g:render template="/usernew2/navbar"/>
<div class="container">
    <div class="col-lg-5">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2">


                        <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: userprofile?.id]"/>"/>


                    </div>
                    <div class="col-xs-10">
                        <div> ${userprofile?.firstName} ${userprofile?.lastName}</div>
                        <div> ${userprofile?.username}</div>
                        <div class="col-xs-6">
                            <div>Subscriptions</div>
                            <div class="blueColor">${userprofile?.subscriptions?.size()}</div>
                        </div>
                        <div class="col-xs-6">
                            <div>Topics</div>
                            <div class="blueColor">${userprofile?.topics?.size()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <div class="panel panel-default">
            <div class="panel-heading text">
                <b>Topics</b>
            </div>
            <br>
            <table class="table useDataTable">
                <thead><tr><th></th></tr></thead><tbody>
            <g:each in="${publicUserTopics}" var="a">
                <tr>
             <td>
                <div class="panel-body">
                    <div class="col-xs-6">
                        <div>
                        <g:link controller="topics" action="topicsShow" params="[topicShowId:a?.id]">${a?.name}</g:link></div>
                        <br>
                        <div>
                            <g:if test="${session.role || a?.createdBy?.id==session.user}">
                                <g:select  from="${enums.Visibility?.values()}"
                                           value="${a?.visibility}" name="visibility"
                                           optionKey="key" optionValue="value" class="form-control visibilityChange">Visibility</g:select>
                                <input type="hidden" value="${a?.id}"/>
                            </g:if>
                        </div>
                        %{--                    <g:if test="${list?.user?.id?.contains(session.user)}">--}%
                        %{--                        <g:select class="form-control seriousnessChange" name="seriousness" from="${enums.Seriousness?.values()}" value="${subs?.seriousness}"--}%
                        %{--                                  optionKey="key" optionValue="value"></g:select>--}%
                        %{--                        <input type="hidden" value="${a?.id}"/>--}%


                        %{--                    </g:if>--}%
                    </div>
                    <div class="col-xs-3">
                        <div>Subscriptions</div>
                        <div>${a?.subscriptions?.size()}</div>
                    </div>
                    <div class="col-xs-3">
                        <div>Posts</div>
                        <div>${a?.resources?.size()}</div>
                    </div>
                </div>
             </td></tr>
            </g:each>

            <g:each in="${privateUserTopics}" var="b">
                <g:if test="${b?.subscriptions?.user?.id?.contains(session.user) || session.role}">
                    <tr>
          <td>
                 <div class="panel-body">
                     <div class="col-xs-6">
                            <g:link controller="topics" action="topicsShow" params="[topicShowId:b?.id]">${b?.name}</g:link>
                            <div>
                                <g:if test="${session.role || b?.createdBy?.id==session.user}">
                                    <g:select  from="${enums.Visibility?.values()}"
                                               value="${b?.visibility}" name="visibility"
                                               optionKey="key" optionValue="value" class="form-control visibilityChange">Visibility</g:select>
                                    <input type="hidden" value="${b?.id}"/>
                                </g:if>
                            </div>
                            %{--                        <div>--}%
                            %{--                        <g:if test="${list?.user?.id?.contains(session.user)}">--}%
                            %{--                            <g:select class="form-control seriousnessChange" name="seriousness" from="${enums.Seriousness?.values()}" value="${list.topic.find{it.id==b?.id}.visibility}"--}%
                            %{--                                      optionKey="key" optionValue="value"></g:select>--}%
                            %{--                            <input type="hidden" value="${b?.id}"/>--}%


                            %{--                        </g:if>--}%
                            %{--                        </div>--}%
                        </div>
                        <div class="col-xs-3">
                            <div>Subscriptions</div>
                            <div>${b?.subscriptions?.size()}</div>
                        </div>
                        <div class="col-xs-3">
                            <div>Posts</div>
                            <div>${b?.resources?.size()}</div>
                        </div>
                    </div>
          </td></tr>
                </g:if>
            </g:each>
            </tbody></table>

        </div>


    </div>
    <div class="col-lg-7">
        <div class="panel panel-default">
            <div class="panel-heading text">
                <b>Profile</b>
            </div>
            <div class="panel-body">
                <g:uploadForm action="updateUserInfo" controller="updateUserDetails" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-4 control-label">First Name:</label>
                        <div class="col-lg-8">
                            <input type="text" class="form-control" name="fname" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">Last Name: </label>
                        <div class="col-lg-8">
                            <input class="form-control" type="text" name="lname" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">Username: </label>
                        <div class="col-lg-8">
                            <input type="text" class="form-control" name="uname" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">Photo</label>
                        <div class="col-lg-8">
                            <input type="file" name="photo" accept="image/*" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-8">
                        </div>
                        <div class="col-lg-4">
                            <button type="submit" name="register" id="btnUpdate1" class="btn btn-primary" align="right">Update</button>
                        </div>
                    </div>
                </g:uploadForm>

            </div>


        </div>
        <div class="panel panel-default">
            <div class="panel-heading text">
                <b>Change password</b>
            </div>
            <div class="panel-body">
                <g:uploadForm controller="updateUserDetails" action="updateUserPassword" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-4 control-label">Password: </label>
                        <div class="col-lg-8">
                            <input  type="password" minlength="8" name="password1" id="txtPassword" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">Confirm Password: </label>
                        <div class="col-lg-8">
                            <input type="password" class="form-control"  minlength="8" id="txtConfirmPassword" name="password2" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-8">
                        </div>
                        <div class="col-lg-4">
                            <button type="submit" name="register" id="btnUpdate" class="btn btn-primary" align="right">Update</button>
                        </div>
                    </div>
                </g:uploadForm>
            </div>


        </div>
    </div>

</div>
<script type="text/javascript">
    $(function () {
        $("#btnUpdate").click(function () {
            var password = $("#txtPassword").val();
            var confirmPassword = $("#txtConfirmPassword").val();
            if (password != confirmPassword) {
                document.getElementById("errordisplay").innerHTML="Passwords do not match";
                $("#errordisplay").html("<div class='alert alert-danger'>Passwords do not match</div>");
                window.scrollTo(0, 0);
                return false;
            }
            return true;
        });
    });
</script>
<asset:javascript src="changeSeriousness.js"/>
<asset:javascript src="changeVisibility.js"/>
<asset:javascript src="table.js"/>
</body>
</html>