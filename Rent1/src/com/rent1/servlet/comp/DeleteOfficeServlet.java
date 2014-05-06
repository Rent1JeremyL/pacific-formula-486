package com.rent1.servlet.comp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.OfficeDao;
import com.rent1.dao.RentalProductDao;
import com.rent1.entity.Office;
import com.rent1.entity.User;

@SuppressWarnings("serial")
public class DeleteOfficeServlet extends HttpServlet {
	private static final Logger log = Logger
			.getLogger(DeleteOfficeServlet.class);

	private static final String HTTP_FORWARD = "/company/offices";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		User user = User.getUserSession(req);
		if (user == null) {
			resp.sendRedirect("/");
		}
		Long officeId = Long.valueOf((String)req.getParameter("officeId"));
		Office office = OfficeDao.INSTANCE.getOfficeById(officeId);
		
		RentalProductDao.INSTANCE.deleteProductsByOfficeKey(office.getKey());		
		OfficeDao.INSTANCE.deleteOfficeById(office.getId());
		
		resp.sendRedirect(HTTP_FORWARD);
		return;
	}
}
