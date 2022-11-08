<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 18:08
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
    <title>BBSJSP - Edit</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('You must log in.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
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
    if (!userID.equals(board.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('You do not have permission.')");
        script.println("location.href = 'board.jsp'");
        script.println("history.back()");
        script.println("</script>");
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
    </div>
</nav>
<div class="container">
    <div class="row">
        <form method="post" action="updateAction.jsp?boardID=<%= boardID %>">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                <tr>
                    <th colspan="2" style="background-color: #eeeeee; text-align: center;">Edit Post</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input type="text" class="form-control" placeholder="Title" name="boardTitle" maxlength="50"
                               value="<%= board.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("#", "&5;")  %>"></td>
                </tr>
                <tr>
                    <td><textarea class="form-control" placeholder="Contents" name="boardContent" maxlength="2048"
                                  style="height: 350px"><%= board.getBoardContent() %></textarea></td>
                </tr>
                </tbody>
            </table>
            <a href="javascript:history.back();" class="btn btn-warning">Cancel</a>
            <input type="submit" class="btn btn-primary pull-right" value="Save">
        </form>
    </div>
</div>
<div class="visible-lg-block"><br><br></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
