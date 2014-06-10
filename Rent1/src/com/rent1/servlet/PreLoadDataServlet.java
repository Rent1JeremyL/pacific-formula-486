package com.rent1.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.PlaceDao;
import com.rent1.dao.DefaultProductDao;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.ProductDetail;
import com.rent1.reference.Category;
import com.rent1.reference.Specification;

@SuppressWarnings("serial")
public class PreLoadDataServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(PreLoadDataServlet.class);

	@SuppressWarnings("static-access")
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		createSomeProducts();

		// Preload some Places
		long timeout = 1100;
		PrintWriter out = resp.getWriter();
		try {
			out.println("Loading Surrey");
			PlaceDao.INSTANCE.getPlaceByRegion("Surrey", "BC", "Canada");
			Thread.currentThread().sleep(timeout);

			out.println("Loading Delta");
			PlaceDao.INSTANCE.getPlaceByRegion("Delta", "BC", "Canada");
			Thread.currentThread().sleep(timeout);

			out.println("Loading Vancouver");
			PlaceDao.INSTANCE.getPlaceByRegion("Vancouver", "BC", "Canada");
			Thread.currentThread().sleep(timeout);

			out.println("Loading Langley");
			PlaceDao.INSTANCE.getPlaceByRegion("Langley", "BC", "Canada");
			Thread.currentThread().sleep(timeout);

			out.println("Loading Hope");
			PlaceDao.INSTANCE.getPlaceByRegion("Hope", "BC", "Canada");
			out.println(System.currentTimeMillis());
		} catch (Exception e) {
			log.error("Error preloading Places", e);
		}

		out.println("Preload of data is done.");
	}

	private void createSomeProducts() {
		log.debug("Creating some data....");
		List<DefaultProduct> prods = DefaultProductDao.INSTANCE.getProducts();

		if (prods.size() == 0) {
			// Product 1
			DefaultProduct pd = new DefaultProduct();
			pd.setThumbImg("/webincludes/img/brand/jdeere/320d-ss_thumb.jpg");
			pd.setMake("John Deere");
			pd.setMakeImg("/webincludes/img/brand/john-deere.jpg");
			pd.setModelName("320D");
			pd.setCategory(Category.SKID_STEER);
			pd.setProductImg("");
			pd.createSearchStrings();

			ProductDetail pDet1 = new ProductDetail();
			pDet1.setDescription("<p>Need to rent a Skid Steer for a commercial or residential project that can carry "
					+ "more weight than a John Deere 320D skidsteer? If tight spaces are not an issue, then the "
					+ "increased power and load capacity of a John Deere 320D Skid Steer Rental might be the way to go.</p>"
					+ " <p> <b>Powerful:</b> The 320D Skid Steer's Turbocharged 2.4L diesel engine delivers 69 "
					+ "HP (vs. 61 for the John Deere 318D Skid Steer Rental), and allows you to carry loads of "
					+ "up to 2000 lbs (vs. 1850 lbs. for the 318D). (And the 320D's Tipping Load is 4000 lbs. "
					+ "vs. 3,800 lbs. for the 320D.) </p>");

			Specification spec1 = new Specification();
			spec1.setPrimarySpecType(Specification.TRACK_WIDTH);
			spec1.setPrimarySpecValue("63 in (w/o bucket)");
			pd.setSpecs(spec1);
			DefaultProductDao.INSTANCE.addProductLinkProductDetail(pd, pDet1);

			// Product 2
			DefaultProduct pd2 = new DefaultProduct();
			pd2.setThumbImg("/webincludes/img/brand/bcat/s205-ss_thumb.jpg");
			pd2.setMake("Bobcat");
			pd2.setMakeImg("/webincludes/img/brand/bobcat.jpg");
			pd2.setModelName("S205");
			pd2.setCategory(Category.SKID_STEER);
			pd2.setProductImg("");
			pd2.createSearchStrings();

			ProductDetail pDet2 = new ProductDetail();
			pDet2.setDescription("The S205 delivers 1,000 pounds of lift capacity, yet easily fits through narrow "
					+ "openings. It weighs only 4,000 pounds for easy trailering. With a travel speed up to 6.5 mph, "
					+ "you'll get your longer-run jobs done faster. And this peppy S205 loader is also better balanced "
					+ "for greater work efficiency. It features proven safety technology — the Bobcat Interlock Control "
					+ "System (BICS™). BICS requires the operator to be seated in the loader with the seat bar in place "
					+ "and the engine running. After the 'press to operate loader' button is pushed, the "
					+ "hydraulic lift/tilt functions and traction-drive system can be operated.");

			Specification spec2 = new Specification();
			spec2.setPrimarySpecType(Specification.TRACK_WIDTH);
			spec2.setPrimarySpecValue("68 in");
			pd2.setSpecs(spec2);
			DefaultProductDao.INSTANCE.addProductLinkProductDetail(pd2, pDet2);

			// Attachment
			DefaultProduct att = new DefaultProduct();
			att.setThumbImg("/webincludes/img/brand/bcat/m10-aug_thumb.jpg");
			att.setMake("Bobcat");
			att.setMakeImg("/webincludes/img/brand/bobcat.jpg");
			att.setModelName("Model 10");
			att.setCategory(Category.AUGER);
			att.setAttachment(true);
			att.addCompatibleMakeModel("Bobcat",
					new String[] { "S205", "S100","T110" });
			att.setProductImg("");
			att.createSearchStrings();

			ProductDetail attDet = new ProductDetail();
			attDet.setDescription("Dig holes with speed and plumb-line accuracy using a "
					+ "Bobcat® auger attachment. Using heavy-duty hydraulics, the auger attachment "
					+ "bites into any soil condition with ease and efficiency. Even in "
					+ "hard and rocky soil, the high torque keeps the auger steady and "
					+ "powerful to maintain performance.");

			Specification attSpec = new Specification();
			attSpec.setPrimarySpecType("Operating Weight");
			attSpec.setPrimarySpecValue("140 lbs");
			attSpec.setSecondarySpecType("Dig Depth:");
			attSpec.setSecondarySpecValue("58 in");
			att.setSpecs(attSpec);
			DefaultProductDao.INSTANCE.addProductLinkProductDetail(att, attDet);
		}
	}
}
