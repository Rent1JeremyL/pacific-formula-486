package com.rent1.service;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.ObjectifyService;
import com.rent1.entity.Company;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.Notice;
import com.rent1.entity.Office;
import com.rent1.entity.Order;
import com.rent1.entity.RentalRequest;
import com.rent1.entity.Place;
import com.rent1.entity.PricePlan;
import com.rent1.entity.ProductDetail;
import com.rent1.entity.RentalProduct;
import com.rent1.entity.User;
import com.rent1.entity.group.CompanyGroup;

public class OfyService {
	private static final Logger log = Logger.getLogger(OfyService.class
			.getName());

	static {
		long time = System.currentTimeMillis();
		factory().register(Company.class);
		factory().register(DefaultProduct.class);
		factory().register(Notice.class);
		factory().register(Office.class);
		factory().register(Place.class);
		factory().register(PricePlan.class);
		factory().register(ProductDetail.class);
		factory().register(RentalProduct.class);
		factory().register(User.class);
		factory().register(RentalRequest.class);
		factory().register(Order.class);
		
		factory().register(CompanyGroup.class);

		long millis = System.currentTimeMillis() - time;
		log.info("Registration took " + millis + " ms");
	}

	public static Objectify ofy() {
		return ObjectifyService.ofy();
	}

	public static ObjectifyFactory factory() {
		return ObjectifyService.factory();
	}
}