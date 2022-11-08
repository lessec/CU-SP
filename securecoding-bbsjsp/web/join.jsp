<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/logo.ico"/>
    <title>BBSJSP - Join</title>
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
                    <li><a href="login.jsp">Log in</a></li>
                    <li class="active"><a href="join.jsp">Create account</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<style>
    body {
        background-image: url('images/bg-join.jpg');
        background-repeat: no-repeat;
        background-size: cover;
        height: 100vh;
    }
</style>
<div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action="joinAction.jsp">
                <h3 style="text-align: center;"><br><img src="images/logo.svg" height="120"></h3>
                <h3 style="text-align: center;">New account</h3>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="ID" name="userID" maxlength="20">
                    <!-- protect by maxlength -->
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" name="userPassword"
                           maxlength="40"> <!-- protect by maxlength -->
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Full Name" name="userName" maxlength="40">
                    <!-- protect by maxlength -->
                </div>
                <div class="form-group" style="text-align: center;">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-info active">
                            <input type="radio" name="userGender" autocomplete="off" value="Female" checked>Female
                        </label>
                        <label class="btn btn-info">
                            <input type="radio" name="userGender" autocomplete="off" value="Male" checked>Male
                        </label>
                        <label class="btn btn-info">
                            <input type="radio" name="userGender" autocomplete="off" value="Others" checked>Others
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" placeholder="E-mail" name="userEmail" maxlength="40">
                    <!-- protect by maxlength -->
                </div>
                <input type="submit" class="btn btn-primary form-control" value="Create Now">
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