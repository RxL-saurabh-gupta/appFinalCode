<div class="modal fade" id="forgotPassword" role="dialog">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Send Invitation</h4>
            </div>
            <div class="modal-body">
                <g:uploadForm action="forgotPassword"  controller="updateUserDetails" class="form-horizontal" name="pop5" method="post">
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Email:</label>
                        <div class="col-lg-10">
                            <input type="email" class="form-control"  name="address" required>
                        </div>

                    </div>
                %{--                    <div class="form-group">--}%
                %{--                        <label class="col-lg-2 control-label">Subject:</label>--}%
                %{--                        <div class="col-lg-10">--}%
                %{--                            <input type="text" class="form-control"  name="subject" id="emailSubject" required>--}%
                %{--                        </div>--}%

                %{--                    </div>--}%
                %{--                    <div class="form-group">--}%
                %{--                        <label class="col-lg-2 control-label">Message:</label>--}%
                %{--                        <div class="col-lg-10">--}%
                %{--                            <textarea name="body" class="form-control" rows="4" cols="40" id="emailMessage" required></textarea>--}%
                %{--                        </div>--}%

                %{--                    </div>--}%
                    <div class="form-group">
                        <div class="col-xs-7">
                            <button type="submit" name="forgotpasswordbtn" class="btn btn-primary" style="float: right;">Send</button>
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