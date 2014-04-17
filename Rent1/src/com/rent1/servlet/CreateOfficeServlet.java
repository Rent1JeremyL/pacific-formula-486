package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.entity.Company;
import com.rent1.entity.Office;
import com.rent1.entity.User;

@SuppressWarnings("serial")
public class CreateOfficeServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(CreateOfficeServlet.class);

	private static final String HTTP_MAIN = "/company/add/office";

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String street1 = req.getParameter("add-street1");
		String street2 = req.getParameter("add-street2");
		String city = req.getParameter("add-city");
		String postCode = req.getParameter("add-zip");
		String country = req.getParameter("country");
		String state = req.getParameter("state");
		String phone = req.getParameter("add-phone");
		String fax = req.getParameter("add-fax");

		User user = User.getUserSession(req);
		Company comp = user.getCompany();

		try {
			Office.createOffice(comp, street1, street2, city, postCode, state,
					country, phone, fax);
		} catch (Exception e) {
			log.error("Could not add office for Company: [" + comp.getId()
					+ "] " + comp.getName());
			log.error(e.getMessage());
			req.setAttribute("errorMessage",
					"We could not create the office at this time."
							+ " If this persists please contact support.");

			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		}

		req.getRequestDispatcher("/company").forward(req, resp);
		return;
	}
}
