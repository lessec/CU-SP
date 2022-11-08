<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 20:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/logo.ico"/>
    <title>BBSJSP - About</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>
<nav class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">BBSJSP</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">Home</a></li>
            <li class="active"><a href="about.jsp">About us</a></li>
            <li><a href="board.jsp">Board</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact us</a></li>
        </ul>
        <%
            if (userID == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">Sign in
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">Log in</a></li>
                    <li><a href="join.jsp">Create account</a></li>
                </ul>
            </li>
        </ul>
        <%
        } else {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">Hi, <%out.println(userID);%>!
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="profile.jsp">Edit profile</a></li>
                    <li><a href="logoutAction.jsp">Log out</a></li>
                </ul>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>
<style>
    body {
        background-image: url('images/bg-about.jpg');
        background-repeat: no-repeat;
        background-size: cover;
        height: 100vh;
    }
</style>
<div class="container">
    <div class="jumbotron">
        <div class="container">
            <h1><img src="images/about.jpg" alt="" width="120">&nbsp; About us</h1>
            <p>It is a Bulletin Board System to study Penetration testing and Secure Coding, and it is made with JSP.
                Simple login and registration are possible, and as it is a BBS, you can write, read, edit, and delete
                posts on Board.</p>
            <h4><br><a class="btn btn-default btn-pull" href="https://github.com/leelsey/BBSJSP" role="button">Go to
                GitHub</a>&nbsp; by Leslie (leelsey)</h4>
        </div>
    </div>
</div>
<div class="visible-lg-block"><br><br></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>