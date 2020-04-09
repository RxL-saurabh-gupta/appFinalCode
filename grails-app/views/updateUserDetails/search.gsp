<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 23/03/20
  Time: 5:19 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>
        Search
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>

</head>
<body>
<g:render template="/usernew2/navbar"/>
<div class="container">
    <div class="col-lg-5">
        <div class="panel panel-default ">
            <div class="panel-heading text">
                <b> Trending topics</b>
            </div>
            <g:each in="${trendingTopics}" var="z" status="i">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-2">
                <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:z[1].createdBy.id]">
                            <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: z[1].createdBy.id]"/>"/>
                </g:link>
                    </div>
                        <div class="col-xs-10">
                            <div>
                                <g:link controller="topics" action="topicsShow" params="[topicShowId:z[1]?.id]">
                                    ${z[1]?.name}
                                </g:link>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"> <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:z[1].createdBy.id]">
                                    <div>${z[1].createdBy.username}</div></g:link>
                                %{--                                <div><g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:t?.topic.id,userId:t?.user.id]">Unsubscribe</g:link></div>--}%
                                    <g:if test="${session.user}">
                                        <div>
                                            <g:if test="${z[1]?.subscriptions?.user.id.contains(session.user)}">
                                                <g:link action="unsubscribeFromTopic" controller="topics" params="[topicId:z[1]?.id,userId:session.user]">
                                                    &nbsp;Unsubscribe
                                                </g:link>
                                            </g:if>
                                            <g:else>
                                                <g:link action="subscribeToTopic" controller="topics" params="[topicId:z[1]?.id]">
                                                    &nbsp;Subscribe
                                                </g:link>
                                            </g:else>
                                        </div>
                                    </g:if>
                                    <g:else><g:link action="index" controller="usernew2">Log in to Subscribe</g:link></g:else>







                                </div>
                                <div class="col-xs-4">
                                    <div>Subscriptions</div>
                                    <div class="blueColor">${z[1]?.subscriptions?.size()}</div>
                                </div>
                                <div class="col-xs-4">
                                    <div>Posts</div>
                                    <div class="blueColor">${z[1]?.resources?.size()}

                                    %{--                                <g:createLink controller="usernew2" action="goToDash" params="[user: t?.topic.createdBy.id]"/>--}%
                                    %{--                                <h2>${count}</h2>--}%
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
        <g:render template="/usernew2/topPosts"/>


    </div>

    <div class="col-lg-7">
        <div class="panel panel-default">
            <div class="panel-heading text">
                <b>Posts</b>
            </div>



            <g:each in="${listLR}" var="lresource">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-2">
                            <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: lresource?.createdBy.id]"/>"/>
                        </div>
                        <div class="col-xs-10">
                            <div>
         <g:link controller="topics" action="topicsShow" params="[topicShowId:lresource?.topic?.id]">${lresource?.topic?.name}</g:link>
                              </div>
                            <div>${lresource.description}</div>
                            <br>
                            <div class="col-xs-3">
                                <i class="fab fa-facebook-square fa-2x"></i>
                                <i class="fab fa-twitter-square fa-2x" style="margin-left: 10px;"></i>
                            </div>
                            <div class="col-xs-9">
                                <div class="col-xs-4">
                                    <a href="${lresource.url}" target="_blank">view full site</a>
                                </div>
                                <div class="col-xs-4">
                                    <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:lresource?.id]">
                                        View Post
                                    </g:link>
                                </div>
                                <div class="col-xs-4">
                                    <g:if test="${session.user}">
                                        <g:if test="${allUnreadResources?.id.contains(lresource?.id?.toLong())}">
                                            <g:link controller="updateUserDetails" action="markAsRead" params="[resourceId: lresource?.id]">
                                                Mark as Read
                                            </g:link>
                                        </g:if>
                                        <g:elseif test="${allReadResources?.id.contains(lresource?.id?.toLong())}">
                                            Already read(done)
                                        </g:elseif>
                                        <g:else>Subscribe topic first</g:else>
                                    </g:if>
                                    <g:else>Login first</g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </g:each>
            <g:each in="${listDR}" var="dresource">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-2">
                            <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: dresource?.createdBy.id]"/>"/>
                        </div>
                        <div class="col-xs-10">
                            <div>
                                <g:link controller="topics" action="topicsShow" params="[topicShowId:dresource?.topic?.id]">${dresource?.topic?.name}</g:link>
                            </div>
                            <div>${dresource.description}</div>
                            <br>
                            <div class="col-xs-3">
                                <i class="fab fa-facebook-square fa-2x"></i>
                                <i class="fab fa-twitter-square fa-2x" style="margin-left: 10px;"></i>
                            </div>
                            <div class="col-xs-9">
                                <div class="col-xs-4">
                                    <g:link action="downloadDocumentResource" controller="topics" params="[drId:dresource.id]">Download</g:link>
                                </div>
                                <div class="col-xs-4">
                                    <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:dresource?.id]">
                                        View Post
                                    </g:link>
                                </div>
                                <div class="col-xs-4">
                                    <g:if test="${session.user}">
                                        <g:if test="${allUnreadResources?.id.contains(dresource?.id?.toLong())}">
                                            <g:link controller="updateUserDetails" action="markAsRead" params="[resourceId: dresource?.id]">
                                                Mark as Read
                                            </g:link>
                                        </g:if>
                                        <g:elseif test="${allReadResources?.id.contains(dresource?.id?.toLong())}">
                                            Already read(done)
                                        </g:elseif>
                                        <g:else>Subscribe topic first</g:else>
                                    </g:if>
                                    <g:else>Login first</g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </g:each>
        </div>
    </div>

</div>



</body>
</html>