package com.rent1.servlet.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.UserDao;
import com.rent1.entity.User;
import com.rent1.utils.ValidationUtils;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {
	private static final String HTTP_MAIN = "/login";
	
	private static final Logger log = Logger.getLogger(LoginServlet.class
			.getName());

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String email = req.getParameter("signup-email");
		String password = req.getParameter("signup-password1");
		User newUser = UserDao.INSTANCE.getUserByEmail(email);

		if (!ValidationUtils.isEmailValid(email)) {
			req.setAttribute("errorMessage",
					"Please enter a valid email address.");
			log.debug("Not a valid email address");
			// get back to login.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		} else if (ValidationUtils.isStringBlank(password)) {
			req.setAttribute("errorMessage", "Your password is invalid.");
			// get back to login.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		} else if (newUser == null) {
			req.setAttribute("errorMessage",
					"This email address is not registered.");
			// get back to login.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		} else if (newUser.authenticatePassword(password)) {
			// Login success
			req.getSession().setAttribute("user", newUser);
			resp.sendRedirect("/");
			return;
		} else {
			req.setAttribute("errorMessage", "Your password is invalid.");
			// get back to login.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		}
	}
}
