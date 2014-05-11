package com.rent1.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.rent1.entity.DefaultProduct;
import com.rent1.service.EMFService;
@Deprecated
public enum ProductDao {
	INSTANCE;
	private static final String LIST_PRODUCTS = "select p from Product p";
	private static final String LIST_PROD_BY_CATEGORY = "select p from Product p where p.prodCategory = :category";
	private static final String COUNT_PRODUCTS = "select count(p) from "
			+ DefaultProduct.class + " p";

	@SuppressWarnings("unchecked")
	public List<DefaultProduct> listProducts() {
		EntityManager em = EMFService.getInstance().createEntityManager();
		// read the existing entries
		Query q = em.createQuery(LIST_PRODUCTS);
		List<DefaultProduct> prods = q.getResultList();

		em.close();
		return prods;
	}

	@SuppressWarnings("unchecked")
	public List<DefaultProduct> getProductsByCategory(String category) {
		EntityManager em = EMFService.getInstance().createEntityManager();
		Query q = em.createQuery(LIST_PROD_BY_CATEGORY);
		q.setParameter("category", category);
		List<DefaultProduct> prods = q.getResultList();

		em.close();
		return prods;
	}

	public void addProduct(DefaultProduct prod) {
		synchronized (this) {
			EntityManager em = EMFService.getInstance().createEntityManager();
			em.persist(prod);
			em.close();
		}
	}

	public Long getProductCount() {
		EntityManager em = EMFService.getInstance().createEntityManager();
		Query q = em.createQuery(COUNT_PRODUCTS);
		Long count = (Long) q.getSingleResult();

		em.close();
		return count;
	}

}
