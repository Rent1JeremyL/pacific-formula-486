package com.rent1.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.rent1.reference.Currency;

@Entity
@Cache
@NoArgsConstructor
public class PricePlan implements Serializable {
	private static final long serialVersionUID = 1L;

	public static final String HOUR = "Hourly";
	public static final String DAY = "Daily";
	public static final String WEEK = "Weekly";
	public static final String MONTH = "Monthly";

	@Id @Getter @Setter private Long id;
	@Getter @Setter private int rateHourly = 0;
	@Getter @Setter private int rateDaily;
	@Getter @Setter private int rateWeekly;
	@Getter @Setter private int rateMonthly;
	@Getter @Setter private String regionTag;
	@Getter @Setter private String languageTag;

	public PricePlan(String country_code, String languageTag) {
		this.regionTag = country_code;
		this.languageTag = languageTag;
	}

	public PricePlan(String country_code) {
		this(country_code, "en");
	}

	public String getCurrencySymbol() {
		return Currency.getCurrencySymbol(this.regionTag);
	}

	public String getCurrencyCode() {
		return Currency.getCurrencyCode(this.regionTag);
	}

	/**
	 * Get the default rate length and price to display.
	 * 
	 * @param days
	 * @return a String array that holds the default type and rate
	 *         <p>
	 *         Example [0] Per Day, [1] 280
	 */
	public String[] getDefaultRateValues(int days) {
		if (days == 0) {
			String[] result = { "Per Hour", String.valueOf(getRateHourly()) };
			return result;
		} else if (days >= 1 && days <= 6) {
			String[] result = { "Per Day", String.valueOf(getRateDaily()) };
			return result;
		} else if (days >= 7 && days <= 28) {
			String[] result = { "Per Week", String.valueOf(getRateWeekly()) };
			return result;
		} else if (days >= 29) {
			String[] result = { "Per Month", String.valueOf(getRateMonthly()) };
			return result;
		}
		return null;
	}
}
