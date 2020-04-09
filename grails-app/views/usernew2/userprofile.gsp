<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 23/03/20
  Time: 5:13 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>
        User Profile
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
    .imageborder{
        border: solid;
        border-color: black;
        border-width: 1px;
    }
    table{
        font-size: 14px;
    }
    </style>

</head>
<body>

<g:render template="/usernew2/navbar"/>

<div class="container">
    <div class="col-lg-6">


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
                    <div><g:link controller="topics" action="topicsShow" params="[topicShowId:a?.id]">${a?.name}</g:link>
                    </div><br>
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
                <g:if test="${session.role || b?.subscriptions?.user?.id.contains(session.user) }">
                    <tr>
             <td>
               <div class="panel-body">
                   <div class="col-xs-6">
                        <div> <g:link controller="topics" action="topicsShow" params="[topicShowId:b?.id]">${b?.name}</g:link>
                   </div><br>
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




        <div class="panel panel-default ">
            <div class="panel-heading text">
                <div class="row">
                    <div class="col-xs-8"><b>Subscriptions</b></div>
                    <div class="col-xs-4">
%{--                        <g:link action="index" controller="usernew2">--}%
%{--                            View All--}%
%{--                        </g:link>--}%
                    </div>
                </div>
            </div>
            <br>
            <table class="table useDataTable">
                <thead><tr><th></th></tr></thead><tbody>
            <g:each in="${list}" var="${t}">
                <g:if test="${t?.topic?.subscriptions?.user?.id?.contains(session.user) || t?.topic?.visibility?.name()?.equals("PUBLIC") || session.role}">
                    <tr>
                <td>
                       <div class="panel-body">

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
                                <div class="col-xs-4">
                                    <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:t?.topic?.createdBy?.id]">
                                        <div>${t?.topic?.createdBy?.username}</div>
                                    </g:link>
                                    <div><g:if test="${session.user}">
                                        <g:if test="${t?.topic?.subscriptions?.user?.id?.contains(session.user)}">
                                        <g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:t?.topic.id,userId:session.user]">Unsubscribe</g:link>
                                    </g:if>
                                        <g:else>
                                            <g:link action="subscribeToTopic" controller="topics" params="[topicId:t?.topic.id]">
                                                &nbsp;Subscribe
                                            </g:link>
                                        </g:else></g:if>
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


<g:if test="${t?.topic?.subscriptions?.user?.id?.contains(session.user)}">

                            <g:select class="form-control seriousnessChange"  name="seriousness" id="changeit" from="${enums.Seriousness?.values()}" value="${t?.seriousness}" optionKey="key" optionValue="value">
                                Seriousness
                            </g:select>
                            <input type="hidden" class="topicUniqueClass" value="${t?.topic?.id}">

</g:if>


                            %{--                        <g:link action="changeSeriousness" controller="topics" params="[s:'CASUAL',topic:t?.topic?.id]">change seriousness</g:link>--}%
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
                            <g:if test="${t?.topic?.subscriptions?.user?.id?.contains(session.user)}">
                            <i data-toggle="modal" style="margin-right: 5px;font-size: 25px" data-target="#myModal3" class="fa fa-envelope "></i></g:if>



                            <g:if test="${session.role || t?.topic?.createdBy.id==session.user}">
                                <g:link action="deleteTopic" controller="topics" params="[topicId:t?.topic.id,userId:t?.user.id]"><i class="far fa-trash-alt" style="margin-right: 5px;font-size: 25px"></i></g:link>




%{--                                <g:link controller="usernew2" action="index"><i class="far fa-edit" style="margin-right: 5px;font-size: 25px"></i></g:link>--}%
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
                                <div class="col-xs-3">
                                    <button type="submit" class="btn btn-light saveNewName" disabled>Save</button>
                                </div>
                                <div class="col-xs-3">
                                    <i class="far fa-edit editTopicName" style="margin-right: 5px;font-size: 25px"></i></div>
                            </g:uploadForm>
                        </div>
                    </g:if>
                </div>
                <br>
                </td></tr>
                </g:if>
            </g:each>
            </tbody></table>
        </div>

















    </div>
    <div class="col-lg-6">
        <div class="panel panel-default">
            <div class="panel-heading text">
                <b>Posts</b>
            </div>
            <br>
            <table class="table useDataTable">
                <thead><tr><th></th></tr></thead><tbody>

<g:each in="${publicUserTopics}" var="pTopics">
            <g:each in="${pTopics?.resources}" var="lresource">
                <tr>
              <td>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-2">
                            <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: lresource?.createdBy.id]"/>"/>
                        </div>
                        <div class="col-xs-10">
                <g:link controller="topics" action="topicsShow" params="[topicShowId:lresource?.topic?.id]">
                    <div style="margin-bottom: 10px">${lresource?.topic?.name}</div></g:link>
                            <div>${lresource.description}</div>
                            <br>
                            <div class="col-xs-3">
                                <i class="fab fa-facebook-square "></i>
                                <i class="fab fa-twitter-square " style="margin-left: 10px;"></i>
                            </div>
                                <div class="col-xs-5">
                                    <g:if test="${allLinkResources.id.contains(lresource?.id?.toLong())}">
                                        <a href="${allLinkResources.find{it.id==lresource?.id}.url}" target="_blank">
                                            view full site
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <g:link action="downloadDocumentResource" controller="topics" params="[drId:lresource?.id]">Download</g:link>

                                    </g:else>
%{--                                    <a href="${lresource.url}" target="_blank">view full site</a>--}%
                                </div>
                                <div class="col-xs-4">
                                    <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:lresource?.id]">
                                        View Post
                                    </g:link>
                                </div>
%{--                                <div class="col-xs-3">--}%
%{--                                    <g:if test="${session.user}">--}%
%{--                                        <g:if test="${allUnreadResources?.id.contains(lresource?.id?.toLong())}">--}%
%{--                                            <g:link controller="updateUserDetails" action="markAsRead" params="[resourceId: lresource?.id]">--}%
%{--                                                Mark as Read--}%
%{--                                            </g:link>--}%
%{--                                        </g:if>--}%
%{--                                        <g:elseif test="${allReadResources?.id.contains(lresource?.id?.toLong())}">--}%
%{--                                            Already read(done)--}%
%{--                                        </g:elseif>--}%
%{--                                        <g:else>Subscribe topic first</g:else>--}%
%{--                                    </g:if>--}%
%{--                                    <g:else>Login first</g:else>--}%
%{--                                </div>--}%
                        </div>
                    </div>
                </div>
              </td></tr>
            </g:each>
</g:each>
            <g:if test="${session.user}">
            <g:each in="${privateUserTopics}" var="pTopics">
                <g:if test="${pTopics?.subscriptions?.user?.id?.contains(session.user) || session.role}">
                <g:each in="${pTopics?.resources}" var="lresource">
                    <tr>
              <td>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-2">
                                <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: lresource?.createdBy.id]"/>"/>
                            </div>
                            <div class="col-xs-10">
                    <g:link controller="topics" action="topicsShow" params="[topicShowId:lresource?.topic?.id]">
                        <div style="margin-bottom: 10px">${lresource?.topic?.name}</div></g:link>
                                <div>${lresource.description}</div>
                                <br>
                                <div class="col-xs-3">
                                    <i class="fab fa-facebook-square"></i>
                                    <i class="fab fa-twitter-square" style="margin-left: 10px;"></i>
                                </div>
                                    <div class="col-xs-5">
                                        <g:if test="${allLinkResources.id.contains(lresource?.id?.toLong())}">
                                            <a href="${allLinkResources.find{it.id==lresource?.id}.url}" target="_blank">
                                                view full site
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <g:link action="downloadDocumentResource" controller="topics" params="[drId:lresource?.id]">Download</g:link>
                                        </g:else>
                                        %{--                                    <a href="${lresource.url}" target="_blank">view full site</a>--}%
                                    </div>
                                    <div class="col-xs-4">
                                        <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:lresource?.id]">
                                            View Post
                                        </g:link>
                                    </div>
%{--                                    <div class="col-xs-4">--}%
%{--                                        <g:if test="${session.user}">--}%
%{--                                            <g:if test="${allUnreadResources?.id.contains(lresource?.id?.toLong())}">--}%
%{--                                                <g:link controller="updateUserDetails" action="markAsRead" params="[resourceId: lresource?.id]">--}%
%{--                                                    Mark as Read--}%
%{--                                                </g:link>--}%
%{--                                            </g:if>--}%
%{--                                            <g:elseif test="${allReadResources?.id.contains(lresource?.id?.toLong())}">--}%
%{--                                                Already read(done)--}%
%{--                                            </g:elseif>--}%
%{--                                            <g:else>Subscribe topic first</g:else>--}%
%{--                                        </g:if>--}%
%{--                                        <g:else>Login first</g:else>--}%
%{--                                    </div>--}%
                            </div>
                        </div>
                    </div>
              </td></tr>
                </g:each>
                </g:if>
            </g:each>
            </g:if>
            </tbody></table>
        </div>
    </div>
</div>



<asset:javascript src="changeSeriousness.js"/>
<asset:javascript src="changeVisibility.js"/>
<asset:javascript src="changeTopicName.js"/>
<asset:javascript src="table.js"/>
</body>
</html>