package com.rent1.reference;

import lombok.Getter;
import lombok.Setter;

public class Category implements Comparable<Category> {

	// Primary Categories
	public static final String PC_EARTHMOVING = "Earthmoving Equipment";
	public static final String PC_AERIAL_LIFT = "Aerial & Lift Equipment";
	public static final String PC_CONCRETE = "Concrete Equipment";
	public static final String PC_COMPACTION = "Compaction Equipment";
	public static final String PC_CONSTRUCTION = "Construction Equipment";

	protected static final Category[] PRIMARY_CATAGORIES = {
			new Category(PC_AERIAL_LIFT), new Category(PC_COMPACTION),
			new Category(PC_CONCRETE), new Category(PC_CONSTRUCTION),
			new Category(Category.PC_EARTHMOVING) };

	// Secondary Categories for EARTHMOVING
	public static final String SKID_STEER = "Skid Steer";
	public static final String EXCAVATOR = "Excavator";
	public static final String EXCAVATOR_MINI = "Mini Excavator";
	public static final String TRACK_LOADER = "Track Loader";
	public static final String TRACK_LOADER_MINI = "Mini Track Loader";
	public static final String BACKHOE = "Backhoe";

	protected static final Category[] SC_EARTHMOVING = {
			new Category(SKID_STEER), new Category(EXCAVATOR),
			new Category(EXCAVATOR_MINI), new Category(TRACK_LOADER),
			new Category(TRACK_LOADER_MINI), new Category(BACKHOE) };

	// Secondary Categories for AERIAL
	public static final String BOOM_LIFT = "Boom Lift";
	public static final String PERSONNEL_LIFT = "Personnel Lift";
	public static final String SCISSOR_LIFT = "Scissor Lift";
	public static final String TELEHANDLER = "Telehandler";

	protected static final Category[] SC_AERIAL = { new Category(BOOM_LIFT),
			new Category(PERSONNEL_LIFT), new Category(SCISSOR_LIFT),
			new Category(TELEHANDLER) };

	// Secondary Categories for CONCRETE
	public static final String BREAKER = "Breaker";
	public static final String BRICK_CUTTER = "Brick Cutter";
	public static final String BUSHING_TOOL = "Bushing Tool";
	public static final String CEMENT_MIXER = "Cement Mixer";
	public static final String CORE_BIT = "Core Bit Extension";
	public static final String GRINDER = "Grinder";
	public static final String REBAR_CUTTER = "Rebar Cutter";

	protected static final Category[] SC_CONCRETE = { new Category(BREAKER),
			new Category(BRICK_CUTTER), new Category(BUSHING_TOOL),
			new Category(CEMENT_MIXER), new Category(CORE_BIT),
			new Category(GRINDER), new Category(REBAR_CUTTER) };

	// Secondary Categories for COMPACTION
	public static final String PLATE_TAMPER = "Plate Tamper";
	public static final String RAMMER = "Rammer";
	public static final String ROLLER = "Roller";

	protected static final Category[] SC_COMPACTION = {
			new Category(PLATE_TAMPER), new Category(RAMMER),
			new Category(ROLLER) };

	// Secondary Categories for CONSTRUCTION
	public static final String AIR_SCRUBBER = "Air Scrubber";
	public static final String BARRICADE = "Barricade";
	public static final String COMPRESSOR = "Compressor";
	public static final String FAN = "Fan";

	protected static final Category[] SC_CONSTRUCTION = {
			new Category(AIR_SCRUBBER), new Category(BARRICADE),
			new Category(COMPRESSOR), new Category(FAN) };

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

	@Override
	public String toString() {
		return this.name;
	}
}
