<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 13:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/logo.ico"/>
    <title>BBSJSP - Login</title>
</head>
<body>
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
            <li><a href="about.jsp">About us</a></li>
            <li><a href="board.jsp">Board</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact us</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">Sign in
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li class="active"><a href="login.jsp">Log in</a></li>
                    <li><a href="join.jsp">Create account</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<style>
    body {
        background-image: url('images/bg-login.jpg');
        background-repeat: no-repeat;
        background-size: cover;
        height: 100vh;
    }
</style>
<div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action="loginAction.jsp">
                <h3 style="text-align: center;"><br><img src="images/logo.svg" height="120"></h3>
                <h3 style="text-align: center;">Log in</h3>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="ID" name="userID" maxlength="20"> <!-- protect by maxlength -->
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" name="userPassword"
                           maxlength="40"> <!-- protect by maxlength -->
                </div>
                <input type="submit" class="btn btn-primary form-control" value="Log In">
            </form>
        </div>
    </div>
    <div class="col-lg-4"></div>
</div>
<div class="visible-lg-block"><br><br></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>