package com.rent1.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.rent1.reference.Address;
import com.rent1.utils.EncryptUtils;

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

	@Getter private byte[] customerDriversLicense;
	@Getter @Setter private byte[] salt;
	
	@Getter @Setter private String startDate;
	@Getter @Setter private String endDate;
	@Getter @Setter private int rentalDays;
	@Getter @Setter private Long customerUserID;
	@Getter @Setter private Long productID;
	@Getter @Setter private String customerFullname;
	@Getter @Setter private String customerCompanyName = "";
	@Getter @Setter private Address customerAddress;
	@Getter @Setter private Address deliveryAddress;
	@Getter @Setter private String status;
	@Getter @Setter private String additions;
	@Getter @Setter private String notes;
	@Getter @Setter private Long companyID;
	@Getter @Setter private Long officeID;
	
	@Getter @Setter private String created;
	@Getter @Setter private String lastUpdated;
	
	@Getter @Setter private double quote;
	@Getter @Setter private double tax;
	@Getter @Setter private double total;
	@Getter @Setter private double subtotal;
	@Getter @Setter private double deliveryCharge;
	
	@Getter @Setter private boolean rent1Billed;
	@Getter @Setter private boolean rent1Collected;

	public void setDriversLicense(String license) throws Exception {
		this.salt = EncryptUtils.generateSalt();
		this.customerDriversLicense = EncryptUtils.getEncryptedPassword(
				license, salt);
	}
}
