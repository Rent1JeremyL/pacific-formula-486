package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.entity.User;

@SuppressWarnings("serial")
public class PreCompanyRegServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(PreCompanyRegServlet.class);

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User user = User.getUserSession(req);
		
		if (user == null) {
			req.setAttribute("errorMessage",
					"Please login before trying to create a company.");
			log.debug("Not logged in during Company Registration.");
		}
		req.getRequestDispatcher("/register/company").forward(req, resp);
		return;
	}
}
