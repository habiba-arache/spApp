package com.service;

import com.dao.WorkOutDao;
import com.model.User;
import com.model.WorkOut;

import java.util.List;

public class WorkOutService {
    private WorkOutDao workOutDao = new WorkOutDao();

    public void addWorkout(String name, String description, User user) {
        WorkOut workOut = new WorkOut(name, description, user);
        workOutDao.save(workOut);
    }

    public void updateWorkout(WorkOut workOut) {
        workOutDao.update(workOut);
    }

    public void deleteWorkout(User user) {
            workOutDao.deleteByUser(user);
    }

    public List<WorkOut> getUserWorkouts(Long userId) {
        return workOutDao.findByUserId(userId);
    }

    public void markAsComplete(Long id) {
        WorkOut workOut = (WorkOut) workOutDao.findByUserId(id);
        if (workOut != null) {
            workOut.setStatus(true);
            workOutDao.update(workOut);
        }
    }

    public WorkOut findById(Long id) {
        return workOutDao.find(id);
    }
}
