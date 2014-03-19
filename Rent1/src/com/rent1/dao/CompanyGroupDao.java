package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import com.googlecode.objectify.Key;
import com.rent1.entity.group.CompanyGroup;

public enum CompanyGroupDao {
	INSTANCE;

	public CompanyGroup addGroup(CompanyGroup group) {
		ofy().save().entity(group).now();
		return group;
	}

	public CompanyGroup getGroupByName(String name) {
		CompanyGroup group = ofy().load().type(CompanyGroup.class).filter("name", name)
				.first().now();

		return group;
	}

	public void deleteGroup(CompanyGroup group) {
		ofy().delete().entity(group).now();
	}

	public CompanyGroup getGroupByKey(Key<CompanyGroup> groupKey) {
		return ofy().load().key(groupKey).now();
	}
}
