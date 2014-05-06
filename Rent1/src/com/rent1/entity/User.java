package com.rent1.entity;

import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;
import com.googlecode.objectify.annotation.Index;
import com.rent1.dao.CompanyDao;
import com.rent1.dao.NoticeDao;
import com.rent1.dao.UserDao;
import com.rent1.reference.Address;
import com.rent1.utils.EncryptUtils;

@Entity
@NoArgsConstructor
public class User implements Serializable {
	private static final long serialVersionUID = 4569996182825475350L;
	private static final Logger log = Logger.getLogger(User.class);

	@Id @Getter @Setter private Long id;

	@Index @Getter @Setter private Long googleId = null;
	@Getter @Setter private String nickName;
	@Index @Getter @Setter private String email;
	@Getter @Setter private byte[] password;
	@Getter @Setter private byte[] salt;
	@Getter @Setter private String firstName = "";
	@Getter @Setter private String lastName = "";
	// TODO activate user
	@Index @Getter @Setter private boolean active = false;
	@Index @Getter @Setter private Key<Company> companyKey;
	@Ignore private List<Notice> notices;
	@Ignore @Setter private Company company;
	// TODO verify user
	@Index @Getter @Setter private boolean verified = false;

	@Getter @Setter private Address address;
	@Getter @Setter private String phone = "";
	@Getter @Setter private String fax = "";
	@Getter @Setter private String lastUpdated;

	public static User registerNewUser(String email, String pass)
			throws Exception {
		User u = new User();
		u.nickName = email;
		u.email = email;
		u.salt = EncryptUtils.generateSalt();
		u.password = EncryptUtils.getEncryptedPassword(pass, u.getSalt());
		Address addr = new Address();
		u.setAddress(addr);
		return UserDao.INSTANCE.addUser(u);
	}

	public void changePassword(String password) throws Exception {
		this.salt = EncryptUtils.generateSalt();
		this.password = EncryptUtils.getEncryptedPassword(password, salt);
	}

	public boolean authenticatePassword(String attemptedPassword) {
		try {
			return EncryptUtils.authenticate(attemptedPassword, getPassword(),
					getSalt());
		} catch (NoSuchAlgorithmException e) {
			log.error("User password corruption.  User ID: " + getId() + " - "
					+ e.getMessage());
		} catch (InvalidKeySpecException e) {
			log.error("User password corruption.  User ID: " + getId() + " - "
					+ e.getMessage());
		}
		return false;
	}

	public static User getUserSession(HttpServletRequest req) {
		User user = null;
		user = (User) req.getSession().getAttribute("user");
		return user;
	}

	public Key<User> getKey() {
		return Key.create(User.class, id);
	}

	public int getMessageCount() {
		int count = 0;
		try {
			count = getNotices(false).size();
		} catch (Exception e) {
			// Do nothing
		}
		return count;
	}

	/**
	 * Load and return the transient notices.
	 * 
	 * @param refresh
	 *            always use true after adding notices
	 * @return
	 */
	public List<Notice> getNotices(boolean refresh) {
		if (this.notices == null || refresh) {
			List<Notice> noticeProxy = NoticeDao.INSTANCE
					.getNoticesByUser(this);
			notices = new ArrayList<Notice>();
			for (Notice note : noticeProxy) {
				note.setUser(this);
				notices.add(note);
			}
		}
		return this.notices;
	}

	public Company getCompany() {
		if (getCompanyKey() == null) {
			return null;
		} else if (this.company == null) {
			company = CompanyDao.INSTANCE.getCompanyByKey(this.companyKey);
		}
		return company;
	}

	public boolean isAddressComplete() {
		try {
			if (StringUtils.isNotBlank(this.address.getStreet1().trim())
					&& StringUtils.isNotBlank(this.address.getCity().trim())
					&& StringUtils.isNotBlank(this.address.getState().trim())
					&& StringUtils.isNotBlank(this.address.getCountry().trim())
					&& StringUtils.isNotBlank(this.address.getPostCode().trim()))
				return true;
		} catch (NullPointerException e) {
			log.warn("Address not complete.");
			return false;
		}

		return false;
	}
}