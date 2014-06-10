package com.rent1.servlet.comp;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.OfficeDao;
import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Office;
import com.rent1.entity.RentalProduct;
import com.rent1.entity.User;

public class ShowOfficeEquipmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String HTTP_FORWARD = "/WEB-INF/jsp/comp/company_equipment.jsp";
	private static final Logger log = Logger
			.getLogger(ShowOfficeEquipmentServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		User user = User.getUserSession(req);

		List<Office> offResults = OfficeDao.INSTANCE.getOfficesByCompany(user
				.getCompany());
		Map<Office, ArrayList<RentalProduct>> offices = new HashMap<Office, ArrayList<RentalProduct>>();
		for (Office off : offResults) {
			if (off != null) {
				List<RentalProduct> prods = RentalProductDao.INSTANCE
						.getProductsByOfficeKey(off.getKey());
				ArrayList<RentalProduct> rps = new ArrayList<RentalProduct>();
				for (RentalProduct rp : prods) {
					if (rp != null)
						rps.add(rp);
				}
				Collections.sort(rps);
				offices.put(off, rps);
			}

		}

		req.setAttribute("showOffices", offices);

		req.getRequestDispatcher(HTTP_FORWARD).forward(req, resp);
		return;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
