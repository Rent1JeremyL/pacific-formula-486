package com.rent1.servlet;

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
	@SuppressWarnings("unused")
	private static final Logger log = Logger.getLogger(SaveProfileServlet.class
			.getName());

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String nickName = req.getParameter("prof-nickname");
		String firstName = req.getParameter("prof-first");
		String lastName = req.getParameter("prof-last");

		User user = User.getUserSession(req);
		user.setNickName(nickName);
		user.setFirstName(firstName);
		user.setLastName(lastName);

		user = UserDao.INSTANCE.updateUser(user);
		//TODO Sent a serialization bug do to ignore fields
		//req.getSession().setAttribute("user", user);

		resp.sendRedirect("/profile");
		return;
	}
}
