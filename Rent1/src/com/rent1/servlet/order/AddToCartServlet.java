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
import com.rent1.shop.ShoppingCartItem;

public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String HTTP_ERROR = "/rental/requirements";
	private static final String HTTP_FORWARD = "/view-cart";

	private static final Logger log = Logger
			.getLogger(AddToCartServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User user = User.getUserSession(req);
		String prodId = req.getParameter("prodId");
		String start = (String) req.getSession().getAttribute("searchStart");
		String end = (String) req.getSession().getAttribute("searchEnd");
		// TODO add back
		// if (user == null || !user.isVerified() || !user.isAddressComplete())
		if (user == null || !user.isAddressComplete()) {
			resp.sendRedirect(HTTP_ERROR);
		} else {
			RentalProduct rp = RentalProductDao.INSTANCE.getProductById(Long
					.valueOf(prodId));
			ShoppingCartItem newItem = new ShoppingCartItem(rp, start, end);
			user.getShoppingCart().addItem(newItem);
			resp.sendRedirect(HTTP_FORWARD);
		}
	}
}
