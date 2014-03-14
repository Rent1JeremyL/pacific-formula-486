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
import com.rent1.dao.ProductDao;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.ProductDetail;
import com.rent1.reference.Category;
import com.rent1.reference.Specification;

@SuppressWarnings("serial")
public class PreLoadDataServlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(
			PreLoadDataServlet.class);

	@SuppressWarnings("static-access")
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		createSomeProducts();

		// Preload some Places
		long timeout = 2000;
		PrintWriter out = resp.getWriter();
		try {
			out.println("Loading Surrey");
			PlaceDao.INSTANCE.getPlaceByRegoin("Surrey", "BC", "Canada");
			Thread.currentThread().sleep(timeout);
			
			out.println("Loading Delta");
			PlaceDao.INSTANCE.getPlaceByRegoin("Delta", "BC", "Canada");
			Thread.currentThread().sleep(timeout);
			
			out.println("Loading Vancouver");
			PlaceDao.INSTANCE.getPlaceByRegoin("Vancouver", "BC", "Canada");
			Thread.currentThread().sleep(timeout);
			
			out.println("Loading Langley");
			PlaceDao.INSTANCE.getPlaceByRegoin("Langley", "BC", "Canada");
			Thread.currentThread().sleep(timeout);
			
			out.println("Loading Hope");
			PlaceDao.INSTANCE.getPlaceByRegoin("Hope", "BC", "Canada");
			out.println(System.currentTimeMillis());
		} catch (Exception e) {
			log.error("Error preloading Places", e);
		}
		
		out.println("Preload of data is done.");
	}

	private void createSomeProducts() {
		log.debug("Creating some data....");
		List<DefaultProduct> prods = ProductDao.INSTANCE.getProducts();

		if (prods.size() == 0) {
			// Product 1
			DefaultProduct pd = new DefaultProduct();
			pd.setThumbImg("/webincludes/img/brand/jdeere/320d-ss_thumb.jpg");
			pd.setMake("John Deere");
			pd.setMakeImg("/webincludes/img/brand/john-deere.jpg");
			pd.setModelName("320D");
			pd.setCategory(Category.SKID_STEER);
			pd.setProductImg("/webincludes/img/brand/jdeere/320d-ss.jpg");
			pd.setCompanyHref("http://www.deere.com/wps/dcom/en_US/products/equipment/skid_steers/320d/320d.page");

			ProductDetail pDet1 = new ProductDetail();
			pDet1.setDescription("The redesigned 320D Skid Steer incorporates a roomier operator station, "
					+ "a quieter pressurized cab with best-in-class visibility, and a curved-glass swing-out door."
					+ " You also have a choice of numerous productivity-boosting options including EH joysticks with"
					+ " selectable control pattern and variable boom and bucket speed settings. ");

			Specification spec1 = new Specification();
			spec1.setPrimarySpecType(Specification.TRACK_WIDTH);
			spec1.setPrimarySpecValue("63 in (w/o bucket)");
			pd.setSpecs(spec1);
			ProductDao.INSTANCE.addProductLinkProductDetail(pd, pDet1);

			// Product 2
			DefaultProduct pd2 = new DefaultProduct();
			pd2.setThumbImg("/webincludes/img/brand/bcat/s205-ss_thumb.jpg");
			pd2.setMake("Bobcat");
			pd2.setMakeImg("/webincludes/img/brand/bobcat.jpg");
			pd2.setModelName("S205");
			pd2.setCategory(Category.SKID_STEER);
			pd2.setProductImg("/webincludes/img/brand/bcat/s205-ss.jpg");
			pd2.setCompanyHref("http://www.bobcat.com/loaders/models/skidsteer/s205");

			ProductDetail pDet2 = new ProductDetail();
			pDet2.setDescription("The redesigned 320D Skid Steer incorporates a roomier operator station, "
					+ "a quieter pressurized cab with best-in-class visibility, and a curved-glass swing-out door."
					+ " You also have a choice of numerous productivity-boosting options including EH joysticks with "
					+ "selectable control pattern and variable boom and bucket speed settings. ");

			Specification spec2 = new Specification();
			spec2.setPrimarySpecType(Specification.TRACK_WIDTH);
			spec2.setPrimarySpecValue("68 in");
			pd2.setSpecs(spec2);
			ProductDao.INSTANCE.addProductLinkProductDetail(pd2, pDet2);
		}
	}
}
