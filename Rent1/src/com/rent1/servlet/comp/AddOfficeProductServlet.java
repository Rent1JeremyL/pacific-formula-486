package com.rent1.servlet.comp;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Key;
import com.rent1.dao.DefaultProductDao;
import com.rent1.dao.OfficeDao;
import com.rent1.dao.PlaceDao;
import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Company;
import com.rent1.entity.Office;
import com.rent1.entity.Place;
import com.rent1.entity.PricePlan;
import com.rent1.entity.Product;
import com.rent1.entity.RentalProduct;

@SuppressWarnings("serial")
public class AddOfficeProductServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(AddOfficeProductServlet.class);

	private static final String HTTP_SRC = "/company/equipment/add";

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.getSession().setAttribute("errCompany", null);
		req.getSession().setAttribute("resultMessage", null);

		@SuppressWarnings("unchecked")
		Enumeration<String> paramNames = req.getParameterNames();
		String id = null;
		while (paramNames.hasMoreElements()) {
			// check for submit button id
			String paramName = paramNames.nextElement();
			if (paramName.contains("submit")) {
				String[] parse = paramName.split("-");
				id = parse[1];
			}
		}

		String prodId = req.getParameter("add-prodid-" + id);
		String officeId = req.getParameter("add-office");
		String quantity = req.getParameter("add-prodquant-" + id);
		String hourly = req.getParameter("add-prod-h-" + id);
		String daily = req.getParameter("add-prod-d-" + id);
		String weekly = req.getParameter("add-prod-w-" + id);
		String monthly = req.getParameter("add-prod-m-" + id);

		if (officeId.equals("0")) {
			req.getSession().setAttribute("errCompany",
					"Please select an office first.");
			resp.sendRedirect(HTTP_SRC);
			return;
		}
		if (hourly.equals("0") && daily.equals("0") && weekly.equals("0")
				&& monthly.equals("0")) {
			req.getSession().setAttribute("errCompany",
					"All rates cannot be set to zero.");
			resp.sendRedirect(HTTP_SRC);
			return;
		}

		Office office = OfficeDao.INSTANCE
				.getOfficeById(Long.valueOf(officeId));
		Key<Company> companyKey = office.getCompanyKey();

		Product product = DefaultProductDao.INSTANCE.getProductById(Long
				.valueOf(prodId));
		Place place = PlaceDao.INSTANCE.getPlaceByKey(office.getPlaceKey());

		PricePlan pp = new PricePlan(place.getCountry_code());
		pp.setRateHourly(Integer.valueOf(hourly).intValue());
		pp.setRateDaily(Integer.valueOf(daily).intValue());
		pp.setRateWeekly(Integer.valueOf(weekly).intValue());
		pp.setRateMonthly(Integer.valueOf(monthly).intValue());

		int loop = Integer.valueOf(quantity).intValue();
		for (int x = 1; x <= loop; x++) {
			RentalProduct rp = new RentalProduct(product);
			rp.setPricePlan(pp);
			rp.setGeoRegion(place);
			rp.setCompany(companyKey);
			rp.setOffice(office.getKey());

			RentalProductDao.INSTANCE.addProduct(rp);
		}
		req.setAttribute("resultMessage",
				"Added " + quantity + " " + product.getWebTitle() + "(s).");

		req.getRequestDispatcher(HTTP_SRC).forward(req, resp);
		return;
	}
}
