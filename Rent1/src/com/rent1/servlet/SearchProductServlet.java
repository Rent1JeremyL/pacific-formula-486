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
	private static final String HTTP_MAIN = "/results";
	private static final Logger log = Logger
			.getLogger(SearchProductServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int page = 1;
		String searchString = "";
		String geoLoc = "";
		String start = "";
		String end = "";
		String dist = null;

		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
			// Set for Form
			searchString = (String) req.getSession().getAttribute(
					"searchString");
			geoLoc = (String) req.getSession().getAttribute("searchLoc");
			start = (String) req.getSession().getAttribute("searchStart");
			end = (String) req.getSession().getAttribute("searchEnd");
			dist = (String) req.getSession().getAttribute("searchDist");
		} else {
			searchString = req.getParameter("rental");
			geoLoc = req.getParameter("location");
			start = req.getParameter("rentstart");
			end = req.getParameter("rentend");
			dist = req.getParameter("rentdistance");
		}
		int offset = (page - 1) * RentalProductDao.RECORDS_PER_PAGE;
		double radius = 0;
		if (dist == null) {
			dist = "25";
			radius = Double.valueOf(dist).doubleValue();
			req.getSession().setAttribute("searchDist", dist);
		} else if (dist.toLowerCase().equals("unlimited")) {
			dist = "unlimited";
			req.getSession().setAttribute("searchDist", "unlimited");
		} else {
			radius = Double.valueOf(dist).doubleValue();
			req.getSession().setAttribute("searchDist", dist);
		}

		String[] places = geoLoc.split(",");
		// [Fix bug] Berlin City/State show as one in google
		Place place = null;
		if (places.length == 3) {
			place = PlaceDao.INSTANCE.getPlaceByRegion(places[0].trim(),
					places[1].trim(), places[2].trim());
		} else if (places.length == 2) {
			// For a City State like Berlin
			place = PlaceDao.INSTANCE.getPlaceByRegion(places[0].trim(),
					places[0].trim(), places[1].trim());
		}

		int diffInDays = 1;
		try {
			SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			Date startDate = df.parse(start);
			Date endDate = df.parse(end);
			diffInDays = (int) ((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24));
		} catch (Exception e) {
			log.error("Unable to parse Start Date or End Date");
			log.error(e.getMessage());
			req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
			return;
		}
		if (diffInDays < 0) {
			req.setAttribute("errorMessage",
					"Your Start Date must be before your End Date.");
			req.getRequestDispatcher("/").forward(req, resp);
			return;
		}

		List<RentalProduct> prods = null;
		if (radius != 0) {
			prods = RentalProductDao.INSTANCE
					.getProductsBySearchStringAndGeoCells(searchString, place,
							radius, offset);
		} else {
			prods = RentalProductDao.INSTANCE.getProductsBySearchString(
					searchString, offset);
		}

		int noOfRecords = RentalProductDao.INSTANCE.getNoOfRecords();
		int noOfPages = (int) Math.ceil(noOfRecords * 1.0
				/ RentalProductDao.RECORDS_PER_PAGE);

		// Get around error dynamic proxies can't serialize
		ArrayList<RentalProduct> rps = new ArrayList<RentalProduct>();
		for (RentalProduct rp : prods) {
			if (rp != null)
				rps.add(rp);
		}
		// Set for results
		req.setAttribute("products", rps);
		req.setAttribute("noOfRecords", noOfRecords);
		req.setAttribute("noOfPages", noOfPages);
		req.setAttribute("currentPage", page);
		req.setAttribute("rentalDays", diffInDays);

		// Set for Form
		req.getSession().setAttribute("searchString", searchString);
		req.getSession().setAttribute("searchLoc", geoLoc);
		req.getSession().setAttribute("searchStart", start);
		req.getSession().setAttribute("searchEnd", end);

		req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
		return;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
}
