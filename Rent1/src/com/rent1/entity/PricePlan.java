package com.rent1.entity;

import java.io.Serializable;
import java.util.Currency;
import java.util.Locale;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
@Cache
@NoArgsConstructor
public class PricePlan implements Serializable{
	private static final long serialVersionUID = 1L;
	
	public static final String HOUR = "Hourly";
	public static final String DAY = "Daily";
	public static final String WEEK = "Weekly";
	public static final String MONTH = "Monthly";

	@Id
	@Getter
	@Setter
	private Long id;

	@Getter
	@Setter
	private int rateHourly = 0;
	@Getter
	@Setter
	private int rateDaily;
	@Getter
	@Setter
	private int rateWeekly;
	@Getter
	@Setter
	private int rateMonthly;
	@Getter
	@Setter
	private String regionTag;

	public PricePlan(Locale region) {
		this.regionTag = region.toLanguageTag();
	}

	public String getCurrencySymbol() {
		return Currency.getInstance(Locale.forLanguageTag(regionTag))
				.getSymbol();
	}

	public String getCurrencyCode() {
		return Currency.getInstance(Locale.forLanguageTag(regionTag))
				.getCurrencyCode();
	}

	/**
	 * Get the default rate length and price to display.
	 * 
	 * @param days
	 * @return a String array that holds the default type and rate
	 * <p> Example [0] Per Day, [1] 280
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
