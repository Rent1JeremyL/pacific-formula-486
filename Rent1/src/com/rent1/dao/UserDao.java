package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import org.apache.commons.logging.impl.Log4JLogger;

import com.rent1.entity.User;

public enum UserDao {
	INSTANCE;
	private static final Log4JLogger log = new Log4JLogger(
			UserDao.class.getName());

	public User addUser(User user) {
		ofy().save().entity(user).now();
		return user;
	}

	public User getUserById(Long userID) {
		User user = ofy().load().type(User.class)
		.filter("id", userID)
		.first().now();

		return user;
	}

	public User getUserByEmail(String email) {
		try {
			User user = ofy().load().type(User.class)
			.filter("email", email)
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
}
