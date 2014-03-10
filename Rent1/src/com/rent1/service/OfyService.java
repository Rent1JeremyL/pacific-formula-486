package com.rent1.service;

import org.apache.commons.logging.impl.Log4JLogger;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.ObjectifyService;
import com.rent1.entity.Company;
import com.rent1.entity.Office;
import com.rent1.entity.Place;
import com.rent1.entity.PricePlan;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.ProductDetail;
import com.rent1.entity.RentalProduct;
import com.rent1.entity.User;

public class OfyService {
	private static final Log4JLogger log = new Log4JLogger(
			OfyService.class.getName());

	static {
		long time = System.currentTimeMillis();
		factory().register(Company.class);
		factory().register(Office.class);
		factory().register(Place.class);
		factory().register(PricePlan.class);
		factory().register(DefaultProduct.class);
		factory().register(ProductDetail.class);
		factory().register(RentalProduct.class);
		factory().register(User.class);

		long millis = System.currentTimeMillis() - time;
		log.info("Registration took " + millis + " millis");
	}

	public static Objectify ofy() {
		return ObjectifyService.ofy();
	}

	public static ObjectifyFactory factory() {
		return ObjectifyService.factory();
	}
}