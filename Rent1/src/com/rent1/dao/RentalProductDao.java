package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import com.beoui.geocell.GeocellManager;
import com.beoui.geocell.model.BoundingBox;
import com.beoui.geocell.model.Point;
import com.googlecode.objectify.cmd.Query;
import com.rent1.entity.Place;
import com.rent1.entity.RentalProduct;
import com.rent1.utils.GeoUtils;
import com.rent1.utils.StringUtils2;

public enum RentalProductDao {
	INSTANCE;
	private static final Logger log = Logger.getLogger(RentalProductDao.class);

	public List<RentalProduct> getProducts() {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.list();

		return prods;
	}

	public List<RentalProduct> getProductsByCategory(String category) {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.filter("category", category).list();

		return prods;
	}

	public void addProduct(RentalProduct prod) {
		ofy().save().entity(prod).now();
	}

	public int getProductCount() {
		return ofy().load().type(RentalProduct.class).count();
	}

	public List<RentalProduct> getProductsByPlaceAndCategory(Place place,
			String category) {
		Point p = new Point(place.getLatitude(), place.getLongitude());
		List<String> cells = GeocellManager.generateGeoCell(p);

		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.filter("category", category).filter("geoCells in", cells)
				.list();

		return prods;
	}

	public List<RentalProduct> getProductsByGeoCells(Place place, double radius) {
		BoundingBox bb = GeoUtils.generateBoundingBox(place, radius);
		List<String> cells = GeocellManager.bestBboxSearchCells(bb, null);

		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.filter("geoCells in", cells).list();
		// TODO filter using plase.isIn
		return prods;
	}

	/**
	 * 
	 * @param search
	 *            string to search
	 * @param place
	 *            a place in the world
	 * @param radius
	 *            in KM
	 * @return ArrayList of results
	 */
	public List<RentalProduct> getProductsBySearchStringAndGeoCells(
			String search, Place place, double radius) {
		Set<String> words;
		try {
			words = StringUtils2.tokenize(search);
		} catch (Exception e) {
			log.error(e.getMessage());
			log.error("Failed to tokenize search string. [ " + search + " ]");
			log.fatal("Search will return null");
			return null;
		}

		Query<RentalProduct> query = ofy().load().type(RentalProduct.class)
				.limit(100);

		for (String word : words) {
			query = query.filter("searchStrings", word);
		}

		BoundingBox bb = GeoUtils.generateBoundingBox(place, radius);
		List<String> cells = GeocellManager.bestBboxSearchCells(bb, null);

		query = query.filter("geoCells in", cells);
		// TODO filter using plase.isIn

		List<RentalProduct> prods = query.list();
		log.debug("Search returned [" + prods.size() + "] records");
		return prods;
	}

	public RentalProduct getProductById(Long id) {
		RentalProduct p = ofy().load().type(RentalProduct.class)
				.filter("id", id).first().now();

		return p;
	}
}
