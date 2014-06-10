package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.Date;

import com.rent1.entity.RentalRequest;

public enum RentalRequestDao {
	INSTANCE;

	public RentalRequest addRentalRequest(RentalRequest request) {
		request.setLastUpdated(new Date());
		ofy().save().entity(request).now();
		return request;
	}
	
	public RentalRequest getRentalRequestById(Long requestId) {
		RentalRequest req = ofy().load().type(RentalRequest.class).filter("id", requestId)
				.first().now();

		return req;
	}
}
