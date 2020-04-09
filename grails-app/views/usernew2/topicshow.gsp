<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 20/03/20
  Time: 4:02 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>




<html>
<head>
    <title>
        Topic Show
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
            background: black;
            height: 1px;
        }
    table{
        font-size: 14px;
    }
    </style>

</head>
<body>

    <g:if test="${flash.topicExists}">
        <div class="alert alert-danger"> ${flash.topicExists}</div>
    </g:if>
    <g:if test="${flash.topicSaved}">
        <div class="alert alert-success"> ${flash.topicSaved}</div>
    </g:if>
    <div style="margin-bottom: 20px"></div>
    <g:render template="/usernew2/navbar"/>
    <div class="container">
        <div class="col-lg-6">
            <div class="panel panel-default ">
                <div class="panel-heading text">
                    <b>Topics: ${topics.name}</b>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-2">
                            <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: topics?.createdBy.id]"/>"/>
                        </div>
                        <div class="col-xs-10">
                            <div>&nbsp;${topics.name}</div>
                            <div class="row">
                                <div class="col-xs-4">
                                    <div>&nbsp;${topics.createdBy.username}</div>
                                    <g:if test="${session.name}">
                                        <div>
                                        <g:if test="${topics?.subscriptions?.user?.id?.contains(session.user)}">
                                            <g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:topics.id,userId:session.user]">
                                                &nbsp;Unsubscribe
                                            </g:link>
                                        </g:if>
                                        <g:else>
                                            <g:link action="subscribeToTopic" controller="topics" params="[topicId:topics.id]">
                                                &nbsp;Subscribe
                                            </g:link>
                                        </g:else>
                                    </div>
                                    </g:if>
                                    <g:else><g:link action="index" controller="usernew2">Log in to Subscribe</g:link></g:else>
                                </div>
                                <div class="col-xs-4">
                                    <div>Subscriptions</div>
                                    <div>${topics?.subscriptions?.size()}</div>
                                </div>
                                <div class="col-xs-4">
                                    <div>Posts</div>
                                    <div>${topics?.resources?.size()}</div>
                                </div>

                            </div>
                            <br>
                            <div class="row">
                                <div class="col-xs-6">
                                    <g:if test="${topics?.createdBy.id==session.user || session.role}">
                                        <g:select  from="${enums.Visibility?.values()}"
                                        value="${topics?.visibility}" name="visibility"
                                        optionKey="key" optionValue="value" class="form-control visibilityChange">Visibility</g:select>
                                        <input type="hidden" value="${topics?.id}"/>
                                    </g:if>
                                </div>
                                <div class="col-xs-6">
                                    <g:if test="${topics?.subscriptions?.user?.id?.contains(session.user)}">
                                        <g:select class="form-control seriousnessChange" name="seriousness" from="${enums.Seriousness?.values()}" value="${subs?.seriousness}"
                                        optionKey="key" optionValue="value"></g:select>
                                        <input type="hidden" value="${topics?.id}"/>
                                    </g:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading text">
                    <b>Users:${topics.name}</b>
                </div>
                <br>
                <table class="table useDataTable">
                    <thead><tr><th></th></tr></thead><tbody>
                    <g:each in="${topics?.subscriptions}" var="s">
                        <tr>
                            <td>
                               <div class="panel-body">
                                   <div class="row">
                                       <div class="col-xs-2">
                                           <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: s?.user?.id]"/>"/>
                                        </div>
                                        <div class="col-xs-10">
                                            <div class="row">
                                            <div class="col-xs-12">${s?.user?.firstName} ${s?.user?.lastName}</div>
                                            </div>
                                            <div class="row">
                                            <div class="col-xs-12">${s?.user?.username}</div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <div>Subscriptions</div>
                                                    <div>${s?.user?.subscriptions?.size()}</div>
                                                </div>
                                                <div class="col-xs-6">
                                                    <div>Topics</div>
                                                    <div>${s?.user?.topics?.size()}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
                </table>
            </div>
        </div>
        <div class="col-lg-6">
            <g:render template="/updateUserDetails/resourcePosts"/>
        </div>
    </div>
    <asset:javascript src="changeSeriousness.js"/>
    <asset:javascript src="changeVisibility.js"/>
    <asset:javascript src="table.js"/>
</body>
</html>