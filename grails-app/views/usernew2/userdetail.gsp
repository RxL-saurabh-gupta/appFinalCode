<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 25/03/20
  Time: 2:41 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Users</title>
</head>
<body>
<g:each in="${users}" var="user" status="i">
    ${i+1}. ${user.lastName}, ${user.firstName},${user.email},${user.username},${user.isAdmin},${user.active}
        <g:link action="changeActiveStatus" controller="usernew2" params="[user:user.username]">button</g:link>

</g:each>
</body>
</html>