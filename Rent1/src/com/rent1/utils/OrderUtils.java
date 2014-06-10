package com.rent1.utils;

import com.rent1.entity.RentalProduct;

public class OrderUtils {

	/**
	 * Create an estimate quote based on the product and days rented. <br>
	 * Break down to month = 30 days <br>
	 * Break down to week = 7 days
	 * 
	 * @param prod
	 * @param days
	 * @return
	 */
	public static double calculateRentalEstimate(RentalProduct prod, int days) {
		int daysInMonth = 30;
		int daysInWeek = 7;
		double total = 0.00;
		int daysLeft = days;

		int months = daysLeft / daysInMonth;
		if (months > 0) {
			total = months * prod.getPricePlan().getRateMonthly();
			daysLeft = daysLeft - (months * daysInMonth);
		}

		int weeks = daysLeft / daysInWeek;
		if (weeks > 0) {
			total = total + (weeks * prod.getPricePlan().getRateWeekly());
			daysLeft = daysLeft - (weeks * daysInWeek);
		}

		if (daysLeft > 0) {
			total = total + (daysLeft * prod.getPricePlan().getRateDaily());
		}

		return total;
	}

}
