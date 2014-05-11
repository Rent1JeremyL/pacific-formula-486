package com.rent1.reference;

import java.util.Locale;
/**
 * An override for java.util.Currency, because the GAE was not 
 * showing symbols.
 * 
 * @author Jeremy Leeder
 * @see http://www.exchangerates.org.uk/currency-symbols.html
 */
public class Currency {
	private static final String DEFAULT = "$";
	private static final String EURO = "€";
	private static final String JPY_YEN = "¥";
	private static final String CNY_YUAN = "元";
	private static final String KOREA = "₩";
	private static final String EGYPT = "£";

	public static String getCurrencySymbol(String countryCode) {
		String code = getCurrencyCode(countryCode);

		switch (code) {
		case "CAD": // Canada
			return DEFAULT;
		case "CNY": // China
			return CNY_YUAN;
		case "EGP": // Egypt
			return EGYPT;
		case "EUR":// European Union
			return EURO;
		case "JPY":// Japan
			return JPY_YEN;
		case "KPW":// N. Korea
			return KOREA;
		case "KRW":// S. Korea
			return KOREA;
		case "USD":// USA
			return DEFAULT;

		default:
			return DEFAULT;
		}
	}

	public static String getCurrencyCode(String countryCode) {
		Locale locale = new Locale("", countryCode);
		return java.util.Currency.getInstance(locale).getCurrencyCode();
	}
}
