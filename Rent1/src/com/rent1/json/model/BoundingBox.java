package com.rent1.json.model;

/**
 * Represents a viewport for a Nominatim Bounding Box.
.
 * 
 * <pre>
 * "boundingbox": [
 * 		"49.0020790100098", //south
 * 		"49.2208251953125", //north
 * 		"-122.957168579102", //west
 * 		"-122.679107666016" //east
 * ],
 * </pre>
 * 
 * @author Jérémie Huchet
 */
public class BoundingBox {

	/** The north bound of the boundingbox. */
	private double north;

	/** The west bound of the boundingbox. */
	private double west;

	/** The east bound of the boundingbox. */
	private double east;

	/** The south bound of the boundingbox. */
	private double south;

	/**
	 * Gets the north.
	 * 
	 * @return the north
	 */
	public final double getNorth() {

		return north;
	}

	/**
	 * Gets the north.
	 * 
	 * @return the north
	 */
	public final int getNorthE6() {

		return (int) (north * 1E6);
	}

	/**
	 * Sets the north.
	 * 
	 * @param north
	 *            the north to set
	 */
	public final void setNorth(final double north) {

		this.north = north;
	}

	/**
	 * Sets the north.
	 * 
	 * @param north
	 *            the north to set
	 */
	public final void setNorthE6(final int north) {

		this.north = north / 1E6;
	}

	/**
	 * Gets the west.
	 * 
	 * @return the west
	 */
	public final double getWest() {

		return west;
	}

	/**
	 * Gets the west.
	 * 
	 * @return the west
	 */
	public final int getWestE6() {

		return (int) (west * 1E6);
	}

	/**
	 * Sets the west.
	 * 
	 * @param west
	 *            the west to set
	 */
	public final void setWest(final double west) {

		this.west = west;
	}

	/**
	 * Sets the west.
	 * 
	 * @param west
	 *            the west to set
	 */
	public final void setWestE6(final int west) {

		this.west = west / 1E6;
	}

	/**
	 * Gets the east.
	 * 
	 * @return the east
	 */
	public final double getEast() {

		return east;
	}

	/**
	 * Gets the east.
	 * 
	 * @return the east
	 */
	public final int getEastE6() {

		return (int) (east * 1E6);
	}

	/**
	 * Sets the east.
	 * 
	 * @param east
	 *            the east to set
	 */
	public final void setEast(final double east) {

		this.east = east;
	}

	/**
	 * Sets the east.
	 * 
	 * @param east
	 *            the east to set
	 */
	public final void setEastE6(final int east) {

		this.east = east / 1E6;
	}

	/**
	 * Gets the south.
	 * 
	 * @return the south
	 */
	public final double getSouth() {

		return south;
	}

	/**
	 * Gets the south.
	 * 
	 * @return the south
	 */
	public final int getSouthE6() {

		return (int) (south * 1E6);
	}

	/**
	 * Sets the south.
	 * 
	 * @param south
	 *            the south to set
	 */
	public final void setSouth(final double south) {

		this.south = south;
	}

	/**
	 * Sets the south.
	 * 
	 * @param south
	 *            the south to set
	 */
	public final void setSouthE6(final int south) {

		this.south = south / 1E6;
	}

}
