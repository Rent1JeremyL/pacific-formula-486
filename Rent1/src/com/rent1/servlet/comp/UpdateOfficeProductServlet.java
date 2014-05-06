package com.rent1.servlet.comp;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.RentalProductDao;
import com.rent1.entity.PricePlan;
import com.rent1.entity.RentalProduct;

@SuppressWarnings("serial")
public class UpdateOfficeProductServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(UpdateOfficeProductServlet.class);

	private static final String HTTP_SRC = "/company/equipment";

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.getSession().setAttribute("errCompany", null);

		@SuppressWarnings("unchecked")
		Enumeration<String> paramNames = req.getParameterNames();
		String id = null;
		while (paramNames.hasMoreElements()) {
			// check for submit button id
			String paramName = (String) paramNames.nextElement();
			if (paramName.contains("submit")) {
				String[] parse = paramName.split("-");
				id = parse[1];
			}
		}

		String hourly = req.getParameter("upd-hourly-" + id);
		String daily = req.getParameter("upd-daily-" + id);
		String weekly = req.getParameter("upd-weekly-" + id);
		String monthly = req.getParameter("upd-monthly-" + id);

		if (hourly.equals("0") && daily.equals("0") && weekly.equals("0")
				&& monthly.equals("0")) {
			req.getSession().setAttribute("errCompany",
					"All rates cannot be set to zero.");
			resp.sendRedirect(HTTP_SRC);
			return;
		}

		RentalProduct product = RentalProductDao.INSTANCE.getProductById(Long
				.valueOf(id));

		PricePlan plan = product.getPricePlan();
		plan.setRateHourly(Integer.valueOf(hourly).intValue());
		plan.setRateDaily(Integer.valueOf(daily).intValue());
		plan.setRateWeekly(Integer.valueOf(weekly).intValue());
		plan.setRateMonthly(Integer.valueOf(monthly).intValue());
		product.setPricePlan(plan);

		RentalProductDao.INSTANCE.addProduct(product);

		req.getRequestDispatcher(HTTP_SRC).forward(req, resp);
		return;
	}
}
