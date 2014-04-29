package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
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
	public Place getPlaceByRegion(String city, String state, String country) {
		Place p = ofy().load().type(Place.class).filter("city", city)
				.filter("state", state).filter("country", country).first()
				.now();

		if (p == null) {
			log.debug("The region " + city + " " + state + ", " + country
					+ " was not found. Trying to add a new Place via OSM.");
			p = LongLatService.createPlace(city, state, country);

			if (p != null) {
				Place newP = ofy().load().type(Place.class)
						.filter("city", p.getCity())
						.filter("state", p.getState())
						.filter("country", p.getCountry()).first().now();
				// Found a previous entry
				if (newP != null) {
					//[Defect 1] Set google values to place
					Place pGoogle = new Place();
					pGoogle.setCity(city);
					pGoogle.setState(state);
					pGoogle.setCountry(country);
					pGoogle.setLatitude(newP.getLatitude());
					pGoogle.setLongitude(newP.getLongitude());
					pGoogle.setCountry_code(newP.getCountry_code());
					addPlace(pGoogle);
					log.debug("Added Place[" + pGoogle.toString() + "]");
					return newP;
				}else{
					addPlace(p);
					log.debug("Added Place[" + p.toString() + "]");
				}
			}
		}
		return p;
	}

	public Place getPlaceByKey(Key<Place> placeKey) {
		Place p = ofy().load().type(Place.class).filterKey("=", placeKey)
				.list().get(0);
		return p;
	}
}
