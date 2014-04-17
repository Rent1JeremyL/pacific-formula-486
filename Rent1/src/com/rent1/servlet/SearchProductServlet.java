package com.rent1.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.PlaceDao;
import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Place;
import com.rent1.entity.RentalProduct;

public class SearchProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String HTTP_MAIN = "/";
	private static final Logger log = Logger
			.getLogger(SearchProductServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String searchString = req.getParameter("rental");
		String geoLoc = req.getParameter("location");
		String start = req.getParameter("rentstart");
		String end = req.getParameter("rentend");

		String[] places = geoLoc.split(",");
		Place place = PlaceDao.INSTANCE.getPlaceByRegoin(places[0].trim(),
				places[1].trim(), places[2].trim());

		int diffInDays = 1;
		try {
			SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			Date startDate = df.parse(start);
			Date endDate = df.parse(end);
			diffInDays = (int) ((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24));
		} catch (Exception e) {
			log.error("Unable to parse Start Date or End Date");
			log.error(e.getMessage());
		}

		List<RentalProduct> prods = new ArrayList<RentalProduct>();
		prods = RentalProductDao.INSTANCE.getProductsBySearchStringAndGeoCells(
				searchString, place, 25);

		// Get around error dynamic proxies can't serialize
		ArrayList<RentalProduct> rps = new ArrayList<RentalProduct>();
		for (RentalProduct rp : prods)
			rps.add(rp);

		req.getSession().setAttribute("products", rps);

		req.getSession().setAttribute("searchString", searchString);
		req.getSession().setAttribute("searchLoc", geoLoc);
		req.getSession().setAttribute("searchStart", start);
		req.getSession().setAttribute("searchEnd", end);
		req.getSession().setAttribute("rentalDays", diffInDays);

		req.getRequestDispatcher("/results").forward(req, resp);
		return;
	}
}
