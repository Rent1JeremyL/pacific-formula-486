package com.rent1.servlet.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.entity.RentalRequest;
import com.rent1.entity.User;
import com.rent1.reference.Address;

@SuppressWarnings("serial")
public class ReviewRentalRequestServlet extends HttpServlet {
	private static final String HTTP_FORWARD = "/rental/review-order";

	private static final Logger log = Logger
			.getLogger(ReviewRentalRequestServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/**
		 * {rent-strt2=, rent-del-strt1=7548 150A St, rent-strt1=7548 150A St,
		 * rent-del-strt2=, rent-dlnum=6536892, rent-prov=British Columbia,
		 * rent-del-prov=British Columbia, rent-del-country=Canada,
		 * rent-country=Canada, rent-comp=Eclipse Rentals2, rent-fname=Jeremy
		 * Leeder, additions=, rent-city=Surrey, notes=test, confirm=confirm,
		 * rent-del-city=Surrey rent-zip=V3S 6Y9}
		 */

		User user = User.getUserSession(req);

		RentalRequest rentalRequest = new RentalRequest(user);

		rentalRequest.setCustomerFullname(req.getParameter("rent-fname"));
		rentalRequest.setCustomerCompanyName(req.getParameter("rent-comp"));
		try {
			rentalRequest.setDriversLicense(req.getParameter("rent-dlnum"));
		} catch (Exception e) {
			log.error("Unable to encrypt driver's license while creating Order ojbect.");
			log.error(e.getMessage());
		}
		rentalRequest.setNotes(req.getParameter("notes"));

		Address custAddr = new Address();
		custAddr.setStreet1(req.getParameter("rent-strt1"));
		custAddr.setStreet2(req.getParameter("rent-strt2"));
		custAddr.setCity(req.getParameter("rent-city"));
		custAddr.setState(req.getParameter("rent-prov"));
		custAddr.setCountry(req.getParameter("rent-country"));
		custAddr.setPostCode(req.getParameter("rent-zip"));
		rentalRequest.setCustomerAddress(custAddr);

		Address delAddr = new Address();
		delAddr.setStreet1(req.getParameter("rent-del-strt1"));
		delAddr.setStreet2(req.getParameter("rent-del-strt2"));
		delAddr.setCity(req.getParameter("rent-del-city"));
		delAddr.setState(req.getParameter("rent-del-prov"));
		delAddr.setCountry(req.getParameter("rent-del-country"));
		rentalRequest.setDeliveryAddress(delAddr);

		user.setRentalRequest(rentalRequest);

		req.getRequestDispatcher(HTTP_FORWARD).forward(req, resp);
		return;
	}
}
