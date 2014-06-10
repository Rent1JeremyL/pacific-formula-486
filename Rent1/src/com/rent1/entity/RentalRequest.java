package com.rent1.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;
import com.rent1.reference.Address;
import com.rent1.shop.ShoppingCartItem;
import com.rent1.utils.EncryptUtils;

@Entity
@NoArgsConstructor
public class RentalRequest implements Serializable {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(RentalRequest.class);

	@Id @Getter @Setter private Long id;
	@Getter @Setter private Long customerUserID;
	@Getter @Setter private String customerFullname;
	@Ignore @Getter @Setter private String customerDriversLicense;
	@Getter @Setter private String customerCompanyName = "";
	@Getter @Setter private Address customerAddress;
	@Getter @Setter private Address deliveryAddress;
	@Getter @Setter private String notes = "N/A";
	@Ignore @Getter @Setter private List<ShoppingCartItem> items;
	@Getter @Setter private double subTotalEstimate;
	
	@Getter private byte[] driversLicense;
	@Getter @Setter private byte[] salt;
	
	@Getter private Date createDate = new Date();
	@Getter @Setter private Date lastUpdated;

	public RentalRequest(User user) {
		this.customerUserID = user.getId();
		this.items = user.getShoppingCart().getItems();
		for(ShoppingCartItem item : this.items){
			this.subTotalEstimate = this.subTotalEstimate + item.getRentalEstimate();
		}
	}
	
	public void setDriversLicense(String license) throws Exception {
		this.salt = EncryptUtils.generateSalt();
		this.driversLicense = EncryptUtils.getEncryptedPassword(
				license, salt);
	}
}
