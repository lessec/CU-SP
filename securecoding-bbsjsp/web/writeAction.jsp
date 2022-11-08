<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/>
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
    } else {
        if (board.getBoardTitle() == null || board.getBoardContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>\nalert('There are things that have not been entered.');\nhistory.back();\n</script>");
        } else {
            BoardDAO boardDAO = new BoardDAO();
            int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent());
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>\nalert('Sorry, failed to write.');\nhistory.back();\n</script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>\nlocation.href = 'board.jsp';\n</script>");
            }
        }
    }
%>
</body>
</html>
