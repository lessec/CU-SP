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
    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }
    Board board = new BoardDAO().getBoard(boardID);
    BoardDAO boardDAO = new BoardDAO();
    int result = boardDAO.delete(boardID);
    PrintWriter script = response.getWriter();
    script.println("<script>\nlocation.href = 'board.jsp';\n</script>");
%>
</body>
</html>