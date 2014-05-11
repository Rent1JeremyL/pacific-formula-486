package com.rent1.factory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import com.rent1.reference.Category;

import lombok.Getter;

public class CategoryFactory {
	private static CategoryFactory ecInstance = null;

	private Map<Category, ArrayList<Category>> categoryMap = null;
	@Getter private ArrayList<Category> primaryCatagories;

	private CategoryFactory() {
		categoryMap = new HashMap<Category, ArrayList<Category>>();

		primaryCatagories = new ArrayList<Category>();
		for (Category cata : Category.PRIMARY_CATAGORIES) {
			primaryCatagories.add(cata);
			ArrayList<Category> secondary = null;
			switch (cata.toString()) {
			case Category.PC_AERIAL_LIFT:
				secondary = new ArrayList<Category>(
						Arrays.asList(Category.SC_AERIAL));
				break;
			case Category.PC_COMPACTION:
				secondary = new ArrayList<Category>(
						Arrays.asList(Category.SC_COMPACTION));
				break;
			case Category.PC_CONCRETE:
				secondary = new ArrayList<Category>(
						Arrays.asList(Category.SC_CONCRETE));
				break;
			case Category.PC_CONSTRUCTION:
				secondary = new ArrayList<Category>(
						Arrays.asList(Category.SC_CONSTRUCTION));
				break;
			case Category.PC_EARTHMOVING:
				secondary = new ArrayList<Category>(
						Arrays.asList(Category.SC_EARTHMOVING));
				break;
			}
			Collections.sort(secondary);
			categoryMap.put(cata, secondary);
		}
		Collections.sort(primaryCatagories);

	}

	public ArrayList<Category> getSecondayCatagories(Category primary) {
		ArrayList<Category> seconday = categoryMap.get(primary);
		return seconday;
	}

	/**
	 * Print a pipe delimited string for a JS array
	 * 
	 * @param primary
	 * @return ex. "Skid Steer","Excavator"
	 */
	public String getAllSecondayCatagoriesToJSArray() {
		String jScript = "";
		for (Category prime : primaryCatagories) {
			ArrayList<Category> secondaries = categoryMap.get(prime);
			for (Category cata : secondaries) {
				jScript = jScript.concat("'"+cata.toString() + "',");
			}
		}
		return jScript.substring(0, (jScript.length() - 1));
	}

	/**
	 * Print a pipe delimited string for a JS array
	 * 
	 * @param primary
	 * @return ex. "Skid Steer|Excavator"
	 */
	public String getSecondayCatagoriesToJS(Category primary) {
		ArrayList<Category> secondaries = categoryMap.get(primary);
		String jScript = "";
		for (Category cata : secondaries) {
			jScript = jScript.concat(cata.toString() + "|");
		}
		return jScript.substring(0, (jScript.length() - 1));
	}

	public static CategoryFactory getInstance() {
		if (ecInstance == null)
			ecInstance = new CategoryFactory();
		return ecInstance;
	}

	/**
	 * Get IndexOf from ArrayList plus one
	 * 
	 * @param cata
	 *            category to get IndexOf
	 * @return IndexOf from ArrayList plus one
	 */
	public Integer getIndex(Category cata) {
		if (categoryMap.containsKey(cata)) {
			return new Integer(primaryCatagories.indexOf(cata) + 1);
		} else if (categoryMap.containsValue(cata)) {
			for (Category c : primaryCatagories) {
				ArrayList<Category> seconday = categoryMap.get(c);
				if (seconday.contains(cata)) {
					return new Integer(seconday.indexOf(cata) + 1);
				}
			}
		}

		return new Integer("0");
	}
}
