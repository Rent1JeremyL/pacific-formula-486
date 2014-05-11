package com.rent1.servlet.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.entity.User;
import com.rent1.shop.ShoppingCartItem;

@SuppressWarnings("serial")
public class RemoveFromCartServlet extends HttpServlet {
	private static final String HTTP_FORWARD = "/view-cart";

	private static final Logger log = Logger
			.getLogger(RemoveFromCartServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User user = User.getUserSession(req);
		int element = Integer.valueOf(req.getParameter("item")).intValue();
		//Index starts at 0
		element--;
		ShoppingCartItem oldItem = user.getShoppingCart().getItems()
				.elementAt(element);

		user.getShoppingCart().removeItem(oldItem);
		resp.sendRedirect(HTTP_FORWARD);
	}
}
