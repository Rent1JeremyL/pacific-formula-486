package com.rent1.entity;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;
import com.rent1.dao.RentalProductDao;
import com.rent1.shop.ShoppingCartItem;

@Entity
@NoArgsConstructor
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(Order.class);

	public static final String STATUS1 = "initial";
	public static final String STATUS2 = "reviewed";
	public static final String STATUS3 = "pending";
	public static final String STATUS4 = "accepted";
	public static final String STATUS5 = "delivered";
	public static final String STATUS6 = "returned";
	public static final String STATUS7 = "completed";
	public static final String STATUS8 = "cancelled";

	@Id @Getter @Setter private Long id;
	@Index @Getter @Setter private Long rentalRequestID;
	@Index @Getter @Setter private Long customerID;
	@Load private Ref<RentalRequest> rentalRequest;

	@Getter @Setter private String startDate;
	@Getter @Setter private String endDate;
	@Getter @Setter private int rentalDays;
	@Index @Getter @Setter private Long productID;
	@Index @Getter @Setter private String status;
	@Index @Getter @Setter private Key<Company> companyKey;
	@Index @Getter @Setter private Key<Office> officeKey;

	@Getter private Date created = new Date();
	@Index @Getter @Setter Date lastUpdated;

	@Getter @Setter private double quote;
	@Getter @Setter private double tax;
	@Getter @Setter private double subTotal;
	@Getter @Setter private double total;
	@Getter @Setter private double deliveryCharge;

	@Index @Getter @Setter private boolean rent1Billed = false;
	@Index @Getter @Setter private boolean rent1Collected = false;

	public RentalRequest getRentalRequest() {
		return rentalRequest.get();
	}

	public void setRentalRequest(RentalRequest request) {
		this.rentalRequest = Ref.create(request);
	}

	public Order(RentalRequest request, ShoppingCartItem item) {
		this.rentalRequestID = request.getId();
		this.setRentalRequest(request);

		this.status = STATUS1;
		RentalProduct prod = RentalProductDao.INSTANCE.getProductById(
				item.getProductID());
		
		this.startDate = item.getStartDate();
		this.endDate = item.getEndDate();
		this.rentalDays = item.getRentalDays();
		this.productID = item.getProductID();
		this.customerID = request.getCustomerUserID();
		this.companyKey = prod.getCompany();
		this.quote = item.getRentalEstimate();
	}
}
