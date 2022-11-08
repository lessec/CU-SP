<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 18:36
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
    <title>BBSJSP - Home</title>
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
            <li class="active"><a href="main.jsp">Home</a></li>
            <li><a href="about.jsp">About us</a></li>
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
        background-image: url('images/bg-main.jpg');
        background-repeat: no-repeat;
        background-size: cover;
        height: 100vh;
    }
</style>
<div class="container">
    <div class="jumbotron">
        <div class="container">
            <h1>Welcome!</h1>
            <p>Please welcome to the BBSJSP project. Please use it freely.<br>This site is designed for Penetration
                testing and Secure Programming.</p>
            <p><a class="btn btn-default btn-pull" href="about.jsp" role="button">More detail</a></p>
        </div>
    </div>
</div>

<div class="container">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
            <li data-target="#myCarousel" data-slide-to="4"></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img src="images/main0.jpg">
            </div>
            <div class="item">
                <img src="images/main1.jpg">
            </div>
            <div class="item">
                <img src="images/main2.jpg">
            </div>
            <div class="item">
                <img src="images/main3.jpg">
            </div>
            <div class="item">
                <img src="images/main4.jpg">
            </div>
        </div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev"></a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next"></a>
    </div>
</div>
<div class="visible-lg-block"><br><br></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>