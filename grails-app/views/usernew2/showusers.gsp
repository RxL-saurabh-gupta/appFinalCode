<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 25/03/20
  Time: 3:00 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Users</title>
</head>
<body>
//${session.role}
<g:if test="${session.name}">

<g:each in="${users}" var="user" status="i">
    <h3>${i+1}. ${user.lastName}, ${user.firstName},${user.email},${user.username},${user.isAdmin},${user.active}</h3>

    <br/>
</g:each>
</g:if>
</body>
</html>