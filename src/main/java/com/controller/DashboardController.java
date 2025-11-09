package com.controller;

import com.model.User;
import com.model.WorkOut;
import com.model.Diet;
import com.model.WeightRecord;
import com.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private final WorkOutService workOutService = new WorkOutService();
    private final DietService dietService = new DietService();
    private final WeightRecordService weightService = new WeightRecordService();
    private final RecommendationService recService = new RecommendationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Always reload the latest data
        List<WorkOut> workouts = workOutService.getUserWorkouts(user.getId());
        List<Diet> diets = dietService.getDiet(user.getId());
        List<WeightRecord> weightRecords = weightService.getUserWeightRecords(user);

        request.setAttribute("workouts", workouts);
        request.setAttribute("diets", diets);
        request.setAttribute("weights", weightRecords);

        // Forward to JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    private float parseFloatSafe(String param) {
        try {
            return (param != null && !param.isEmpty()) ? Float.parseFloat(param) : 0f;
        } catch (NumberFormatException e) {
            return 0f;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        //  Handle workout toggle
        if ("toggle_workout".equals(action)) {
            Long id = Long.valueOf(request.getParameter("id"));
            boolean completed = Boolean.parseBoolean(request.getParameter("completed"));

            WorkOut workout = workOutService.findById(id);
            if (workout != null) {
                workout.setStatus(completed);
                workOutService.updateWorkout(workout);
            }
            response.sendRedirect("dashboard");
            return;
        }

        //  Handle weight update
        if ("update_weight".equals(action)) {
            float newWeight = parseFloatSafe(request.getParameter("weight"));

            if (newWeight > 0) {
                weightService.addWeightRecord(user.getId(), newWeight);
                user.setWeight(newWeight); // update session user weight
                session.setAttribute("user", user);
            }

            // Regenerate recommendations and refresh page
            recService.generateRecommendations(user);
            response.sendRedirect("dashboard");
        }
    }
}
