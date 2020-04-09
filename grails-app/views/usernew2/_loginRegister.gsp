<div class="panel panel-default">
    <div class="panel-heading text">
        <strong>Login</strong>
        <div>
            <g:if test="${flash.error}">
                <div class="alert alert-danger"> ${flash.error}</div>
            </g:if>
            <g:if test="${flash.userInactive}">
                <div class="alert alert-danger"> ${flash.userInactive}</div>
            </g:if>
        </div>
    </div>
    <div class="panel-body">
        <g:uploadForm action="loginuser" controller="usernew2" class="form-horizontal" method="post">
            <div class="form-group">
                <label class="col-lg-4 control-label">Username/Email:</label>
                <div class="col-lg-8">
                    <input class=" form-control" type="text" name="userid" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Password:</label>
                <div class="col-lg-8">
                    <input type="password" class="form-control" name="password" required>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8">
                    <a href="#" data-target="#forgotPassword" data-toggle="modal">Forgot password</a>
                </div>
                <div class="col-lg-4">
                    <button type="submit" name="login" class="btn btn-primary" align="right">Login</button>
                </div>
            </div>
        </g:uploadForm>

    </div>

</div>
<div class="panel panel-default">
    <div class="panel-heading text">
        <strong>Registration</strong>
        <div>
            <g:if test="${flash.regerror2}">
                <div class="alert alert-danger"> ${flash.regerror2}</div>
            </g:if>
            <g:if test="${flash.regSuccess}">
                <div class="alert alert-success"> ${flash.regSuccess}</div>
            </g:if>
        </div>
        <div  id="errordisplay">

        </div>
    </div>
    <div class="panel-body">
        <g:uploadForm action="addUser" controller="usernew2" method="post" class="form-horizontal">
            <div class="form-group">
                <label class="col-lg-4 control-label">First Name:</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="fname" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Last Name: </label>
                <div class="col-lg-8">
                    <input class="form-control" type="text" name="lname" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Email: </label>
                <div class="col-lg-8">
                    <input type="email" class="form-control" name="emailid" required>
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Username: </label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" name="uname" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Password: </label>
                <div class="col-lg-8">
                    <input type="password" minlength="8" maxlength="20" name="password1" id="txtPassword" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Confirm Password: </label>
                <div class="col-lg-8">
                    <input type="password" class="form-control"  minlength="8" maxlength="20" id="txtConfirmPassword" name="password2" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-4 control-label">Photo</label>
                <div class="col-lg-8">
                    <input type="file" name="file" accept="image/*" required>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8">
                </div>
                <div class="col-lg-4">
                    <button type="submit" name="register" id="btnSubmit" class="btn btn-primary" align="right">Register</button>
                </div>
            </div>
        </g:uploadForm>

    </div>

</div>