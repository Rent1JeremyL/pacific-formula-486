package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.List;
import java.util.Set;

import lombok.Getter;

import org.apache.log4j.Logger;

import com.beoui.geocell.GeocellManager;
import com.beoui.geocell.model.BoundingBox;
import com.beoui.geocell.model.Point;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.cmd.Query;
import com.rent1.entity.Office;
import com.rent1.entity.Place;
import com.rent1.entity.RentalProduct;
import com.rent1.utils.GeoUtils;
import com.rent1.utils.StringUtils2;

public enum RentalProductDao {
	INSTANCE;
	private static final Logger log = Logger.getLogger(RentalProductDao.class);
	public static final int RECORDS_PER_PAGE = 35;
	@Getter private int noOfRecords;

	public List<RentalProduct> getProducts() {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.list();
		this.noOfRecords = prods.size();

		return prods;
	}

	public List<RentalProduct> getProductsByCategory(String category) {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.filter("category", category).list();
		this.noOfRecords = prods.size();

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
		this.noOfRecords = prods.size();

		return prods;
	}

	public List<RentalProduct> getProductsByGeoCells(Place place, double radius) {

		Query<RentalProduct> query = ofy().load().type(RentalProduct.class);
		query = addGeoCellsToQuery(query, place, radius);

		List<RentalProduct> prods = query.list();
		// TODO filter using place.isIn
		this.noOfRecords = prods.size();

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
			String search, Place place, double radius, int offset) {
		Query<RentalProduct> query = ofy().load().type(RentalProduct.class);

		query = addSearchStringToQuery(query, search);
		query = addGeoCellsToQuery(query, place, radius);

		Query<RentalProduct> counter = query;
		this.noOfRecords = counter.count();

		query = query.offset(offset);
		query = query.limit(RECORDS_PER_PAGE);

		List<RentalProduct> prods = query.list();
		// TODO filter using place.isIn
		log.debug("Search returned [" + prods.size() + "] records");

		return prods;
	}

	private Query<RentalProduct> addGeoCellsToQuery(Query<RentalProduct> query,
			Place place, double radius) {
		BoundingBox bb = GeoUtils.generateBoundingBox(place, radius);
		List<String> cells = GeocellManager.bestBboxSearchCells(bb, null);

		query = query.filter("geoCells in", cells);
		return query;
	}

	public List<RentalProduct> getProductsBySearchStringAndGeoCells(
			String search, Place place, double radius) {
		return getProductsBySearchStringAndGeoCells(search, place, radius, 0);
	}

	public RentalProduct getProductById(Long id) {
		RentalProduct p = ofy().load().type(RentalProduct.class)
				.filter("id", id).first().now();
		this.noOfRecords = 1;
		return p;
	}

	private Query<RentalProduct> addSearchStringToQuery(
			Query<RentalProduct> query, String search) {
		Set<String> words;
		try {
			words = StringUtils2.tokenize(search);
		} catch (Exception e) {
			log.error(e.getMessage());
			log.error("Failed to tokenize search string. [ " + search + " ]");
			log.fatal("Search will return null");
			return null;
		}
		for (String word : words) {
			query = query.filter("searchStrings", word);
		}
		return query;
	}

	private Query<RentalProduct> addMakeModelToQuery(
			Query<RentalProduct> query, String search) {
		query = query.filter("compatibleMakeModel", search.toLowerCase());
		return query;
	}

	public List<RentalProduct> getProductsBySearchString(String search,
			int offset) {
		Query<RentalProduct> query = ofy().load().type(RentalProduct.class);

		query = addSearchStringToQuery(query, search);

		Query<RentalProduct> counter = query;
		this.noOfRecords = counter.count();

		query = query.offset(offset);
		query = query.limit(RECORDS_PER_PAGE);

		List<RentalProduct> prods = query.list();
		log.debug("Search returned [" + prods.size()
				+ "] records from a total of " + noOfRecords);

		return prods;
	}

	public List<RentalProduct> getProductsByOfficeKey(Key<Office> key) {
		List<RentalProduct> prods = ofy().load().type(RentalProduct.class)
				.filter("office", key).list();
		return prods;
	}

	public void deleteProductsByOfficeKey(Key<Office> officeKey) {
		List<RentalProduct> prods = getProductsByOfficeKey(officeKey);
		log.debug("Deleting [" + prods.size()
				+ "] RentalProduct record(s) from office [Key=" + officeKey
				+ "]");

		ofy().delete().entities(prods);
	}

	public void deleteProductById(Long prodId) {
		RentalProduct prod = getProductById(prodId);
		ofy().delete().entity(prod).now();
	}

	public List<RentalProduct> getAttachmentsForProduct(Long prodID,
			Place place, double radius, int offset) {
		RentalProduct prod = this.getProductById(prodID);
		String makeModel = prod.getMake() + " " + prod.getModelName();

		Query<RentalProduct> query = ofy().load().type(RentalProduct.class);
		query = addGeoCellsToQuery(query, place, radius);
		query = query.filter("attachment", true);
		query = addMakeModelToQuery(query, makeModel);

		Query<RentalProduct> counter = query;
		this.noOfRecords = counter.count();

		query = query.offset(offset);
		query = query.limit(RECORDS_PER_PAGE);

		List<RentalProduct> prods = query.list();
		log.debug("Search returned [" + prods.size()
				+ "] records from a total of " + noOfRecords);

		return prods;
	}

	public List<RentalProduct> getAttachmentsForProduct(Long prodID, int offset) {
		RentalProduct prod = this.getProductById(prodID);
		String makeModel = prod.getMake() + " " + prod.getModelName();

		Query<RentalProduct> query = ofy().load().type(RentalProduct.class);
		query = query.filter("attachment", true);
		query = addMakeModelToQuery(query, makeModel);

		Query<RentalProduct> counter = query;
		this.noOfRecords = counter.count();

		query = query.offset(offset);
		query = query.limit(RECORDS_PER_PAGE);

		List<RentalProduct> prods = query.list();
		log.debug("Search returned [" + prods.size()
				+ "] records from a total of " + noOfRecords);

		return prods;
	}
}
