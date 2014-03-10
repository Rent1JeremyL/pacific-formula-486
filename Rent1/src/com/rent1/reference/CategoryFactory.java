package com.rent1.reference;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;

public class CategoryFactory {
	private static CategoryFactory ecInstance = null;

	private static final String[] cataArray = { "Aerial Work Platforms",
			"Air Compressors & Air Tools", "Backhoes", "Bulldosers",
			"Compaction", "Concrete & Masonry", "Earthmoving Equipment",
			Category.EXCAVATOR, "Forklifts", "Forklifts & Material Handling",
			"Light Towers & Generators", "Plumbing & Pipes", "Power & HVAC",
			"Power Tools & Surveying", "Pressure Washers",
			"Pressure Washers & Pumps", "Pumps", Category.SKID_STEER,
			"Surface Preparation", "Traffic Control",
			"Trench Safety & Shoring", "Vehicles", "Welders" };

	private Map<String, String[]> categoryMap = null;
	private ArrayList<Category> categories;

	private CategoryFactory() {
		
		categories = new ArrayList<Category>();
		
		for (int i = 0; i < cataArray.length; i++) {
			categories.add(new Category(cataArray[i]));
		}
		Collections.sort(categories);
	}

	public ArrayList<Category> getCatagories() {
		return categories;
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
		return new Integer(categories.indexOf(cata) + 1);
	}
}
