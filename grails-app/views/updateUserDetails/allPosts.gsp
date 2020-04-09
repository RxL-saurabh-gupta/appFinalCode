<%--
  Created by IntelliJ IDEA.
  User: saurabh
  Date: 05/04/20
  Time: 10:23 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>
        All Posts
    </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/75886237ee.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <style>
    .panel-default
    {
        border-color:black;
        border-width: 1px;
    }
    .imageborder{
        border: solid;
        border-color: black;
        border-width: 1px;
    }
    .blueColor{
        color: blue;
    }
        hr{
            background: black;
            height: 1px;
        }
    </style>

</head>
<body>
<g:render template="/usernew2/navbar"/>
<div class="container">
<g:render template="resourcePosts"/>
</div>
<asset:javascript src="table.js"/>
</body>
</html>