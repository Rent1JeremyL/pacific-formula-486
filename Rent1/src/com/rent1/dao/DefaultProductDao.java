package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.Collections;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Work;
import com.googlecode.objectify.cmd.Query;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.ProductDetail;
import com.rent1.utils.StringUtils2;

public enum DefaultProductDao {
	INSTANCE;
	private static final Logger log = Logger.getLogger(DefaultProductDao.class);

	public List<DefaultProduct> getProducts() {
		List<DefaultProduct> prods = ofy().load().type(DefaultProduct.class)
				.list();

		Collections.sort(prods);
		return prods;
	}

	public List<DefaultProduct> getProductsByCategory(String category) {
		List<DefaultProduct> prods = ofy().load().type(DefaultProduct.class)
				.filter("category", category).list();

		Collections.sort(prods);

		return prods;
	}

	public DefaultProduct addProduct(DefaultProduct prod) {
		ofy().save().entity(prod).now();
		return prod;
	}

	/**
	 * Add a DefaultProduct and link one to one with ProductDetail
	 * 
	 * @param prod
	 * @param pDet
	 * @return the product with links
	 */
	public DefaultProduct addProductLinkProductDetail(
			final DefaultProduct prod, final ProductDetail pDet) {
		ofy().transact(new Work<DefaultProduct>() {
			public DefaultProduct run() {
				Key<DefaultProduct> pk = ofy().save().entity(prod).now();
				pDet.setProductKey(pk);
				ofy().save().entity(pDet).now();
				prod.setProductDetail(pDet);
				ofy().save().entity(prod).now();
				return prod;
			}
		});
		return prod;
	}

	public int getProductCount() {
		return ofy().load().type(DefaultProduct.class).count();
	}

	public List<DefaultProduct> getProductsBySearchString(String search) {
		Set<String> words;
		try {
			words = StringUtils2.tokenize(search);
		} catch (Exception e) {
			log.error(e.getMessage());
			log.error("Failed to tokenize search string. [ " + search + " ]");
			log.fatal("Search will return null");
			return null;
		}

		Query<DefaultProduct> query = ofy().load().type(DefaultProduct.class);

		for (String word : words) {
			query = query.filter("searchStrings", word);
		}

		List<DefaultProduct> prods = query.list();

		return prods;
	}

	public DefaultProduct getProductById(int id) {
		DefaultProduct p = ofy().load().type(DefaultProduct.class)
				.filter("id", id).first().now();

		return p;
	}
}
