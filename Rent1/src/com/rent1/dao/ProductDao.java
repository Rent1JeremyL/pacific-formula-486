package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.List;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Work;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.ProductDetail;

public enum ProductDao {
	INSTANCE;

	public List<DefaultProduct> getProducts() {
		List<DefaultProduct> prods = ofy().load().type(DefaultProduct.class).list();

		return prods;
	}

	public List<DefaultProduct> getProductsByCategory(String category) {
		List<DefaultProduct> prods = ofy().load().type(DefaultProduct.class)
		.filter("category ==", category)
		.list();

		return prods;
	}

	public DefaultProduct addProduct(DefaultProduct prod) {
		ofy().save().entity(prod).now();
		return prod;
	}

	public DefaultProduct addProductLinkProductDetail(final DefaultProduct prod, final ProductDetail pDet) {
		DefaultProduct p = ofy().transact(new Work<DefaultProduct>() {
		    public DefaultProduct run() {
		    	Key<DefaultProduct> pk = ofy().save().entity(prod).now();
		        pDet.setProductKey(pk);
		        ofy().save().entity(pDet).now();
		        prod.setProductDetail(pDet);
		        ofy().save().entity(prod).now();
		        return prod;
		    }
		});
		return p;
	}
	
	public int getProductCount() {
		return ofy().load().type(DefaultProduct.class).count();
	}

}
