package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.impl.Log4JLogger;

import com.rent1.dao.UserDao;
import com.rent1.entity.User;
import com.rent1.utils.ValidationUtils;

@SuppressWarnings("serial")
public class CreateAccountServlet extends HttpServlet {
	private static final Log4JLogger log = new Log4JLogger(
			CreateAccountServlet.class.getName());

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String email = req.getParameter("signup-email");
		String password = req.getParameter("signup-password1");
		String confirmPass = req.getParameter("signup-password2");
		User newUser = UserDao.INSTANCE.getUserByEmail(email);

		if (!ValidationUtils.isEmailValid(email)) {
			req.setAttribute("errorMessage",
					"Please enter a valid email address.");
			log.debug("Not a valid email address");
			// get back to register.jsp page using forward
			req.getRequestDispatcher("/register").forward(req, resp);
			return;
		} else if (ValidationUtils.isStringBlank(password)) {
			req.setAttribute("errorMessage", "Your password must not be blank.");
			// get back to register.jsp page using forward
			req.getRequestDispatcher("/register").forward(req, resp);
			return;
		} else if (!ValidationUtils.isStringMatching(password, confirmPass)) {
			req.setAttribute("errorMessage",
					"Your password and confirmation password do not match.");
			// get back to register.jsp page using forward
			req.getRequestDispatcher("/register").forward(req, resp);
			return;
		} else if (newUser != null) {
			req.setAttribute("errorMessage",
					"This email is already registered.  Please go back and use the Sign In button.");
			// get back to register.jsp page using forward
			req.getRequestDispatcher("/register").forward(req, resp);
			return;
		}

		try {
			newUser = User.registerNewUser(email, password);
		} catch (Exception e) {
			log.error("Could not register new user: " + email);
			log.error(e.getMessage());
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}

		req.getSession().setAttribute("user", newUser);
		req.getRequestDispatcher("/profile").forward(req, resp);
		return;
	}
}
