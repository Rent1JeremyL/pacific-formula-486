package com.rent1.test;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;
import com.rent1.dao.DefaultProductDao;
import com.rent1.entity.DefaultProduct;
import com.rent1.reference.Category;

public class ProductSearchTest {
	private static final Logger log = Logger.getLogger(ProductSearchTest.class);
	private final LocalServiceTestHelper helper = new LocalServiceTestHelper(
			new LocalDatastoreServiceTestConfig().setApplyAllHighRepJobPolicy());

	@Before
	public void setUp() {
		helper.setUp();
		createSomeProducts();
	}

	@After
	public void tearDown() {
		helper.tearDown();
	}

	@Test
	public void testSearchSomeProducts() {
		List<DefaultProduct> prods = DefaultProductDao.INSTANCE
				.getProductsBySearchString("Skid");
		assertEquals(3, prods.size());

		prods = DefaultProductDao.INSTANCE.getProductsBySearchString("bobcat");
		assertEquals(2, prods.size());

		prods = DefaultProductDao.INSTANCE
				.getProductsBySearchString("Skid steer");
		assertEquals(3, prods.size());

		prods = DefaultProductDao.INSTANCE
				.getProductsBySearchString("320d Skid steer");
		assertEquals(1, prods.size());

		prods = DefaultProductDao.INSTANCE
				.getProductsBySearchString("John Deere Skid steer");
		assertEquals(1, prods.size());
	}

	@Test
	public void testGetProducts() {
		List<DefaultProduct> prods = DefaultProductDao.INSTANCE.getProducts();
		assertEquals(4, prods.size());
		for (DefaultProduct p : prods) {
			log.info("Found: " + p.toString());
		}
	}

	private void createSomeProducts() {
		log.debug("Creating some data....");
		List<DefaultProduct> prods = DefaultProductDao.INSTANCE.getProducts();

		if (prods.size() == 0) {
			// Product 1
			DefaultProduct pd = new DefaultProduct();
			pd.setMake("John Deere");
			pd.setModelName("320D");
			pd.setCategory(Category.SKID_STEER);
			pd.createSearchStrings();
			DefaultProductDao.INSTANCE.addProduct(pd);

			// Product 2
			DefaultProduct pd2 = new DefaultProduct();
			pd2.setMake("Bobcat");
			pd2.setModelName("S205");
			pd2.setCategory(Category.SKID_STEER);
			pd2.createSearchStrings();
			DefaultProductDao.INSTANCE.addProduct(pd2);

			// Product 3
			pd2 = new DefaultProduct();
			pd2.setMake("Bobcat");
			pd2.setModelName("S505");
			pd2.setCategory(Category.SKID_STEER);
			pd2.createSearchStrings();
			DefaultProductDao.INSTANCE.addProduct(pd2);

			// Product 4
			pd2 = new DefaultProduct();
			pd2.setMake("John Deere");
			pd2.setModelName("M620");
			pd2.setCategory(Category.EXCAVATOR);
			pd2.createSearchStrings();
			DefaultProductDao.INSTANCE.addProduct(pd2);
		}
	}
}
