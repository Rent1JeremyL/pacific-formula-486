package com.rent1.reference;

import lombok.Getter;
import lombok.Setter;

public class Category implements Comparable<Category> {
	//TODO Organize in Primary and Secondary and update lists
	// Primary Categories
	public static final String PC_EARTHMOVING = "Earthmoving Equipment";
	public static final String PC_AERIAL_LIFT = "Aerial & Lift Equipment";
	public static final String PC_CONCRETE = "Concrete Equipment";
	public static final String PC_COMPACTION = "Compaction Equipment";
	public static final String PC_CONSTRUCTION = "Construction Equipment";

	// Secondary Categories for EARTHMOVING
	public static final String SKID_STEER = "Skid Steer";
	public static final String EXCAVATOR = "Excavator";
	public static final String EXCAVATOR_MINI = "Excavator, mini";
	public static final String TRACK_LOADER = "Track Loader";
	public static final String TRACK_LOADER_MINI = "Track Loader, Mini";
	public static final String BACKHOE = "Backhoe";

	// Secondary Categories for EARTHMOVING
	public static final String BOOM_LIFT = "Boom Lift";
	
	
	@Getter
	@Setter
	private String name;

	public Category(String category) {
		this.name = category;
	}

	@Override
	public int compareTo(Category other) {
		return this.getName().compareTo(other.getName());
	}

	public String toString() {
		return this.name;
	}
}
