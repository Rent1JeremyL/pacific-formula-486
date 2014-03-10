package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.impl.Log4JLogger;

import com.rent1.dao.UserDao;
import com.rent1.entity.User;

@SuppressWarnings("serial")
public class SaveProfileServlet extends HttpServlet {
	@SuppressWarnings("unused")
	private static final Log4JLogger log = new Log4JLogger(
			SaveProfileServlet.class.getName());

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String nickName = req.getParameter("prof-nickname");
		String firstName = req.getParameter("prof-first");
		String lastName = req.getParameter("prof-last");

		User user = (User) req.getSession().getAttribute("user");
		user.setNickName(nickName);
		user.setFirstName(firstName);
		user.setLastName(lastName);

		user = UserDao.INSTANCE.updateUser(user);
		req.getSession().setAttribute("user", user);

		resp.sendRedirect("/profile");
		return;
	}
}