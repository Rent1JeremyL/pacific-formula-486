package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import com.googlecode.objectify.Key;
import com.rent1.entity.Company;

public enum CompanyDao {
	INSTANCE;

	public Company addCompany(Company company) {
		ofy().save().entity(company).now();
		return company;
	}

	public Company getCompanyByName(String name) {
		Company comp = ofy().load().type(Company.class).filter("name", name)
				.first().now();

		return comp;
	}


	public Company getCompanyByNameAndEmail(String name, String email) {
		Company comp = ofy().load().type(Company.class).filter("name", name)
				.filter("email", email).first().now();

		return comp;
	}

	public void deleteCompany(Company company){
		ofy().delete().entity(company).now();
	}

	public Company getCompanyByKey(Key<Company> companyKey) {
		return ofy().load().key(companyKey).now();
	}
}
