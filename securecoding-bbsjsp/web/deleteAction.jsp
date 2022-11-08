<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 18:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <title>BBSJSP</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('You must log in.');\nlocation.href = 'login.jsp';\nhistory.back();\n</script>");
    }

    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }
    if (boardID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('This article is invalid.');\nlocation.href = 'board.jsp';\nhistory.back();\n</script>");
    }
    Board board = new BoardDAO().getBoard(boardID);
    if (!userID.equals(board.getUserID())) { //URL delete protect e.g. deleteAction.jsp?boardID=1
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('You do not have permission.');\nlocation.href = 'board.jsp';\nhistory.back();\n</script>");
    } else {
        BoardDAO boardDAO = new BoardDAO();
        int result = boardDAO.delete(boardID);
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>\nalert(Sorry, failed to delete.');\nhistory.back();\n</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>\nlocation.href = 'board.jsp';\n</script>");
        }
    }
%>
</body>
</html>