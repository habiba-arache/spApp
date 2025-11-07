<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalider la session
    session.invalidate();

    // Rediriger vers la page de login
    response.sendRedirect("login.jsp");
%>
