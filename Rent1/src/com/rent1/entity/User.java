package com.rent1.entity;

import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Serialize;
import com.rent1.dao.CompanyDao;
import com.rent1.dao.NoticeDao;
import com.rent1.dao.UserDao;
import com.rent1.utils.EncryptUtils;

@Entity
@Serialize
@NoArgsConstructor
public class User implements Serializable {
	private static final long serialVersionUID = 4569996182825475350L;
	private static final Logger log = Logger.getLogger(User.class);

	@Id
	@Getter
	@Setter
	private Long id;

	@Index
	@Getter
	@Setter
	private Long googleId = null;
	@Getter
	@Setter
	private String nickName;
	@Index
	@Getter
	@Setter
	private String email;
	@Getter
	@Setter
	private byte[] password;
	@Getter
	@Setter
	private byte[] salt;
	@Getter
	@Setter
	private String firstName = "";
	@Getter
	@Setter
	private String lastName = "";
	@Index
	@Getter
	@Setter
	private boolean active = false;
	@Index
	@Getter
	@Setter
	private Key<Company> companyKey;
	@Ignore
	private List<Notice> notices;
	@Ignore
	@Setter
	private Company company;

	public static User registerNewUser(String email, String pass)
			throws Exception {
		User u = new User();
		u.nickName = email;
		u.email = email;
		u.salt = EncryptUtils.generateSalt();
		u.password = EncryptUtils.getEncryptedPassword(pass, u.getSalt());
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
			this.notices = NoticeDao.INSTANCE.getNoticesByUser(this);
			for (Notice note : this.notices) {
				note.setUser(this);
			}
		}
		return this.notices;
	}
	
	public Company getCompany(){
		if(getCompanyKey() == null){
			return null;
		}else if(this.company == null){
			company = CompanyDao.INSTANCE.getCompanyByKey(getCompanyKey());
		}
		return company;
	}
}