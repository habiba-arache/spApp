<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Vérifie si une session existe avant de l’invalider
    if (session != null) {
        session.invalidate();
    }

    // Redirige vers la page de connexion après la déconnexion
    response.sendRedirect("index.jsp");
%>
