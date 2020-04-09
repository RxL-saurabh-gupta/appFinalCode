<div class="panel panel-default">
    <div class="panel-heading text">
        <b>Posts</b>
    </div>
    <br>
    <table class="table" id="allSystemTopics">
        <thead><tr><th></th></tr></thead><tbody>


    <g:each in="${listLR}" var="lresource">
        <tr>
              <td>
       <div class="panel-body">
           <div class="row">
               <div class="col-xs-2">
        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:lresource?.createdBy?.id]">
                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: lresource?.createdBy.id]"/>"/>
        </g:link>
            </div>
                <div class="col-xs-10">
                    <div class="row"><div class="col-xs-8">
                        <div>${lresource?.createdBy?.firstName} ${lresource?.createdBy?.lastName}</div>
                        <div> <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:lresource?.createdBy?.id]">
                            ${lresource?.createdBy?.username}</g:link>
                        </div>
                    </div>
                        <div class="col-xs-4">
        <g:link controller="topics" action="topicsShow" params="[topicShowId:lresource?.topic?.id]">
            ${lresource?.topic?.name}</g:link>
                        </div>
                    </div>
                    <br>
                    <div class="row"><div class="col-xs-12">${lresource.description}</div></div>
                    <br>

                </div>
            </div>
           <div class="row">
               <div class="col-xs-2">
                                           <i class="fab fa-facebook-square "></i>
                                           <i class="fab fa-twitter-square" style="margin-left: 5px;"></i>
               </div>
                   <div class="col-xs-3">
                       <a href="${lresource.url}" target="_blank">view full site</a>
                   </div>
                   <div class="col-xs-3">
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
                       %{--                            <g:else>Login first</g:else>--}%
                   </div>
           </div>
        </div><br>
              </td></tr>
    </g:each>
    <g:each in="${listDR}" var="dresource">
        <tr>
                  <td>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2">
        <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:dresource?.createdBy?.id]">
                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: dresource?.createdBy.id]"/>"/>
        </g:link>
            </div>
                <div class="col-xs-10">
                    <div class="row">
                        <div class="col-xs-8">
                        <div>${dresource?.createdBy?.firstName} ${dresource?.createdBy?.lastName}</div>
                            <div> <g:link controller="updateUserDetails" action="showUserProfile" params="[userId:dresource?.createdBy?.id]">
                                ${dresource?.createdBy?.username}</g:link>
                            </div>
                        </div>
                        <div class="col-xs-4">
        <g:link controller="topics" action="topicsShow" params="[topicShowId:dresource?.topic?.id]">
                        ${dresource?.topic?.name}
        </g:link>
                        </div>
                    </div>
                    <br>
                    <div class="row"><div class="col-xs-12">${dresource.description}</div></div>
                    <br>

                </div>
            </div>
                <div class="row">
                    <div class="col-xs-2">
                                                <i class="fab fa-facebook-square"></i>
                                                <i class="fab fa-twitter-square" style="margin-left: 5px;"></i>
                    </div>
                        <div class="col-xs-3">
                            <g:link action="downloadDocumentResource" controller="topics" params="[drId:dresource.id]">Download</g:link>
                        </div>
                        <div class="col-xs-3">
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
                            %{--                            <g:else>Login first</g:else>--}%
                        </div>
                </div>
        </div>
                  </td></tr>
    </g:each>
    </tbody></table>
</div>