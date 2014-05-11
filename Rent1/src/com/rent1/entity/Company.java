package com.rent1.entity;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;
import com.googlecode.objectify.annotation.Index;
import com.rent1.dao.CompanyDao;
import com.rent1.dao.UserDao;
import com.rent1.entity.group.CompanyGroup;
import com.rent1.reference.Address;

@Entity
@Cache
@NoArgsConstructor
public class Company {
	@Id @Getter @Setter private Long id;
	@Getter @Setter @Index private String name;
	@Getter @Setter @Index private String email;
	@Getter @Setter private Key<CompanyGroup> companyGroup;
	@Getter @Setter private String phoneNumber;
	@Getter @Setter private String faxNumber = "";
	@Ignore private List<Notice> notices;
	@Getter @Setter private Address address;

	@Override
	public String toString() {
		return this.name + "[" + this.email + "]";
	}

	public static Company registerCompany(String name, String email,
			String phone, User user) {
		Company comp = new Company();
		comp.setEmail(email);
		comp.setName(name);
		comp.setPhoneNumber(phone);
		Address addr = new Address();
		comp.setAddress(addr);
		CompanyDao.INSTANCE.addCompany(comp);
		try {
			UserDao.INSTANCE.linkCompany(user, comp);
			comp.setCompanyGroup(CompanyGroup.createGroup(name, user));
			CompanyDao.INSTANCE.addCompany(comp);
		} catch (Exception e) {
			// roll back
			CompanyDao.INSTANCE.deleteCompany(comp);
		}
		return comp;
	}

	public Key<Company> getKey() {
		return Key.create(Company.class, id);
	}
}
