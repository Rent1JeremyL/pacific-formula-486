package com.rent1.entity;

import java.util.Currency;
import java.util.Locale;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity@Cache
@NoArgsConstructor
public class PricePlan {
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
	private int rateHourly;
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
	private int rateDefault;
	@Getter
	@Setter
	private String region;
	@Getter
	@Setter
	private String defaultType;

	public PricePlan(Locale region) {
		this.region = region.toLanguageTag();
	}

	public String getCurrencySymbol() {		
		return Currency.getInstance(Locale.forLanguageTag(region)).getSymbol();
	}

	public String getCurrencyCode() {
		return Currency.getInstance(Locale.forLanguageTag(region)).getCurrencyCode();
	}
}
