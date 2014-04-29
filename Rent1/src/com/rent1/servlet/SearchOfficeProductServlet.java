package com.rent1.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.DefaultProductDao;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.RentalProduct;
import com.rent1.entity.User;

@SuppressWarnings("serial")
public class SearchOfficeProductServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(SearchOfficeProductServlet.class);

	private static final String HTTP_SRC = "/company/equipment/add";

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String searchString = req.getParameter("search-prod");

		List<DefaultProduct> prods = new ArrayList<DefaultProduct>();
		prods = DefaultProductDao.INSTANCE
				.getProductsBySearchString(searchString);

		// Get around error dynamic proxies can't serialize
		ArrayList<DefaultProduct> rps = new ArrayList<DefaultProduct>();
		for (DefaultProduct rp : prods)
			rps.add(rp);
		
		req.getSession().setAttribute("officeProds", rps);
		req.setAttribute("searchString", searchString);
		
		req.getRequestDispatcher(HTTP_SRC).forward(req, resp);
		return;
	}
}
