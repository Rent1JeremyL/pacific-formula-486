package com.rent1.servlet.order;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Order;
import com.rent1.entity.RentalProduct;
import com.rent1.entity.User;
import com.rent1.reference.Address;

public class ReviewRentalRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String HTTP_ERROR = "/rental/request";
	private static final String HTTP_FORWARD = "/rental/review-order";

	private static final Logger log = Logger
			.getLogger(ReviewRentalRequestServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/**
		 * {rent-strt2=, rent-del-strt1=7548 150A St, rent-del-strt2=,
		 * rent-strt1=7548 150A St, rentend=05/23/2014, rent-dlnum=12345678,
		 * rent-prov=British Columbia, rentstart=05/05/2014,
		 * rent-prd-id=5084141766836224, rent-del-prov=British Columbia,
		 * rent-comp=Eclipse Rentals, rent-fname=Jeremy Leeder, additions=48"
		 * drill bit, rent-city=Surrey, notes=, confirm=confirm,
		 * rent-del-city=Langley}
		 */

		User user = User.getUserSession(req);
		RentalProduct prod = RentalProductDao.INSTANCE.getProductById(Long
				.valueOf(req.getParameter("rent-prd-id")));
		Order order = new Order();
		order.setStatus(Order.STATUS1);
		
		order.setStartDate(req.getParameter("rentstart"));
		order.setEndDate(req.getParameter("rentend"));
		order.setCustomerUserID(user.getId());
		order.setCustomerFullname(req.getParameter("rent-fname"));
		order.setCustomerCompanyName(req.getParameter("rent-comp"));
		order.setProductID(prod.getId());
		order.setAdditions(req.getParameter("additions"));
		order.setNotes(req.getParameter("notes"));
		
		Address custAddr = new Address();
		custAddr.setStreet1(req.getParameter("rent-strt1"));
		custAddr.setStreet2(req.getParameter("rent-strt2"));
		custAddr.setCity(req.getParameter("rent-city"));
		custAddr.setState(req.getParameter("rent-prov"));
		order.setCustomerAddress(custAddr);
		
		Address delAddr = new Address();
		delAddr.setStreet1(req.getParameter("rent-del-strt1"));
		delAddr.setStreet2(req.getParameter("rent-del-strt2"));
		delAddr.setCity(req.getParameter("rent-del-city"));
		delAddr.setState(req.getParameter("rent-del-prov"));
		order.setDeliveryAddress(delAddr);
		
		try {
			order.setDriversLicense(req.getParameter("rent-dlnum"));
		} catch (Exception e) {
			log.error("Error saving driver's license number.");
			req.getRequestDispatcher(HTTP_ERROR).forward(req, resp);
			return;
		}
		
		int rentalDays = 1;
		try {
			SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			Date startDate = df.parse(order.getStartDate());
			Date endDate = df.parse(order.getEndDate());
			rentalDays = (int) ((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24));
		} catch (Exception e) {
			log.error(e.getMessage());
			req.getRequestDispatcher(HTTP_ERROR).forward(req, resp);
			return;
		}
		order.setRentalDays(rentalDays);
		
		req.setAttribute("rentalOrder", order);

		req.getRequestDispatcher(HTTP_FORWARD).forward(req, resp);
		return;
	}
}
