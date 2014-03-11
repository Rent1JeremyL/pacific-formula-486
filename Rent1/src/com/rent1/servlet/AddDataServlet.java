package com.rent1.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.impl.Log4JLogger;

import com.rent1.dao.PlaceDao;
import com.rent1.dao.ProductDao;
import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Place;
import com.rent1.entity.PricePlan;
import com.rent1.entity.DefaultProduct;
import com.rent1.entity.RentalProduct;
import com.rent1.utils.ValidationUtils;

@SuppressWarnings("serial")
public class AddDataServlet extends HttpServlet {
	private static final Log4JLogger log = new Log4JLogger(
			AddDataServlet.class.getName());

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		long time = System.currentTimeMillis();
		List<DefaultProduct> prods = ProductDao.INSTANCE.getProducts();

		PricePlan pp = new PricePlan(Locale.CANADA);
		pp.setRateDaily(240);
		pp.setRateWeekly(1200);
		pp.setRateMonthly(3800);

		Place here = null;
		switch (ValidationUtils.randInt(1, 5)) {
		case 1:
			here = PlaceDao.INSTANCE.getPlaceByRegoin("Surrey", "BC", "Canada");
			break;
		case 2:
			here = PlaceDao.INSTANCE.getPlaceByRegoin("Delta", "BC", "Canada");
			break;
		case 3:
			here = PlaceDao.INSTANCE.getPlaceByRegoin("Vancouver", "BC",
					"Canada");
			break;
		case 4:
			here = PlaceDao.INSTANCE
					.getPlaceByRegoin("Langley", "BC", "Canada");
			break;
		case 5:
			here = PlaceDao.INSTANCE.getPlaceByRegoin("Hope", "BC", "Canada");
			break;
		}

		for (DefaultProduct pd : prods) {
			RentalProduct rp1 = new RentalProduct(pd);
			rp1.setPricePlan(pp);
			rp1.setGeoRegion(here);
			RentalProductDao.INSTANCE.addProduct(rp1);
		}

		PrintWriter out = resp.getWriter();
		out.println("Total Product Entries: "
				+ ProductDao.INSTANCE.getProductCount());
		out.println("Total Rental Product Entries: "
				+ RentalProductDao.INSTANCE.getProductCount());
		long millis = System.currentTimeMillis() - time;
		log.info("Adding Rental Products took " + millis + " millis");
	}

}
