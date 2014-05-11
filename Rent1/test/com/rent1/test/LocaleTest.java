package com.rent1.test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Currency;
import java.util.List;
import java.util.Locale;

import lombok.Getter;
import lombok.Setter;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;

public class LocaleTest {
	private static final Logger log = Logger.getLogger(LocaleTest.class);
	private final LocalServiceTestHelper helper = new LocalServiceTestHelper(
			new LocalDatastoreServiceTestConfig().setApplyAllHighRepJobPolicy());

	@Before
	public void setUp() throws InterruptedException {
		helper.setUp();
	}

	@After
	public void tearDown() {
		helper.tearDown();
	}

	@Test
	public void listCountries() {
		String[] countryCodes = Locale.getISOCountries();
		List<Country> list = new ArrayList<Country>(countryCodes.length);

		for (String cc : countryCodes) {
			list.add(new Country(cc.toUpperCase(), new Locale("", cc)
					.getDisplayCountry()));
		}

		Collections.sort(list);

		for (Country c : list) {
			log.info("/** " + c.getName() + " **/");
			log.info("   " + c.getCode() + "(\"" + c.getName() + "\"),");
			Locale lc = new Locale("", c.getCode());
			try {
				String code = Currency.getInstance(lc).getCurrencyCode();
				log.info("   Code: " + code);
			} catch (NullPointerException e) {
				log.info("   Code: null");
			}
			try {
				String symb = Currency.getInstance(lc).getSymbol();
				log.info("   Symbol: " + symb);
			} catch (NullPointerException e) {
				log.info("   Symbol: null");
			}
		}
	}

	class Country implements Comparable<Country> {
		@Getter @Setter private String code;
		@Getter @Setter private String name;

		public Country(String code, String name) {
			super();
			this.code = code;
			this.name = name;
		}

		@Override
		public int compareTo(Country o) {
			return this.name.compareTo(o.name);
		}
	}
}
