package com.rent1.factory;

import java.util.ArrayList;
import java.util.Collections;

import com.rent1.reference.Specification;

public class ProductDetailFactory {
	private static ProductDetailFactory instance = null;

	private static String[] specArray = { Specification.TRACK_WIDTH,
			Specification.WEIGHT, Specification.DRUM_WIDTH };
	private static ArrayList<String> detailList = null;

	private ProductDetailFactory() {

	}

	public static ProductDetailFactory getInstance() {
		if (instance == null)
			instance = new ProductDetailFactory();
		return instance;
	}

	public ArrayList<String> getDetailList() {
		if (detailList == null) {
			for (int i = 0; i < specArray.length; i++) {
				detailList.add(specArray[i]);
			}
			Collections.sort(detailList);
		}
		return detailList;
	}
}
