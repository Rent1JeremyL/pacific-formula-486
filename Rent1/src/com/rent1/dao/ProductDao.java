package com.rent1.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.rent1.entity.EMFService;
import com.rent1.entity.Product;

public enum ProductDao {
	INSTANCE;
	private String LIST_PRODUCTS = "select p from Product p";
	private String LIST_PROD_BY_CATAGORY = "select p from Product p where p.prodCatagory = :catagory";
	private String COUNT_PRODUCTS = "select count(p) from Product p";

	@SuppressWarnings("unchecked")
	public List<Product> listProducts() {
		EntityManager em = EMFService.getInstance().createEntityManager();
		// read the existing entries
		//em.persist(new Product());
		Query q = em.createQuery(LIST_PRODUCTS);
		List<Product> prods = q.getResultList();
		return prods;
	}

	@SuppressWarnings("unchecked")
	public List<Product> getProducts(String catagory) {
		EntityManager em = EMFService.getInstance().createEntityManager();
		//em.persist(new Product());
		Query q = em.createQuery(LIST_PROD_BY_CATAGORY);
		q.setParameter("catagory", catagory);
		List<Product> prods = q.getResultList();
		return prods;
	}

	public void addProduct(Product prod) {
		synchronized (this) {
			EntityManager em = EMFService.getInstance().createEntityManager();
			em.persist(prod);
			em.close();
		}
	}

	public Long getProductCount() {
		EntityManager em = EMFService.getInstance().createEntityManager();
		em.persist(new Product());
		Query q = em.createQuery(COUNT_PRODUCTS);
		Long count = (Long) q.getSingleResult();
		return count;
	}
}
