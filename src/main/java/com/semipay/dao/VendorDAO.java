package com.semipay.dao;

import java.util.List;
import java.util.Iterator;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Transaction;
import org.hibernate.HibernateException; 


import com.semipay.model.Vendor;

public class VendorDAO {
    
    private SessionFactory sessionFactory  = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    public List<Vendor> getAll() {
    	System.out.println("XXX");
        Session session = sessionFactory.openSession();
		Transaction transaction = null;
        try {
			transaction = session.beginTransaction();
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
	        CriteriaQuery<Vendor> criteriaQuery = criteriaBuilder.createQuery(Vendor.class);
	        Root<Vendor> from = criteriaQuery.from(Vendor.class);
	        CriteriaQuery<Vendor> select = criteriaQuery.select(from);
	        TypedQuery<Vendor> typedQuery = session.createQuery(select);
	        List<Vendor> vendors = typedQuery.getResultList();
	        transaction.commit();
            return vendors;
         } catch (HibernateException e) {
        	System.out.println("XXX");
            e.printStackTrace(); 
         } finally {
            session.close(); 
         }
		return null;
        
        
    }
    
    public Vendor get(int vendorId) {
        Vendor vendor = (Vendor) sessionFactory.getCurrentSession().get(Vendor.class, vendorId);
        return vendor;
    }
    
    public String update(Vendor vendor) {
        sessionFactory.getCurrentSession().update(vendor);
        return "User information updated successfully";
    }
    
    public String remove(Vendor vendor) {
        sessionFactory.getCurrentSession().delete(vendor);
        return "User information with id " + vendor.getId() + " deleted successfully";
    }
}