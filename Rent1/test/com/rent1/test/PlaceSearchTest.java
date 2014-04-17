package com.rent1.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.beoui.geocell.model.BoundingBox;
import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;
import com.rent1.dao.PlaceDao;
import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Place;
import com.rent1.entity.RentalProduct;
import com.rent1.utils.GeoUtils;

public class PlaceSearchTest {
	private static final Logger log = Logger.getLogger(PlaceSearchTest.class);
	private final LocalServiceTestHelper helper = new LocalServiceTestHelper(
			new LocalDatastoreServiceTestConfig()
					.setApplyAllHighRepJobPolicy());

	private Place surrey;
	private Place delta;
	private Place whistler;

	@SuppressWarnings("static-access")
	@Before
	public void setUp() throws InterruptedException {
		helper.setUp();

		surrey = PlaceDao.INSTANCE.getPlaceByRegoin("Surrey", "BC", "Canada");
		Thread.currentThread().sleep(1100);
		delta = PlaceDao.INSTANCE.getPlaceByRegoin("Delta", "BC", "Canada");
		Thread.currentThread().sleep(1100);
		whistler = PlaceDao.INSTANCE.getPlaceByRegoin("Whistler", "BC",
				"Canada");
	}

	@After
	public void tearDown() {
		helper.tearDown();
	}

	@Test
	public void testPlaceSearch() throws InterruptedException {

		BoundingBox bb = GeoUtils.generateBoundingBox(surrey, 20);
		log.info("Center: " + surrey.getLatitude() + ","
				+ surrey.getLongitude());

		log.info("Box North: " + bb.getNorth());
		log.info("Box South: " + bb.getSouth());
		log.info("Box East: " + bb.getEast());
		log.info("Box West: " + bb.getWest());

		assertTrue(delta.isIn(bb));
		assertFalse(whistler.isIn(bb));

		bb = GeoUtils.generateBoundingBox(surrey, 150);
		assertTrue(whistler.isIn(bb));
	}

	@Test
	public void testProductInRange() {
		RentalProduct rp1 = new RentalProduct();
		rp1.setGeoRegion(surrey);
		RentalProductDao.INSTANCE.addProduct(rp1);

		rp1 = new RentalProduct();
		rp1.setGeoRegion(delta);
		RentalProductDao.INSTANCE.addProduct(rp1);

		rp1 = new RentalProduct();
		rp1.setGeoRegion(whistler);
		RentalProductDao.INSTANCE.addProduct(rp1);

		List<RentalProduct> rps = RentalProductDao.INSTANCE
				.getProductsByGeoCells(delta, 15);

		assertEquals(2, rps.size());

		rps = RentalProductDao.INSTANCE.getProductsByGeoCells(delta, 150);

		assertEquals(3, rps.size());
	}
}
