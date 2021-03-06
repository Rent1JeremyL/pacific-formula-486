package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Work;
import com.rent1.entity.Company;
import com.rent1.entity.Notice;
import com.rent1.entity.User;

public enum UserDao {
	INSTANCE;
	private static final Logger log = Logger.getLogger(UserDao.class);
	private static final String DATE_FROMAT = "yyyy/MM/dd HH:mm:ss";

	public User addUser(User user) {
		DateFormat dateFormat = new SimpleDateFormat(DATE_FROMAT);
		Date now = new Date();
		user.setLastUpdated(dateFormat.format(now));

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
		DateFormat dateFormat = new SimpleDateFormat(DATE_FROMAT);
		Date now = new Date();
		user.setLastUpdated(dateFormat.format(now));

		ofy().save().entity(user).now();
		return user;
	}

	public User linkCompany(final User user, Company comp) {
		user.setCompanyKey(comp.getKey());
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

	public List<User> getUsersByKeys(Set<Key<User>> memberKeys) {
		Map<Key<User>, User> users = ofy().load().keys(memberKeys);
		users.values();
		return (List<User>) users.values();
	}
}
