package com.service;

import com.dao.UserDao;
import com.model.User;

import java.sql.SQLException;

public class UserService {
    UserDao userDao = new UserDao();

    public User login(String email, String password) throws SQLException {
        User user = userDao.getUserByEmail(email);
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }
    public void register(User user) throws SQLException {
        userDao.createUser(user);
    }

    public void delete(Long id) throws SQLException {
        userDao.deleteUser(id);
    }

    public void update(User user) throws SQLException {
        userDao.updateUser(user);
    }
}