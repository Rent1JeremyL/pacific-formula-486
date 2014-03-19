package com.rent1.entity;

import java.util.Set;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;
import com.rent1.dao.OfficeDao;
import com.rent1.dao.PlaceDao;

@Entity
@Cache
@NoArgsConstructor
public class Office {
	@Id
	@Getter
	@Setter
	private Long id;

	@Index
	@Getter
	@Setter
	private Key<Company> companyKey;
	@Getter
	@Setter
	private String street1;
	@Getter
	@Setter
	private String street2 = "";
	@Getter
	@Setter
	private String city;
	@Getter
	@Setter
	private String postCode;
	@Getter
	@Setter
	private String country;
	@Getter
	@Setter
	private String state;
	@Getter
	@Setter
	private String phone = "";
	@Getter
	@Setter
	private String fax = "";
	@Load
	private Set<Ref<RentalProduct>> equipment;
	@Getter
	@Setter
	private Key<Place> placeKey;

	public Key<Office> getKey() {
		return Key.create(Office.class, id);
	}

	@Override
	public String toString() {
		return street1.concat(" " + city + ", " + state);
	}

	public String toShortString() {
		return street1.concat(" " + city);
	}

	public static Office createOffice(Company comp, String street1,
			String street2, String city, String postCode, String state,
			String country, String phone, String fax) {

		Place here = PlaceDao.INSTANCE.getPlaceByRegoin(city, state, country);

		Office office = new Office();
		office.setStreet1(street1);
		office.setStreet2(street2);
		office.setCity(city);
		office.setPostCode(postCode);
		office.setState(state);
		office.setCountry(country);
		office.setPhone(phone);
		office.setFax(fax);

		office.setPlaceKey(here.getKey());
		office.setCompanyKey(comp.getKey());

		OfficeDao.INSTANCE.addOffice(office);

		return office;
	}
}
