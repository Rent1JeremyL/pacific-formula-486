package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

@SuppressWarnings("serial")
public class SearchProductServlet extends HttpServlet {
	private static final String HTTP_MAIN = "/WEB-INF/jsp/search.jsp";
	private static final Logger log = Logger.getLogger(
			SearchProductServlet.class);

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
		req.getRequestDispatcher(HTTP_MAIN).forward(req, resp);
		return;
	}
}
