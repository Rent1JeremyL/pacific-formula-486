package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Work;
import com.rent1.entity.Company;
import com.rent1.entity.Notice;
import com.rent1.entity.User;

public enum UserDao {
	INSTANCE;
	private static final Logger log = Logger.getLogger(UserDao.class);

	public User addUser(User user) {
		ofy().save().entity(user).now();
		return user;
	}

	public User getUserById(Long userID) {
		User user = ofy().load().type(User.class).filter("id", userID).first()
				.now();

		return user;
	}

	public User getUserByEmail(String email) {
		try {
			User user = ofy().load().type(User.class).filter("email", email)
					.first().now();

			return user;
		} catch (Exception e) {
			log.debug("getUserByEmail: [" + email + "]Exception:"
					+ e.getMessage());
			return null;
		}
	}

	public User updateUser(User user) {
		ofy().save().entity(user).now();
		return user;
	}

	public User linkCompany(final User user, Company comp) {
		user.setCompany(comp.getKey());
		final Notice note = Notice.newCompanyAlert(comp, user);

		ofy().transact(new Work<User>() {
			public User run() {
				ofy().save().entity(note).now();
				ofy().save().entity(user).now();
				return user;
			}
		});
		user.getNotices(true);
		return user;
	}

	public User getUserByKey(Key<User> userKey) {
		return ofy().load().key(userKey).now();
	}
}
