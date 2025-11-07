package com.controller;

import com.model.User;
import com.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/auth")
public class AuthController extends HttpServlet {

    private final UserService userService = new UserService();
 // redirect me to the correct path to insert my infos
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "login";
        switch (action) {
            case "register":
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            case "logout":
                request.getSession().invalidate();
                response.sendRedirect("auth?action=login");
                break;
            default:
                request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
    private void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        User user = new User();
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));

        // Safe parse with null checks
        user.setWeight(parseFloatSafe(request.getParameter("weight")));
        user.setHeight(parseFloatSafe(request.getParameter("height")));
        user.setGoalWeight(parseFloatSafe(request.getParameter("goalWeight")));
        user.setAge(parseIntSafe(request.getParameter("age")));
        user.setGender(request.getParameter("gender"));

        userService.register(user);
//        request.getSession().setAttribute("user", user);
        response.sendRedirect("index.jsp");
    }

    private float parseFloatSafe(String param) {
        try {
            return (param != null && !param.isEmpty()) ? Float.parseFloat(param) : 0f;
        } catch (NumberFormatException e) {
            return 0f;
        }
    }

    private int parseIntSafe(String param) {
        try {
            return (param != null && !param.isEmpty()) ? Integer.parseInt(param) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.login(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("register".equals(action)) {
                registerUser(request, response);
            } else if ("login".equals(action)) {
                loginUser(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

}
