package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.rent1.entity.Company;
import com.rent1.entity.Office;

public enum OfficeDao {
	INSTANCE;
	private static final Logger log = Logger.getLogger(OfficeDao.class);

	public Office addOffice(Office office) {
		ofy().save().entity(office).now();
		return office;
	}

	public Office getOfficeById(Long userID) {
		Office office = ofy().load().type(Office.class).filter("id", userID)
				.first().now();

		return office;
	}

	public Office getOfficeByKey(Key<Office> officeKey) {
		return ofy().load().key(officeKey).now();
	}

	public List<Office> getOfficesByKeys(Set<Key<Office>> memberKeys) {
		Map<Key<Office>, Office> offices = ofy().load().keys(memberKeys);
		offices.values();
		return (List<Office>) offices.values();
	}
	
	public List<Office> getOfficesByCompany(Company company){
		List<Office> offices = ofy().load().type(Office.class)
				.filter("companyKey", company.getKey()).list();
		
		return offices;
	}
}
