<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 23/03/20
  Time: 5:18 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>
        Post show
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>
<style>
    .panel-default{
        border-width: 2px;
    }
</style>
</head>
<body>
<div id="errorsHere"></div>
<g:if test="${flash.topicExists}">
    <div class="alert alert-danger"> ${flash.topicExists}</div>
</g:if>
<g:if test="${flash.topicSaved}">
    <div class="alert alert-success"> ${flash.topicSaved}</div>
</g:if>

<g:render template="/usernew2/navbar"/>

<div class="container">
    <div class="col-lg-7">
        <div class="panel panel-default ">

            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2">
                        <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: postResource?.createdBy?.id]"/>"/>
                    </div>
                    <div class="col-xs-4">
                        <div>${postResource?.createdBy?.firstName} ${postResource?.createdBy?.lastName}</div>
                        <div>${postResource?.createdBy?.username}</div>
                    </div>
                    <div class="col-xs-6">
                        <div>
                            <g:link controller="topics" action="topicsShow" params="[topicShowId:postResource?.topic?.id]">
                            ${postResource?.topic?.name}
                            </g:link>
                        </div>
                        <div>
                        <g:formatDate format="yyyy-MM-dd HH:mm" date="${postResource?.lastUpdated}"/>
                        </div>
                        <g:if test="${session.user}">
                        <div>
%{--                            <select name="rating" class="form-control ratingChange">--}%
%{--                                <option value="1">1</option>--}%
%{--                                <option value="2">2</option>--}%
%{--                                <option value="3">3</option>--}%
%{--                                <option value="4">4</option>--}%
%{--                                <option value="5">5</option>--}%
%{--                            </select>--}%
                            <g:select name="rating" from="${1..5}" value="${resourceRating?.score}" class="form-control ratingChange" noSelection="['':'-Rate it-']"></g:select>

                            <input type="hidden" value="${postResource?.id}" id="resourceId">

                        </div>
                        </g:if>
                    </div>


                </div>
                <br>
                <div class="row">
                    <div class="col-xs-12">
                    ${postResource?.description}
                    </div>
                </div>
                <br>
                <br>
                <div class="row">
                    <div class="col-xs-3">
                        <g:if test="${allLinkResources.id.contains(postResource?.id?.toLong())}">
                            <a href="${allLinkResources.find{it.id==postResource?.id}.url}" target="_blank">
                                view full site
                            </a>
                        </g:if>
                        <g:else>
                            <g:link action="downloadDocumentResource" controller="topics" params="[drId:postResource?.id]">Download</g:link>

                        </g:else>
                    </div>
                    <div class="col-xs-2">
                        <g:if test="${session.role||postResource?.createdBy?.id==session.user}">
                        <g:link action="deletePost" controller="updateUserDetails" params="[resourceId:postResource?.id]">Delete</g:link>
                        </g:if>
                    </div>
                    <div class="col-xs-7">
                        <g:if test="${session.role || postResource?.createdBy?.id==session.user}">
                        <g:uploadForm controller="updateUserDetails" action="changeDescription" method="post">
                            <div class="col-xs-6">
                                <textarea type="text" name="description" id="newDescription" class="form-control" disabled>${postResource?.description}</textarea>
                                <input type="hidden" value="${postResource?.id}" name="resourceId"/>
                            </div>
                            <div class="col-xs-3">
                                <button type="submit" class="btn btn-light" id="editPostButton" disabled>Save</button>
                            </div>
                            <div class="col-xs-3">
                                <i class="far fa-edit" id="editDescription" style="margin-right: 5px;font-size: 25px"></i></div>
                        </g:uploadForm>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>

    </div>



    <div class="col-lg-5">
        <g:if test="${session.user}">
        <g:render template="/usernew2/trendingTopics"/>
        </g:if>
        <g:else>
            <g:render template="/usernew2/loginRegister"/>
        </g:else>
    </div>

</div>

<asset:javascript src="changeRating.js"/>
<asset:javascript src="editPost.js"/>
<g:render template="/usernew2/forgotPasswordModal"/>
</body>
</html>