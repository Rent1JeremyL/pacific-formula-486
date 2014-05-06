package com.rent1.servlet.comp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.RentalProductDao;
import com.rent1.entity.User;

@SuppressWarnings("serial")
public class DeleteOfficeEquipmentServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(DeleteOfficeEquipmentServlet.class);

	private static final String HTTP_FORWARD = "/company/equipment";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		User user = User.getUserSession(req);
		if (user == null) {
			resp.sendRedirect("/");
		}
		Long prodId = Long.valueOf((String)req.getParameter("equipId"));
		
		RentalProductDao.INSTANCE.deleteProductById(prodId);		
		
		resp.sendRedirect(HTTP_FORWARD);
		return;
	}
}
