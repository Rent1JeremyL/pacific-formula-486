package com.rent1.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.rent1.dao.OfficeDao;
import com.rent1.dao.PlaceDao;
import com.rent1.reference.Address;

@Entity
@Cache
@NoArgsConstructor
public class Office {
	@Id @Getter @Setter private Long id;

	@Index @Getter @Setter private Key<Company> companyKey;
	@Getter @Setter private Address address;
	@Getter @Setter private String phone = "";
	@Getter @Setter private String fax = "";
	@Getter @Setter private Key<Place> placeKey;

	public Key<Office> getKey() {
		return Key.create(Office.class, id);
	}

	@Override
	public String toString() {
		return this.address.getStreet1().concat(
				" " + this.address.getCity() + ", " + this.address.getState());
	}

	public String toShortString() {
		return this.address.getStreet1().concat(" " + this.address.getCity());
	}

	public static Office createOffice(Company comp, String street1,
			String street2, String city, String postCode, String state,
			String country, String phone, String fax) throws Exception {

		Place here = PlaceDao.INSTANCE.getPlaceByRegion(city, state, country);

		if (!here.getCity().equals(city) && !here.getCity().contains(city)) {
			throw new Exception("The office address does not exist.");
		}
		
		Address addr = new Address();
		addr.setStreet1(street1);
		addr.setStreet2(street2);
		addr.setCity(here.getCity());
		addr.setPostCode(postCode);
		addr.setState(here.getState());
		addr.setCountry(here.getCountry());
		
		Office office = new Office();
		office.setAddress(addr);
		office.setPhone(phone);
		office.setFax(fax);

		office.setPlaceKey(here.getKey());
		office.setCompanyKey(comp.getKey());

		OfficeDao.INSTANCE.addOffice(office);

		return office;
	}
}
