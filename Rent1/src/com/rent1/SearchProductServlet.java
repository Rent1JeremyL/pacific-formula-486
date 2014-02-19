package com.rent1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.impl.Log4JLogger;

@SuppressWarnings("serial")
public class SearchProductServlet extends HttpServlet {
	private static Log4JLogger log = new Log4JLogger(
			SearchProductServlet.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String cata = req.getParameter("rental");
		String geoLoc = req.getParameter("location");
		req.getSession().setAttribute("catagory", cata);
		req.getSession().setAttribute("location", geoLoc);

		String attribs = "catagory=" + cata + "&" + "location=" + geoLoc;
		attribs = attribs.replace(" ", "%");
		log.debug("Got Attributes:: " + attribs);
		resp.sendRedirect("/search.jsp?" + attribs);

	}
}
