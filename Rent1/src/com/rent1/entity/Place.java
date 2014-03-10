package com.rent1.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.rent1.json.model.OpenStreetMap;

@Cache
@Entity
@NoArgsConstructor
public class Place {
	@Id
	@Getter
	@Setter
	private Long id;

	@Getter
	@Setter
	private double latitude;
	@Getter
	@Setter
	private double longtitude;

	@Index
	@Getter
	@Setter
	private String city;
	@Index
	@Getter
	@Setter
	private String state;
	@Index
	@Getter
	@Setter
	private String country;

	public Place(OpenStreetMap oSM) {
		this.latitude = oSM.getLat();
		this.longtitude = oSM.getLon();
		this.city = oSM.getAddress().getCity();
		if (this.city == null)
			this.city = oSM.getAddress().getTown();
		this.state = oSM.getAddress().getState();
		this.country = oSM.getAddress().getCountry();
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
		this.longtitude = oSM.getLon();
		this.city = oSM.getAddress().getCity();
		if (this.city == null)
			this.city = oSM.getAddress().getTown();
		this.country = oSM.getAddress().getCountry();

		this.state = state;
	}
}
