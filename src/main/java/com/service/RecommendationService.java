package com.service;

import com.dao.DietDao;
import com.dao.UserDao;
import com.dao.WorkOutDao;
import com.model.User;
import com.model.Diet;
import com.model.WorkOut;

import java.util.ArrayList;
import java.util.List;

public class RecommendationService {

    private DietDao dietDao = new DietDao();
    private WorkOutDao workoutDao = new WorkOutDao();
    private UserDao userDao = new UserDao();

    public void generateRecommendations(User user) {

       // double bmi = calculateBMI(user.getWeight(), user.getHeight());

        // Remove old recommendations
        dietDao.deleteByUser(user);
        workoutDao.deleteByUser(user);

        List<Diet> diets = new ArrayList<>();
        List<WorkOut> workouts = new ArrayList<>();

        if (user.getWeight() < user.getGoalWeight()) { // Underweight
            diets.add(new Diet("Oatmeal", "High-calorie healthy breakfast", "breakfast", user, 350f));
            diets.add(new Diet("Peanut Butter Sandwich", "Protein and calories", "lunch", user, 400f));
            diets.add(new Diet("Chicken Pasta", "Carbs + protein for dinner", "dinner", user, 500f));
            workouts.add(new WorkOut("Light Strength Training", "Build lean muscle", user));
        } else if (user.getWeight() == user.getGoalWeight()) { // Normal
            diets.add(new Diet("Balanced Breakfast", "Healthy start", "breakfast", user, 300f));
            diets.add(new Diet("Chicken & Vegetables", "Protein with fiber", "lunch", user, 450f));
            diets.add(new Diet("Grilled Fish & Rice", "Maintain weight", "dinner", user, 400f));
            workouts.add(new WorkOut("Cardio 3x/week", "Maintain endurance", user));
            workouts.add(new WorkOut("Yoga 2x/week", "Flexibility and relaxation", user));
        } else { // Overweight
            diets.add(new Diet("Fruit Smoothie", "Low-calorie breakfast", "breakfast", user, 250f));
            diets.add(new Diet("Salad & Chicken", "Low-calorie lunch", "lunch", user, 300f));
            diets.add(new Diet("Grilled Vegetables", "Light dinner", "dinner", user, 350f));
            workouts.add(new WorkOut("High-intensity Cardio", "Burn fat effectively", user));
            workouts.add(new WorkOut("Strength Training", "Boost metabolism", user));
        }

        // Save recommendations in DB
        for (Diet d : diets) dietDao.save(d);
        for (WorkOut w : workouts) workoutDao.save(w);
        userDao.updateUser(user);
    }

    private double calculateBMI(double weightKg, double heightCm) {
        double heightM = heightCm / 100.0;
        return weightKg / (heightM * heightM);
    }
}
