<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.User" %>
<%
    // Vérifier si l'utilisateur est connecté
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Sport Progress</title>
</head>
<body>
<div class="">
    <a href="auth?action=logout" class="">Logout</a>
    <h1 class="welcome">Welcome, <%= user.getFullName() %>!</h1>
    <p>Email: <%= user.getEmail() %></p>
    <p>This is your dashboard where you can track your sport progress.</p>
</div>
</body>
</html>
