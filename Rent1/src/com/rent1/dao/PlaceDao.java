package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import com.rent1.entity.Place;
import com.rent1.service.LongLatService;

public enum PlaceDao {
	INSTANCE;

	private Place addPlace(Place place) {
		ofy().save().entity(place).now();
		return place;
	}

	public Place getPlaceByRegoin(String city, String state, String country) {
		Place p = ofy().load().type(Place.class)
				.filter("city", city)
				.filter("state", state)
				.filter("country", country)
				.first().now();

		if (p == null) {
			p = LongLatService.createPlace(city, state, country);
			if (p != null) {
				// Save it
				addPlace(p);
			}
		}
		return p;
	}
}
