<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/logo.ico"/>
    <title>BBSJSP - Post</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }
    if (boardID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('This article is invalid.')");
        script.println("location.href = 'board.jsp'");
        script.println("history.back()");
        script.println("</script>");
    }
    Board board = new BoardDAO().getBoard(boardID);
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
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th colspan="3" style="background-color: #eeeeee; text-align: center;">Read Post</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="width: 15%;">Title</td>
                <td colspan="2"><%= board.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("#", "&5;") %> <!-- Special character handling -->
                </td>
            </tr>
            <tr>
                <td>Author</td>
                <td colspan="2"><%= board.getUserID() %>
                </td>
            </tr>
            <tr>
                <td>Date</td>
                <td colspan="2"><%= board.getBoardDate().substring(11, 19) + " " + board.getBoardDate().substring(8, 10) + "-" + board.getBoardDate().substring(5, 7) + "-" + board.getBoardDate().substring(0, 4) %>
                </td>
            </tr>
            <tr>
                <td>Contents</td>
                <td colspan="2" height="300"
                    style="text-align: left;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("#", "&5;") %> <!-- Special character handling -->
                </td>
            </tr>
            </tbody>
        </table>
        <a href="javascript:history.back();" class="btn btn-success">Go back</a>
        <%
            if (userID != null && userID.equals(board.getUserID())) {
        %>
        <a href="update.jsp?boardID=<%= boardID %>" class="btn btn-primary">Edit</a>
        <a onclick="return confirm('Are you sure want to delete it?')" href="deleteAction.jsp?boardID=<%= boardID %>"
           class="btn btn-danger">Delete</a>
        <%
            }
        %>
    </div>
</div>
<div class="visible-lg-block"><br><br></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>