package com.rent1.servlet.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.RentalProductDao;
import com.rent1.entity.RentalProduct;
import com.rent1.entity.User;

public class StartRentalRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String HTTP_ERROR = "/rental/requirements";
	private static final String HTTP_FORWARD = "/rental/request";

	private static final Logger log = Logger
			.getLogger(StartRentalRequestServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User user = User.getUserSession(req);
		String prodId = req.getParameter("prodId");
		// String start = (String) req.getSession().getAttribute("searchStart");
		// String end = (String) req.getSession().getAttribute("searchEnd");
		// TODO add back
		// if (user == null || !user.isVerified() || !user.isAddressComplete())
		if (user == null || !user.isAddressComplete()) {
			resp.sendRedirect(HTTP_ERROR);
		} else {
			RentalProduct rp = RentalProductDao.INSTANCE.getProductById(Long
					.valueOf(prodId));
			req.setAttribute("rentalProd", rp);
			req.getRequestDispatcher(HTTP_FORWARD).forward(req, resp);
		}
	}
}
