package com.rent1.entity;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;
import com.rent1.dao.UserDao;

@Entity
@Cache
@NoArgsConstructor
public class Notice {
	private static final Logger log = Logger.getLogger(Notice.class);
	private static final String COMPANY_ALERT = "You have been added to the company: ";

	@Id
	@Getter
	@Setter
	private Long id;
	@Index
	@Getter
	@Setter
	@Parent
	private Key<User> userKey;
	@Ignore
	@Setter
	private User user;
	@Getter
	@Setter
	private String message;
	@Getter
	@Setter
	private boolean read = false;
	@Getter
	private Date createDate = new Date();

	public static Notice newCompanyAlert(Company comp, User user) {
		Notice note = new Notice();
		note.setUserKey(user.getKey());
		note.setUser(user);
		note.setMessage(COMPANY_ALERT.concat(comp.getName()));
		return note;
	}

	public User getUser() {
		if (this.user == null) {
			this.user = UserDao.INSTANCE.getUserByKey(userKey);
		}
		return this.user;
	}
}