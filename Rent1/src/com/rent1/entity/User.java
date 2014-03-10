package com.rent1.entity;

import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.commons.logging.impl.Log4JLogger;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.rent1.dao.UserDao;
import com.rent1.utils.EncryptUtils;

@Entity
@NoArgsConstructor
public class User implements Serializable {
	private static final long serialVersionUID = 4569996182825475350L;
	private static final Log4JLogger log = new Log4JLogger(User.class.getName());

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
}