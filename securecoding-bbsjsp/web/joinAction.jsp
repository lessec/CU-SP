<%--
  Created by IntelliJ IDEA.
  User: carlo
  Date: 18/10/2021
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
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
        script.println("<script>\nalert('You are already logged in.');\nlocation.href = 'main.jsp';\nhistory.back();\n</script>");
    }
    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
            || user.getUserGender() == null || user.getUserEmail() == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>\nalert('You have empty space.');\nhistory.back();\n</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = 0;
        try {
            result = userDAO.join(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>\nalert('The ID is already exists.');\nhistory.back();\n</script>");
        } else {
            session.setAttribute("userID", user.getUserID());
            PrintWriter script = response.getWriter();
            script.println("<script>\nlocation.href = 'main.jsp';\n</script>");
        }
    }
%>
</body>
</html>