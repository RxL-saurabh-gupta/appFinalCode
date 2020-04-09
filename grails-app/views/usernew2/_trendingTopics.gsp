<div class="panel panel-default ">
    <div class="panel-heading text">
        <b>Trending topics</b>
    </div>
    <g:each in="${trendingTopics}" var="z" status="i">
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-2">
                    <img class="imageborder" height="80px" width="70px" src="<g:createLink controller="usernew2" action="viewImage" params="[userId: z[1].createdBy.id]"/>"/>
                </div>
                <div class="col-xs-10">
                    <div>
                        <g:link controller="topics" action="topicsShow" params="[topicShowId:z[1]?.id]">
                            ${z[1]?.name}
                        </g:link>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-xs-4">
                            <div>${z[1].createdBy.username}</div>
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