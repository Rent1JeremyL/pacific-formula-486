package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.List;

import com.rent1.entity.RentalProduct;

public enum RentalProductDao {
	INSTANCE;

	public List<RentalProduct> getProducts() {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class).list();

		return prods;
	}

	public List<RentalProduct> getProductsByCategory(String category) {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
		.filter("category", category)
		.list();

		return prods;
	}

	public void addProduct(RentalProduct prod) {
		ofy().save().entity(prod).now();
	}

	public int getProductCount() {
		return ofy().load().type(RentalProduct.class).count();
	}
}
