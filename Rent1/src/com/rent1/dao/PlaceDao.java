package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import org.apache.log4j.Logger;

import com.rent1.entity.Place;
import com.rent1.service.LongLatService;

/**
 * The {@code PlaceDao} class is the generic interface to the DB or Datastore.
 * 
 * <p>
 * Copyright © 2014 RENT1.COM
 * 
 * @author Jeremy Leeder
 */
public enum PlaceDao {
	/**
	 * Static reference to the {@code PlaceDao}
	 */
	INSTANCE;

	private static final Logger log = Logger.getLogger(PlaceDao.class);

	/**
	 * Add a place
	 * 
	 * @param place
	 * @return the place with a Key
	 */
	private Place addPlace(Place place) {
		ofy().save().entity(place).now();
		return place;
	}

	/**
	 * Get a place from DB if missing query Long/Lat Service and add to DB
	 * 
	 * @param city
	 * @param state
	 * @param country
	 * @return a fully qualified place
	 */
	public Place getPlaceByRegoin(String city, String state, String country) {
		Place p = ofy().load().type(Place.class).filter("city", city)
				.filter("state", state).filter("country", country).first()
				.now();

		if (p == null) {
			log.debug("The region " + city + ", " + state
					+ " was not found. Trying to add a new Place via OSM.");
			p = LongLatService.createPlace(city, state, country);
			if (p != null) {
				// Save it
				addPlace(p);
				log.debug("Added Place[" + p.toString() + "]");
			}
		}
		return p;
	}
}
