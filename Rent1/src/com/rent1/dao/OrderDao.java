package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.Date;

import com.rent1.entity.Order;

public enum OrderDao {
	INSTANCE;

	public Order addOrder(Order order) {
		order.setLastUpdated(new Date());
		ofy().save().entity(order).now();
		return order;
	}

	public Order getOrderById(Long orderId) {
		Order order = ofy().load().type(Order.class).filter("id", orderId)
				.first().now();

		return order;
	}
}
