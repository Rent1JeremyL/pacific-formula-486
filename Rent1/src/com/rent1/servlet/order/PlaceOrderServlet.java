package com.rent1.servlet.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.NoticeDao;
import com.rent1.dao.OrderDao;
import com.rent1.dao.RentalRequestDao;
import com.rent1.entity.Notice;
import com.rent1.entity.Order;
import com.rent1.entity.RentalRequest;
import com.rent1.entity.User;
import com.rent1.shop.ShoppingCartItem;

@SuppressWarnings("serial")
public class PlaceOrderServlet extends HttpServlet {
	private static final String HTTP_FORWARD = "/rental/order-placed";
	private static final String HTTP_ERROR = "/404error.html";
	
	private static final Logger log = Logger.getLogger(PlaceOrderServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		User user = User.getUserSession(req);
		RentalRequest rentalRequest = user.getRentalRequest();
		RentalRequestDao.INSTANCE.addRentalRequest(rentalRequest);

		for (ShoppingCartItem item : rentalRequest.getItems()) {
			try {
				Order order = new Order(rentalRequest, item);
				OrderDao.INSTANCE.addOrder(order);
			} catch (Exception e) {
				log.error("Could not create order item(s).");
				e.printStackTrace();
				// go back try again
				req.getRequestDispatcher(HTTP_ERROR).forward(req, resp);
				return;
			}
		}
		Notice note = Notice.newOrderNotice(rentalRequest.getId(), user);
		NoticeDao.INSTANCE.addNotice(note);
		user.getNotices(true);
		user.clearShoppingCart();
		//TODO Email Alerts to company
		
		resp.sendRedirect(HTTP_FORWARD);
		return;
	}
}
