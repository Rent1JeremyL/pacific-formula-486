package com.rent1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.impl.Log4JLogger;

import com.rent1.dao.ProductDao;
import com.rent1.entity.Product;

@SuppressWarnings("serial")
public class SearchProductServlet extends HttpServlet {
	private static Log4JLogger log = new Log4JLogger(
			SearchProductServlet.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// createSomeProducts();

		String cata = req.getParameter("rental");
		String geoLoc = req.getParameter("location");
		req.getSession().setAttribute("catagory", cata);
		req.getSession().setAttribute("location", geoLoc);
		
		String attribs = "catagory=" + cata + "&" + "location=" + geoLoc;
		attribs = attribs.replace(" ", "%");

		resp.sendRedirect("/search.jsp?" + attribs);

	}

	private void createSomeProducts() {
		log.debug("Creating some data....");
		Product pd = new Product();
		pd.setThumbImg("img/brand/jdeere/320d-ss_thumb.jpg");
		pd.setBrand("John Deere");
		pd.setBrandImg("img/brand/john-deere.jpg");
		pd.setProductName("320D Skid Steer");
		pd.setProdCatagory("Skid Steers");
		pd.setProductImg("img/brand/jdeere/320d-ss.jpg");
		pd.setCompanyPage("http://www.deere.com/wps/dcom/en_US/products/equipment/skid_steers/320d/320d.page");

		Product pd2 = new Product();
		pd2.setThumbImg("img/brand/bcat/S205-ss_thumb.jpg");
		pd2.setBrand("Bobcat");
		pd2.setBrandImg("img/brand/bobcat.jpg");
		pd2.setProductName("S205 Skid-Steer Loader");
		pd2.setProdCatagory("Skid Steers");
		pd2.setProductImg("img/brand/bcat/s205-ss.jpg");
		pd2.setCompanyPage("http://www.bobcat.com/loaders/models/skidsteer/s205");

		ProductDao.INSTANCE.addProduct(pd);
		ProductDao.INSTANCE.addProduct(pd2);
	}
}
