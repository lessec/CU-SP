<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/logo.ico"/>
    <title>BBSJSP - Board</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
            <li><a href="about.jsp">About us</a></li>
            <li class="active"><a href="board.jsp">Board</a></li>
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
                   aria-expanded="false">Sign in<span class="caret"></span></a>
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
                   aria-expanded="false">Edit profile<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><h4 style="text-align: center;">Hi, <%out.println(userID);%>!</h4></li>
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
        background-image: url('images/bg-board.jpg');
        background-repeat: no-repeat;
        background-size: cover;
        height: 100vh;
    }

    a, a:hover {
        color: #000000;
        text-decoration: none;
    }
</style>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color: #eeeeee; text-align: center;">No.</th>
                <th style="background-color: #eeeeee; text-align: center;">Title</th>
                <th style="background-color: #eeeeee; text-align: center;">Author</th>
                <th style="background-color: #eeeeee; text-align: center;">Date</th>
            </tr>
            </thead>
            <tbody>
            <%
                BoardDAO boardDAO = new BoardDAO();
                ArrayList<Board> list = boardDAO.getList(pageNumber);
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%= list.get(i).getBoardID() %>
                </td>
                <td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle() %>
                </a>
                </td>
                <td><%= list.get(i).getUserID() %>
                </td>
                <td><%= list.get(i).getBoardDate().substring(11, 16) + " " + list.get(i).getBoardDate().substring(8, 10) + "-" + list.get(i).getBoardDate().substring(5, 7) + "-" + list.get(i).getBoardDate().substring(0, 4) %>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
            if (pageNumber != 1) {
        %>
        <a href="board.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success">&lt; Before</a>
        <%
            }
            if (boardDAO.nextPage(pageNumber + 1)) {
        %>
        <a href="board.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success">After &gt;</a>
        <%
            }
        %>
        <a href="write.jsp" class="btn btn-primary pull-right">Write new</a>
    </div>
</div>
<div class="visible-lg-block"><br><br></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>