<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 23/03/20
  Time: 5:16 PM
--%>

<html>
    <head>
        <title>
            Dashboard
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
        table{
            font-size: 14px;
        }
        .imageborder{
            border: solid;
            border-color: black;
            border-width: 1px;
        }
        .blueColor{
            color: blue;
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

        <g:if test="${flash.topicExists}">
            <div class="alert alert-danger" id="topicExists">
                ${flash.topicExists}
            </div>
        </g:if>
        <g:if test="${flash.topicSaved}">
            <div class="alert alert-success" id="topicSaved">
                ${flash.topicSaved}
            </div>
        </g:if>
        <g:if test="${flash.cannotUnsubscribe}">
            <div class="alert alert-danger"> ${flash.cannotUnsubscribe}</div>
        </g:if>
        <g:if test="${flash.message}">
            <div class="alert alert-success"> ${flash.message}</div>
        </g:if>
        <g:if test="${flash.message1}">
            <div class="alert alert-success"> ${flash.message1}</div>
        </g:if>
        <g:if test="${flash.nameChanged}">
            <div class="alert alert-success"> ${flash.nameChanged}</div>
        </g:if>

        <g:render template="navbar"/>
        <div class="container">

            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-2">
                                <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:session.user]">
                                    <img class="imageborder"  style="width: 70px;height: 80px;" src="data:image/jpg;base64,${session.getAttribute("userPhoto")}"/>
                                </g:link>
                            </div>
                            <div class="col-xs-10">
                                <div> ${session.fname} ${session.lname}</div>
                                <div> ${session.name}</div>
                                <div class="col-xs-6">
                                    <div>Subscriptions</div>
                                    <div class="blueColor">${user?.subscriptions?.size()}</div>
                                </div>
                            <div class="col-xs-6">
                                <div>Topics</div>
                                <div class="blueColor">${user?.topics?.size()}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default ">
                <div class="panel-heading text">
                    <div class="row">
                        <div class="col-xs-8"><b>Subscriptions</b></div>
                            <div class="col-xs-4">
                                <g:link controller="topics" action="allUserSubscriptions">View all</g:link>
                            </div>
                    </div>
                    <div id="errorsHere"></div>
                </div>
                <br>
                <table class="table" id="subscriptionsTable">
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
                                                <div>
                                                    <g:link controller="topics" action="topicsShow" params="[topicShowId:t?.topic.id]">
                                                        ${t?.topic.name}
                                                    </g:link>
                                                </div>
                                                <br>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                                            <div>${t?.topic?.createdBy?.username}</div>
                                                        </g:link>
                                                    <div>
                                                        <g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:t?.topic.id,userId:t?.user.id]">
                                                            Unsubscribe
                                                        </g:link>
                                                    </div>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <div>Subscriptions</div>
                                                        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                                            <div>${t?.topic?.subscriptions?.size()}</div>
                                                        </g:link>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <div>Posts</div>
                                                            <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                                                <div>${t?.topic?.resources?.size()}
                                                                </div>
                                                            </g:link>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <g:select class="form-control seriousnessChange"  name="seriousness" id="changeit" from="${enums.Seriousness?.values()}" value="${t?.seriousness}" optionKey="key" optionValue="value">
                                                    Seriousness
                                                </g:select>
                                                <input type="hidden" class="topicUniqueClass" value="${t?.topic?.id}">
                                            </div>
                                            <div class="col-xs-4">
                                                <g:if test="${session.role || t?.topic?.createdBy?.id==session.user}">
                                                        <g:select  from="${enums.Visibility?.values()}"
                                                        value="${t?.topic?.visibility}" name="visibility"
                                                        optionKey="key" optionValue="value" class="form-control visibilityChange">Visibility</g:select>
                                                        <input type="hidden" value="${t?.topic?.id}"/>
                                                </g:if>
                                            </div>
                                            <div class="col-xs-4">
                                                <i data-toggle="modal" style="margin-right: 10px;font-size: 25px" data-target="#myModal3" class="fa fa-envelope "></i>
                                                <g:if test="${session.role || t?.topic?.createdBy.id==session.user}">
                                                    <g:link action="deleteTopic" controller="topics" params="[topicId:t?.topic.id,userId:t?.user.id]"><i class="far fa-trash-alt" style="font-size: 25px"></i></g:link>
                                                </g:if>
                                            </div>
                                        </div>
                                        <br>
                                        <g:if test="${session.role || t?.topic?.createdBy.id==session.user}">
                                            <div class="row parentClass" style="margin-top: 5px;">
                                                <g:uploadForm controller="topics" action="changeTopicName" method="post">
                                                    <div class="col-xs-6">
                                                        <input type="text" name="topicNewName" value="${t?.topic?.name}" class="newTopicName form-control" disabled/>
                                                        <input type="hidden" value="${t?.topic?.id}" name="topicId"/>
                                                    </div>
                                                    <div class="col-xs-2">
                                                        <button type="submit" class="btn btn-primary saveNewName" disabled>Save</button>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <i class="far fa-edit editTopicName" style="margin-right: 5px;font-size: 25px"></i>
                                                    </div>
                                                </g:uploadForm>
                                            </div>
                                        </g:if>
                                    </div>
                                    <br>
                                </td>
                            </tr>
                        </g:each>
                </tbody>
                </table>
            </div>
        <g:render template="trendingTopics"/>
            </div>
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading text">
                        <b>Inbox</b>
                    </div>
                    <br>
                    <table class="table" id="inboxTable">
                        <thead><tr><th></th></tr></thead><tbody>
                            <g:each in="${unreadResources}" var="k">
                                <tr>
                                    <td>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-xs-2">
                                                    <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:k?.resource?.createdBy?.id]">
                                                            <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: k?.resource?.createdBy?.id]"/>"/>
                                                    </g:link>
                                                </div>
                                                <div class="col-xs-10">
                                                    <div class="row">
                                                        <div class="col-xs-5"> <b>${k?.resource?.createdBy?.firstName} ${k?.resource?.createdBy?.lastName}</b></div>
                                                        <div class="col-xs-3">
                                                            <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:k?.resource?.createdBy?.id]">
                                                                ${k?.resource?.createdBy?.username}
                                                            </g:link>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <g:link controller="topics" action="topicsShow" params="[topicShowId:k?.resource?.topic?.id]">${k?.resource?.topic?.name}</g:link>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            ${k?.resource?.description}
                                                        </div>
                                                    </div>
                                                    <br>

                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-xs-2">
                                                    <i class="fab fa-facebook-square " style="font-size: 20px"></i>
                                                    <i class="fab fa-twitter-square  " style="margin-left: 5px; font-size: 20px"></i>
                                                </div>
                                                <div class="col-xs-3">
                                                    <g:if test="${allLinkResources.id.contains(k?.resource?.id?.toLong())}">
                                                        <a href="${allLinkResources.find{it.id==k?.resource?.id}.url}" target="_blank">
                                                            view full site
                                                        </a>
                                                    </g:if>
                                                    <g:else>
                                                        <g:link action="downloadDocumentResource" controller="topics" params="[drId:k?.resource?.id]">Download</g:link>
                                                    </g:else>
                                                </div>
                                                <div class="col-xs-3">
                                                    <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:k?.resource?.id]">
                                                        View Post
                                                    </g:link>
                                                 </div>
                                                 <div class="col-xs-4">
                                                     <g:link controller="updateUserDetails" action="markAsRead" params="[resourceId: k?.resource?.id]">
                                                         <div align="center">Mark as Read</div>
                                                     </g:link>
                                                 </div>
                                            </div>
                                        </div>
                                        <br>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <asset:javascript src="changeSeriousness.js"/>
        <asset:javascript src="changeVisibility.js"/>
        <asset:javascript src="changeTopicName.js"/>
        <asset:javascript src="table.js"/>
    </body>
</html>