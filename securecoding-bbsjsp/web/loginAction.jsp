<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 13:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
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

    if (userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('You are already logged in');\nlocation.href = 'main.jsp';\nhistory.back();\n</script>");
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user.getUserID(), user.getUserPassword());
    if (result == 1) {
        session.setAttribute("userID", user.getUserID());
        PrintWriter script = response.getWriter();
        script.println("<script>\nlocation.href = 'main.jsp';\n</script>");
    } else if (result == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('The password is wrong.');\nhistory.back();\n</script>");
    } else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('ID does not exist.');\nhistory.back();\n</script>");
    } else if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('Database error has occurred.');\nhistory.back();\n</script>");
    } else if (result == -3) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('Account is locked.');\nhistory.back();\n</script>");
    }
%>
</body>
</html>