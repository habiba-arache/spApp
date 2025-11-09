package com.service;

import com.dao.UserDao;
import com.dao.WeightRecordDao;
import com.model.User;
import com.model.WeightRecord;

import java.time.LocalDate;
import java.util.List;

public class WeightRecordService {

    private final WeightRecordDao weightRecordDao = new WeightRecordDao();
    private final UserDao userDao = new UserDao();

    // add a new record
    public void addWeightRecord(Long userId, float weight) {
        User user = userDao.getUserById(userId);
        if (user == null) return;

        WeightRecord existingRecord = weightRecordDao.getRecordByDate(user, LocalDate.now());
        if (existingRecord == null) {
            WeightRecord newRecord = new WeightRecord(weight, LocalDate.now(), user);
            weightRecordDao.saveOrUpdateWeightRecord(newRecord);
        } else {
            existingRecord.setWeight(weight);
            weightRecordDao.saveOrUpdateWeightRecord(existingRecord);
        }
        // update weight in user
        user.setWeight(weight);
        userDao.updateUser(user);
    }

    // simple update method
    public void updateUserWeight(Long userId, float newWeight) {
        addWeightRecord(userId, newWeight);
    }

    public List<WeightRecord> getUserWeightRecords(User user) {
        return weightRecordDao.getRecordsByUser(user);
    }

    public WeightRecord getLatestWeight(User user) {
        return weightRecordDao.getLatestRecord(user);
    }
}
