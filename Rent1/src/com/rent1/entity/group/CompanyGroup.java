package com.rent1.entity.group;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;
import com.rent1.dao.CompanyGroupDao;
import com.rent1.dao.UserDao;
import com.rent1.entity.Company;
import com.rent1.entity.User;

@Entity
@Cache
@NoArgsConstructor
public class CompanyGroup {
	@Id
	@Getter
	@Setter
	private Long id;
	@Getter
	@Setter
	@Index
	private String name;
	@Getter
	@Setter
	@Parent
	private Key<Company> companyKey;
	@Getter
	@Setter
	private Key<User> adminKey;
	@Getter
	@Setter
	private Set<Key<User>> memberKeys;
	@Getter
	@Setter
	@Index
	private boolean active = true;
	@Ignore
	private List<User> members;

	public Key<CompanyGroup> getKey() {
		return Key.create(CompanyGroup.class, id);
	}

	public static Key<CompanyGroup> createGroup(String groupName, User owner) {
		CompanyGroup group = new CompanyGroup();
		group.setName(groupName);
		group.setAdminKey(owner.getKey());
		group.setCompanyKey(owner.getCompanyKey());
		Set<Key<User>> memKeys = new HashSet<Key<User>>();
		memKeys.add(owner.getKey());
		group.setMemberKeys(memKeys);
		CompanyGroupDao.INSTANCE.addGroup(group);

		return group.getKey();
	}

	public List<User> getMembers() {
		if (this.members == null) {
			this.members = UserDao.INSTANCE.getUsersByKeys(memberKeys);
		}
		return this.members;
	}
}
