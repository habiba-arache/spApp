package com.service;

import com.dao.DietDao;
import com.model.Diet;
import com.model.User;

import java.sql.SQLException;
import java.util.List;

public class DietService {
    DietDao dietDao = new DietDao();

    public List<Diet> getDiet(Long id)  {
        return dietDao.getByUserId(id);
    }

    public void addDiet(Diet diet)   {
        dietDao.save(diet);
    }
    public void delete(User user)  {
        dietDao.deleteByUser(user);
    }
}