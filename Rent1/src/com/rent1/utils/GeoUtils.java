package com.rent1.utils;

import java.util.List;

import com.beoui.geocell.GeocellManager;
import com.beoui.geocell.model.BoundingBox;
import com.beoui.geocell.model.Point;
import com.rent1.entity.Place;

public class GeoUtils {

	public static List<String> calculateGeoCells(double lat, double lon) {
		Point p = new Point(lat, lon);
		List<String> cells = GeocellManager.generateGeoCell(p);

		return cells;
	}

	/**
	 * Create a GeoCell BoundingBox
	 * 
	 * @param place
	 *            a place to set the center point
	 * @param radius
	 *            in Kilometers from the center point
	 * @return a BoundingBox
	 */
	public static BoundingBox generateBoundingBox(Place center, double radius) {
		double R = 6371; // earth radius in km
		double lon = center.getLongitude();
		double lat = center.getLatitude();

		double west = lon
				- Math.toDegrees(radius / R / Math.cos(Math.toRadians(lat)));
		double east = lon
				+ Math.toDegrees(radius / R / Math.cos(Math.toRadians(lat)));
		double north = lat + Math.toDegrees(radius / R);
		double south = lat - Math.toDegrees(radius / R);

		return new BoundingBox(north, east, south, west);

	}
}
