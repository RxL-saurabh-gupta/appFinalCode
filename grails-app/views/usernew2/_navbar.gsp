
<div class="container">
    <div style="margin-top: 20px;">
    <div class="panel panel-default " >
        <div class="panel-body">


            <div class="col-lg-2">
                <g:link controller="usernew2" action="goToDash" style="font-size: 20px">
                Link Sharing
                </g:link>
            </div>


            <div class="col-lg-3">
            <g:form controller="updateUserDetails" action="searchContent" method="post">
                <div class="col-lg-9">

                    <input style="margin-bottom: 5px;" type="text" name="content" id="search" class="form-control mb-2" align="right" placeholder="Search">

                </div>
                <div class="col-lg-3">
                    <button type="submit" name="button1" class="btn btn-primary mb-2" align="right" style="margin-bottom: 5px;">Search</button>

                </div>
            </g:form>
            </div>
            <div class="col-lg-3">

            </div>
            <div class="col-lg-2" style="float: right;">
<g:if test="${session.user}">

                <div class="dropdown" style="margin-left: 8px; float: right;">
                    <button style="margin-right: 5px " class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><!--  <img src="#" height="20px"width="20px"> --><i class="fas fa-user fa-md" style="color: white"></i>   ${session.fname}
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <g:if test="${session.role}">
                            <li><g:link action="userDetails" controller="usernew2">Users</g:link></li>
                            <li><g:link action="allTopicsAdmin" controller="topics">Topics</g:link></li>
                            <li><g:link action="allSystemPosts" controller="updateUserDetails">Posts</g:link></li>
                        </g:if>
                        <li><g:link controller="updateUserDetails" action="index">Profile</g:link>
                        <li><g:link action="logout" controller="usernew2">Logout</g:link></li>
                    </ul>
                </div>
</g:if>

            </div>
            <div class="col-lg-2" style="float: right;">


                <!--  <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal">Open Small Modal</button> -->


                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Share Link</h4>
                            </div>
                            <div class="modal-body">
                                <g:uploadForm controller="topics" action="shareLink" class="form-horizontal" name="pop1" method="post">
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Link:</label>
                                        <div class="col-lg-10">
                                            <input type="url" class="form-control" name="url" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Description:</label>
                                        <div class="col-lg-10">

                                            <textarea name="description" class="form-control" rows="4" cols="40" required></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Topic:</label>
                                        <div class="col-lg-10">


                                            <g:select class="form-control" name="linkTopic" from="${list?.topic}" optionValue="name" optionKey="id" noSelection="['':'-Select a topic-']"></g:select>




                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-7">
                                            <button type="submit" name="sharelinkbtn" class="btn btn-primary" style="float: right;">Share</button>
                                        </div>
                                        <div class="col-xs-4">
                                            <button data-dismiss="modal" type="button" name="cancelpop1" class="btn btn-primary" style="float: right;">Cancel</button>
                                        </div>
                                        <div class="col-xs-1">

                                        </div>
                                    </div>
                                </g:uploadForm>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal fade" id="myModal1" role="dialog">
                    <div class="modal-dialog ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Share Document</h4>
                            </div>
                            <div class="modal-body">



                                <g:uploadForm action="shareDoc" controller="topics" class="form-horizontal" name="pop2" method="post">
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Document:</label>
                                        <div class="col-lg-8">
                                            <input type="file"  name="document1" required>
                                        </div>
                                        <div class="col-lg-2">

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Description:</label>
                                        <div class="col-lg-10">

                                            <textarea name="description" class="form-control" rows="4" cols="40" required></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Topic:</label>
                                        <div class="col-lg-10">
                                            <g:select class="form-control" name="linkTopic" from="${list?.topic}" optionValue="name" optionKey="id" noSelection="['':'-Select a topic-']"></g:select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-7">
                                            <button type="submit" name="sharedocbtn" class="btn btn-primary" style="float: right;">Share</button>
                                        </div>
                                        <div class="col-xs-4">
                                            <button data-dismiss="modal" type="button" name="cancelpop2" class="btn btn-primary" style="float: right;">Cancel</button>
                                        </div>
                                        <div class="col-xs-1">

                                        </div>
                                    </div>
                                </g:uploadForm>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="myModal2" role="dialog">
                    <div class="modal-dialog ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Create Topic:</h4>
                            </div>
                            <div class="modal-body">


                                <g:uploadForm controller="topics" action="newTopic" method="post" class="form-horizontal" name="pop3">
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Name:</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control"  name="name" id="tname" required>
                                        </div>

                                    </div>


                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Visibility:</label>
                                        <div class="col-lg-10">


                                            <g:select  id="visible" from="${enums.Visibility?.values()}"
                                                       value="${taskInstance?.visibility}" name="visibility"
                                                       optionKey="key" optionValue="value" class="form-control" noSelection="['':'-Select visibility-']">Visibility</g:select>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-7">
                                            <button id="saveTopicButton" type="submit" name="createtopicbtn" class="btn btn-primary" style="float: right;">Save</button>
                                        </div>
                                        <div class="col-xs-4">
                                            <button data-dismiss="modal" type="button" name="cancelpop3" class="btn btn-primary" style="float: right;">Cancel</button>
                                        </div>
                                        <div class="col-xs-1">

                                        </div>
                                    </div>
                                </g:uploadForm>








                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal fade" id="myModal3" role="dialog">
                    <div class="modal-dialog ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Send Invitation</h4>
                            </div>
                            <div class="modal-body">

                            %{--                                <g:form controller="topics" action="send">--}%
                            %{--                                    <div class="fieldcontain">--}%
                            %{--                                        <g:textField name="address" placeholder="youremail@djamware.com" required="" />--}%
                            %{--                                    </div>--}%
                            %{--                                    <div class="fieldcontain">--}%
                            %{--                                        <g:textField name="subject" placeholder="Your Subject" required="" />--}%
                            %{--                                    </div>--}%
                            %{--                                    <div class="fieldcontain">--}%
                            %{--                                        <g:textArea name="body" rows="5" cols="80" placeholder="Your message" required="" />--}%
                            %{--                                    </div>--}%
                            %{--                                    <fieldset>--}%
                            %{--                                        <g:submitButton name="send" value="Send" />--}%
                            %{--                                    </fieldset>--}%
                            %{--                                </g:form>--}%

















                                <g:uploadForm action="send"  controller="topics" class="form-horizontal" name="pop4" method="post">
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Email:</label>
                                        <div class="col-lg-10">
                                            <input type="email" class="form-control"  name="address" required>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Subject:</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control"  name="subject" id="emailSubject" required>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Message:</label>
                                        <div class="col-lg-10">
                                            <textarea name="body" class="form-control" rows="4" cols="40" id="emailMessage" required></textarea>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Topic:</label>
                                        <div class="col-lg-10">
                                            <g:select class="form-control topicChange" name="linkTopic" from="${list?.topic}" optionValue="name" optionKey="id" noSelection="['':'-Select a topic-']"></g:select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-7">
                                            <button type="submit" name="sendinvitebtn" class="btn btn-primary" style="float: right;">Invite</button>
                                        </div>
                                        <div class="col-xs-4">
                                            <button data-dismiss="modal" type="button" name="cancelpop4" class="btn btn-primary" style="float: right;">Cancel</button>
                                        </div>
                                        <div class="col-xs-1">

                                        </div>
                                    </div>
                                </g:uploadForm>










                            </div>

                        </div>
                    </div>
                </div>
<g:if test="${session.user}">

                <i data-toggle="modal" style="margin-right: 10px; " data-target="#myModal3" class="fa fa-envelope fa-2x"></i>

                <i class='fas fa-comment fa-2x'  data-target="#myModal2" data-toggle="modal" style=" margin-right: 10px;"></i>


                <i class="fas fa-link fa-2x" style=" margin-right: 10px;" data-target="#myModal" data-toggle="modal"></i>


                <i class="fas fa-file fa-2x " data-target="#myModal1" data-toggle="modal"></i>
</g:if>
            </div>


        </div>
    </div>

</div>
</div>
<asset:javascript src="sendEmail.js"/>