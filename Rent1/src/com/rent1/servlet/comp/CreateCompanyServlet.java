package com.rent1.servlet.comp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.CompanyDao;
import com.rent1.entity.Company;
import com.rent1.entity.User;
import com.rent1.utils.ValidationUtils;

@SuppressWarnings("serial")
public class CreateCompanyServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(CreateCompanyServlet.class);

	private static final String HTTP_MAIN = "/register/company";

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String name = req.getParameter("signup-compName");
		String email = req.getParameter("signup-compEmail");
		String phone = req.getParameter("signup-compPhone");
		User user = User.getUserSession(req);
		Company company = CompanyDao.INSTANCE.getCompanyByNameAndEmail(name,
				email);

		if (!ValidationUtils.isEmailValid(email)) {
			req.setAttribute("errorMessage",
					"Please enter a valid email address.");
			log.debug("Not a valid email address");
			// get back to register.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		} else if (ValidationUtils.isStringBlank(name)) {
			req.setAttribute("errorMessage",
					"Your company name must not be blank.");
			// get back to register.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		} else if (!ValidationUtils.isPhoneNumber(phone)) {
			req.setAttribute("errorMessage",
					"Please enter a valid phone number.");
			// get back to register.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		} else if (company != null) {
			req.setAttribute("errorMessage",
					"A company with this name and email already exists.");
			// get back to register.jsp page using forward
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		}
		
		try {
			Company.registerCompany(name, email, phone, user);
		} catch (Exception e) {
			log.error("Could not register Company for user: " + user.getEmail());
			log.error(e.getMessage());
			req.setAttribute("errorMessage",
					"We could not create your company at this time."
							+ " If this persists please contact support.");
			
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		}

		req.getRequestDispatcher("/company").forward(req, resp);
		return;
	}
}
