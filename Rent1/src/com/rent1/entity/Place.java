package com.rent1.entity;

import java.util.Locale;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import com.beoui.geocell.model.BoundingBox;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.rent1.json.model.OpenStreetMap;

@Cache
@Entity
@NoArgsConstructor
@ToString(exclude = { "id", "latitude", "longitude" }, includeFieldNames = true)
public class Place {
	@Id @Getter @Setter private Long id;

	@Getter @Setter private double latitude; // North South
	@Getter @Setter private double longitude; // West East

	@Index @Getter @Setter private String city;
	@Index @Getter @Setter private String state;
	@Index @Getter @Setter private String country;
	@Getter @Setter private String country_code;

	public Place(OpenStreetMap oSM) {
		this(oSM, oSM.getAddress().getState());
	}

	/**
	 * 
	 * @param oSM
	 *            object from the JSON parse
	 * @param state
	 *            override the default State/Prov due to Google abbreviations
	 */
	public Place(OpenStreetMap oSM, String state) {
		this.latitude = oSM.getLat();
		this.longitude = oSM.getLon();
		this.city = oSM.getAddress().getCity();
		if (this.city == null)
			this.city = oSM.getAddress().getTown();
		this.country = oSM.getAddress().getCountry();
		this.country_code = oSM.getAddress().getCountry_code();

		this.state = state;
	}

	public Key<Place> getKey() {
		return Key.create(Place.class, id);
	}

	/**
	 * @return true if the center is inside the bounding box
	 */
	public boolean isIn(BoundingBox bb) {
		return getLatitude() < bb.getNorth() && getLatitude() > bb.getSouth()
				&& getLongitude() > bb.getWest()
				&& getLongitude() < bb.getEast();
	}

	public Locale getLocale() {
		return new Locale(country_code.toUpperCase());
	}
}
