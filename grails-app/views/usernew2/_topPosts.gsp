<div class="panel panel-default">
    <div class="panel-heading text">
        <b> Top Posts</b>
    </div>
    <g:each in="${topPosts}" var="top">
        <g:if test="${top[1]?.topic?.visibility.name().equals("PUBLIC")}">
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-2">
            <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:top[1]?.createdBy?.id]">
                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: top[1]?.createdBy?.id]"/>"/>
            </g:link>
                </div>
                <div class="col-xs-10">
                    <div class="row">
                        <div class="col-xs-5"><b>${top[1]?.createdBy?.firstName} ${top[1].createdBy?.lastName}</b></div>

                        <div class="col-xs-3">
                            <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:top[1]?.createdBy?.id]">
                                ${top[1]?.createdBy.username}
                            </g:link></div>
                        <div class="col-xs-1"></div>
                        <div class="col-xs-3"><g:link controller="topics" action="topicsShow" params="[topicShowId:top[1]?.topic?.id]">
                            ${top[1]?.topic?.name}
                        </g:link></div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-xs-12">
                            ${top[1]?.description}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <g:link style="float: right" controller="updateUserDetails" action="showPost" params="[resourceId:top[1]?.id]">
                                View Post
                            </g:link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </g:if>
    </g:each>

</div>