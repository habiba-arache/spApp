package com.dao;

import com.model.Diet;
import com.model.User;
import com.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class DietDao {

    public void save(Diet diet) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(diet);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public List<Diet> getByUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Diet> query = session.createQuery("FROM Diet d WHERE d.user.id = :uid", Diet.class);
            query.setParameter("uid", userId);
            return query.list();
        }
    }

    public void deleteByUser(User user) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Query query = session.createQuery("DELETE FROM Diet d WHERE d.user.id = :uid");
            query.setParameter("uid", user.getId());
            query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}
