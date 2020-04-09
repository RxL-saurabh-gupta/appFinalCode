<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 05/04/20
  Time: 7:35 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>
        All Topics
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <style>
        .panel-default{
            border-color: black;
            border-width: 1px;
        }
        hr{
            height: 1px;
            background: black;
        }
        .imageborder{
            border: solid;
            border-color: black;
            border-width: 1px;
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
                <div class="col-xs-10" style="font-size: 30px">Topics</div>
                <div class="col-xs-2">
                </div>
            </div>
            <div id="errorsHere"></div>
        </div>
        <br>
        <table class="table" id="allSystemTopics">
            <thead><tr><th></th></tr></thead><tbody>
<g:each in="${allSystemTopics}" var="t" status="p">
    <tr>
               <td>
   <div class="panel-body">

       <div class="row">
           <div class="col-xs-2">
                <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.createdBy?.id]">
                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: t?.createdBy?.id]"/>"/>
                </g:link>
            </div>
            <div class="col-xs-10">
<div>
                <g:link controller="topics" action="topicsShow" params="[topicShowId:t?.id]">
                    ${t?.name}
                </g:link>
</div>
                <br>
                <div class="row">
                    <div class="col-xs-4">
                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.createdBy?.id]">
                            <div>${t.createdBy?.username}</div>
                        </g:link>

                        <div>
                            <g:if test="${t?.subscriptions?.user.id.contains(session.user)}">
                                <g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:t?.id,userId:session.user]">
                                    Unsubscribe
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link action="subscribeToTopic" controller="topics" params="[topicId:t?.id]">
                                    Subscribe
                                </g:link>
                            </g:else>
%{--                            <g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:t?.id,userId:t?.id]">Unsubscribe</g:link>--}%
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div>Subscriptions</div>
                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.createdBy?.id]">
                            <div>${t?.subscriptions?.size()}</div>
                        </g:link>
                    </div>
                    <div class="col-xs-4">
                        <div>Posts</div>
                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.createdBy?.id]">
                            <div>${t?.resources?.size()}

                            %{--                                <g:createLink controller="usernew2" action="goToDash" params="[user: t?.topic.createdBy.id]"/>--}%
                            %{--                                <h2>${count}</h2>--}%
                            </div>
                        </g:link>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-xs-4">

        </div>
            <div class="col-xs-2">
                <g:if test="${session.role || t?.createdBy?.id==session.user}">
                    <g:select  from="${enums.Visibility?.values()}"
                               value="${t?.visibility}" name="visibility"
                               optionKey="key" optionValue="value" class="form-control visibilityChange">Visibility</g:select>
                    <input type="hidden" value="${t?.id}"/>
                </g:if>
            </div>
            <div class="col-xs-2">
                <i data-toggle="modal" style="margin-right: 5px;font-size: 25px" data-target="#myModal3" class="fa fa-envelope "></i>



                <g:if test="${session.role || t?.createdBy?.id==session.user}">
                    <g:link action="deleteTopic" controller="topics" params="[topicId:t?.id,userId:t?.id]"><i class="far fa-trash-alt" style="margin-right: 5px;font-size: 25px"></i></g:link>

                %{--                        <g:link controller="usernew2" action="index">--}%

                %{--                        </g:link>--}%
                </g:if>
            </div>
            <div class="col-xs-4">
                <g:if test="${session.role || t?.createdBy?.id==session.user}">
                    <div class="row parentClass">
                        <g:uploadForm controller="topics" action="changeTopicName" method="post">
                            <div class="col-xs-6">
                                <input type="text" name="topicNewName" value="${t?.name}" class="newTopicName form-control" disabled/>
                                <input type="hidden" value="${t?.id}" name="topicId"/>
                            </div>
                            <div class="col-xs-3">
                                <button type="submit" class="btn btn-light saveNewName" disabled>Save</button>
                            </div>
                            <div class="col-xs-3">
                                <i class="far fa-edit editTopicName" style="margin-right: 5px;font-size: 25px"></i></div>
                        </g:uploadForm>
                    </div>
                </g:if>
            </div>
        </div>
    </div>
    <br><br>
               </td></tr>
</g:each></tbody></table>
    </div>
    </div>
</div>
<asset:javascript src="changeSeriousness.js"/>
<asset:javascript src="changeVisibility.js"/>
<asset:javascript src="changeTopicName.js"/>
<asset:javascript src="table.js"/>
</body>
</html>