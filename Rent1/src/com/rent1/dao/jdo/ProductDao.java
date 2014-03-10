package com.rent1.dao.jdo;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.rent1.entity.DefaultProduct;
import com.rent1.service.PersistenceService;

public enum ProductDao {
	INSTANCE;

	@SuppressWarnings("unchecked")
	public List<DefaultProduct> listProducts() {
		PersistenceManager pm = PersistenceService.getInstance()
				.getPersistenceManager();
		// read the existing entries
		Query q = pm.newQuery(DefaultProduct.class);
		List<DefaultProduct> prods = (List<DefaultProduct>) q.execute();

		pm.close();
		return prods;
	}

	@SuppressWarnings("unchecked")
	public List<DefaultProduct> getProductsByCategory(String category) {
		PersistenceManager pm = PersistenceService.getInstance()
				.getPersistenceManager();
		// read the existing entries
		Query q = pm.newQuery(DefaultProduct.class);
		q.setFilter("category == myCategory");
		q.declareParameters("String myCategory");
		List<DefaultProduct> prods = (List<DefaultProduct>) q.execute(category);

		pm.close();
		return prods;
	}

	public void addProduct(DefaultProduct prod) {
		synchronized (this) {
			PersistenceManager pm = PersistenceService.getInstance()
					.getPersistenceManager();
			pm.makePersistent(prod);
			pm.close();
		}
	}

	public Long getProductCount() {
		PersistenceManager pm = PersistenceService.getInstance()
				.getPersistenceManager();
		Query q = pm.newQuery(DefaultProduct.class);
		q.setResult("count(this)");
		q.setUnique(true);
		Long count = (Long) q.execute();

		pm.close();
		return count;
	}
}
