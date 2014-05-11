package com.rent1.shop;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.rent1.entity.RentalProduct;

@NoArgsConstructor
public class ShoppingCartItem implements Serializable {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(ShoppingCartItem.class);

	@Getter @Setter private Long productID;
	@Getter @Setter private String name;
	@Getter @Setter private String startDate;
	@Getter @Setter private String endDate;
	@Getter @Setter private int rentalDays;
	@Getter @Setter private String rate;
	@Getter @Setter private String url;
	@Getter @Setter private String thumbImg;

	public ShoppingCartItem(RentalProduct prod, String start, String end) {
		this.productID = prod.getId();
		this.name = prod.getWebTitle();
		this.startDate = start;
		this.endDate = end;
		this.rentalDays = 1;
		try {
			SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			Date startDate = df.parse(start);
			Date endDate = df.parse(end);
			this.rentalDays = (int) ((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24));
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		String[] rateArray = prod.getPricePlan().getDefaultRateValues(
				this.rentalDays);
		this.rate = prod.getPricePlan().getCurrencySymbol() + rateArray[1]
				+ " " + prod.getPricePlan().getCurrencyCode() + " "
				+ rateArray[0];
		this.url = prod.getCompanyHref();
		this.thumbImg = prod.getThumbImg();
	}

	@Override
	public String toString() {
		return this.name;
	}
}
