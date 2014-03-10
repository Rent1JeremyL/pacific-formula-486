package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.impl.Log4JLogger;

@SuppressWarnings("serial")
public class SearchProductServlet extends HttpServlet {
	private static final Log4JLogger log = new Log4JLogger(
			SearchProductServlet.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String cata = req.getParameter("rental");
		String geoLoc = req.getParameter("location");
		req.getSession().setAttribute("srchCata", cata);
		req.getSession().setAttribute("srchLoc", geoLoc);

		String attribs = "cataeory=" + cata + "&" + "location=" + geoLoc;
		attribs = attribs.replace(" ", "%");
		log.debug("Got Attributes:: " + attribs);
		// resp.sendRedirect("/search.jsp?" + attribs);
		req.getRequestDispatcher("/WEB-INF/jsp/search.jsp").forward(req, resp);
		return;
	}
}
