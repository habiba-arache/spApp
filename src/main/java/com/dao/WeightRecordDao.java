package com.dao;

import com.model.WeightRecord;
import com.model.User;
import com.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDate;
import java.util.List;

public class WeightRecordDao {

     public void saveOrUpdateWeightRecord(WeightRecord record) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(record);  // merge gère save + update
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

     public List<WeightRecord> getRecordsByUser(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<WeightRecord> query = session.createQuery(
                    "FROM WeightRecord WHERE user = :user ORDER BY date ASC", WeightRecord.class);
            query.setParameter("user", user);
            return query.list();
        }
    }

     public WeightRecord getLatestRecord(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<WeightRecord> query = session.createQuery(
                    "FROM WeightRecord WHERE user = :user ORDER BY date DESC", WeightRecord.class);
            query.setParameter("user", user);
            query.setMaxResults(1);
            return query.uniqueResult();
        }
    }

     public WeightRecord getRecordByDate(User user, LocalDate date) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<WeightRecord> query = session.createQuery(
                    "FROM WeightRecord WHERE user = :user AND date = :date", WeightRecord.class);
            query.setParameter("user", user);
            query.setParameter("date", date);
            return query.uniqueResult();
        }
    }
}
