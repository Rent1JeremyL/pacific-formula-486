package com.rent1.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rent1.dao.RentalProductDao;
import com.rent1.entity.RentalProduct;

public class ShowProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String HTTP_MAIN = "/";
	private static final Logger log = Logger
			.getLogger(ShowProductServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String[] parse = req.getPathInfo().split("/");
		Long id = Long.valueOf(parse[1]);

		RentalProduct prod = RentalProductDao.INSTANCE.getProductById(id);

		req.getSession().setAttribute("showProduct", prod);
		req.getRequestDispatcher("/product").forward(req, resp);
		return;
	}
}
