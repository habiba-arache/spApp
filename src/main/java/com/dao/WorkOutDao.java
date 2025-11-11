package com.dao;

import com.model.User;
import com.model.WorkOut;
import com.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class WorkOutDao {

    public void save(WorkOut workOut) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(workOut);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public void update(WorkOut workOut) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(workOut);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    // delete user's old workout
    public void deleteByUser(User user) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Query query = session.createQuery("DELETE FROM WorkOut w WHERE w.user.id = :uid");
            query.setParameter("uid", user.getId());
            query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    // get user's workout
    public List<WorkOut> findByUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<WorkOut> query = session.createQuery("FROM WorkOut w WHERE w.user.id = :uid", WorkOut.class);
            query.setParameter("uid", userId);
            return query.list();
        }
    }

    public WorkOut find(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(WorkOut.class, id);
        }
    }

}
