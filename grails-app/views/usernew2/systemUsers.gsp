<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 27/03/20
  Time: 9:02 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>All Users</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <style>
        .btnPosition{
            margin-bottom: 20px;
            margin-left: 90%;
        }
    </style>
</head>

<body>
<g:render template="/usernew2/navbar"/>
<div class="container">
<div class="justify-content-center">
<table class="table" id="admintable">
    <thead>
    <tr>
        <th>S.No.</th>
        <th>Username</th>
        <th>Email</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Active</th>
        <th>Is Admin</th>
    </tr>
    </thead>
<g:each in="${users}" var="user" status="i">
    <tr>
        <td>${i}</td>
        <td>${user.username}</td>
        <td>${user.email}</td>
        <td>${user.firstName}</td>
        <td>${user.lastName}</td>
        <td>
            ${user.active}
            <g:link action="changeActiveStatus"  controller="usernew2" params="[user:user.id]"><i class="fas fa-pen"></i></g:link>
        </td>
        <td>
            ${user.isAdmin}
            <g:link action="setRemoveAdmin"  controller="usernew2" params="[user:user.id]"><i class="fas fa-pen"></i></g:link>
        </td>
    </tr>
</g:each>

</table>
</div>
</div>
<asset:javascript src="table" />
</body>
</html>