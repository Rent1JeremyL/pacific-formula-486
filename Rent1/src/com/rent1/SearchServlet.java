package com.rent1;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rent1.dao.ProductDao;
import com.rent1.entity.Product;

@SuppressWarnings("serial")
public class SearchServlet extends HttpServlet {
	List<Product> prods = null;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		List<Product> prods = null;
		prods = ProductDao.INSTANCE.listProducts();

		if (prods == null) {
			req.setAttribute("error", "No values returned in search");
			resp.sendRedirect("/index.jsp");
		}
	}
}
