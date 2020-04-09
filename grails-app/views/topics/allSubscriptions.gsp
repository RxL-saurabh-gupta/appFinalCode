<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 08/04/20
  Time: 11:09 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>
        Subscriptions
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
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
        height: 1px;
        background: black;
    }
    i{
        color: black;
    }
    </style>

</head>
<body>
<g:render template="/usernew2/navbar"/>
<div class="container">
    <div class="col-sm-10 col-sm-offset-1">
    <div class="panel panel-default ">
        <div class="panel-heading text">
            <div class="row">
                <div class="col-xs-10" style="font-size: 30px">Subscriptions</div>
                <div class="col-xs-2">
                </div>
            </div>
            <div id="errorsHere"></div>
        </div>
        <br>
        <table class="table" id="subscriptionsTable2">
            <thead><tr><th></th></tr></thead><tbody>
        <g:each in="${list}" var="${t}">

            <tr>
                <td>
                    <div class="panel-body helping">
                        <div class="row">
                            <div class="col-xs-2">
                                <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: t?.topic?.createdBy?.id]"/>"/>
                                </g:link>
                            </div>
                            <div class="col-xs-10">
                                <g:link controller="topics" action="topicsShow" params="[topicShowId:t?.topic.id]">
                                    ${t?.topic.name}
                                </g:link>
                                <div class="row">
                                    <div class="col-xs-3">
                                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                            <div>${t?.topic?.createdBy?.username}</div>
                                        </g:link>
                                        <div><g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:t?.topic.id,userId:t?.user.id]">Unsubscribe</g:link></div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div>Subscriptions</div>
                                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                            <div>${t?.topic?.subscriptions?.size()}</div>
                                        </g:link>
                                    </div>
                                    <div class="col-xs-3">
                                        <div>Posts</div>
                                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                            <div>${t?.topic?.resources?.size()}
                                            </div>
                                        </g:link>
                                    </div>
                                <div class="col-xs-3"></div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-xs-3">
                                <g:select class="form-control seriousnessChange"  name="seriousness" id="changeit" from="${enums.Seriousness?.values()}" value="${t?.seriousness}" optionKey="key" optionValue="value">
                                    Seriousness
                                </g:select>
                                <input type="hidden" class="topicUniqueClass" value="${t?.topic?.id}">
                            </div>
                            <div class="col-xs-2">
                                <g:if test="${session.role || t?.topic?.createdBy?.id==session.user}">
                                    <g:select  from="${enums.Visibility?.values()}"
                                               value="${t?.topic?.visibility}" name="visibility"
                                               optionKey="key" optionValue="value" class="form-control visibilityChange">Visibility</g:select>
                                    <input type="hidden" value="${t?.topic?.id}"/>
                                </g:if>
                            </div>
                            <div class="col-xs-2">
                                <i data-toggle="modal" style="margin-right: 10px;font-size: 25px" data-target="#myModal3" class="fa fa-envelope "></i>
                                <g:if test="${session.role || t?.topic?.createdBy.id==session.user}">
                                    <g:link action="deleteTopic" controller="topics" params="[topicId:t?.topic.id,userId:t?.user.id]"><i class="far fa-trash-alt" style="font-size: 25px"></i></g:link>
                                </g:if>
                            </div>
                            <div class="col-xs-5"><span>
                                <g:if test="${session.role || t?.topic?.createdBy.id==session.user}">
                                    <div class="row parentClass">
                                        <g:uploadForm controller="topics" action="changeTopicName" method="post">
                                            <div class="col-xs-7">
                                                <input type="text" name="topicNewName" value="${t?.topic?.name}" class="newTopicName form-control" disabled/>
                                                <input type="hidden" value="${t?.topic?.id}" name="topicId"/>
                                            </div>
                                            <div class="col-xs-3">
                                                <button type="submit" class="btn btn-primary saveNewName" disabled>Save</button>
                                            </div>
                                            <div class="col-xs-2">
                                                <i class="far fa-edit editTopicName" style="margin-right: 5px;font-size: 25px"></i></div>
                                        </g:uploadForm>
                                    </div>
                                </g:if>
                            </span></div>
                        </div>
                        <br>

                    </div>
                </td>
            </tr>
        </g:each>
        </tbody>
        </table>
    </div>
    </div>
</div>
<asset:javascript src="table.js"/>
<asset:javascript src="changeSeriousness.js"/>
<asset:javascript src="changeVisibility.js"/>
<asset:javascript src="changeTopicName.js"/>
</body>
</html>