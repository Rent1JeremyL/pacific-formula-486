package com.rent1.servlet.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.UserDao;
import com.rent1.entity.User;

@SuppressWarnings("serial")
public class SaveProfileServlet extends HttpServlet {
	@SuppressWarnings("unused") private static final Logger log = Logger
			.getLogger(SaveProfileServlet.class.getName());

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String nickName = req.getParameter("prof-nickname");
		String firstName = req.getParameter("prof-first");
		String lastName = req.getParameter("prof-last");
		String phone = req.getParameter("prof-tel");

		String street = req.getParameter("street-full");
		String country = req.getParameter("country");
		String state = req.getParameter("administrative_area_level_1");
		String postCode = req.getParameter("postal_code");
		String city = req.getParameter("locality");

		User user = User.getUserSession(req);
		user.setNickName(nickName);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setPhone(phone);
		if (street != null)
			user.getAddress().setStreet1(street);
		if (country != null)
			user.getAddress().setCountry(country);
		if (state != null)
			user.getAddress().setState(state);
		if (postCode != null)
			user.getAddress().setPostCode(postCode);
		if (city != null)
			user.getAddress().setCity(city);

		user = UserDao.INSTANCE.updateUser(user);

		req.getSession().setAttribute("user", user);

		resp.sendRedirect("/profile");
		return;
	}
}
