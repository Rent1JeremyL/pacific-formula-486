package com.rent1.entity;

import com.rent1.reference.Specification;

public interface Product {
	
	public Long getId();
	public void setId(Long id);

	public String getMake();
	public void setMake(String make);

	public String getMakeImg();
	public void setMakeImg(String makeImg);

	public String getCategory();
	public void setCategory(String catagory);

	public String getModelName();
	public void setModelName(String modelName);

	public String getProductImg();
	public void setProductImg(String productImg);

	public String getThumbImg();
	public void setThumbImg(String thumbImg);

	public String getCompanyHref();
	public void setCompanyHref(String companyHref);

	public Specification getSpecs();
	public void setSpecs(Specification specs);
	
	public ProductDetail getProductDetail();
	public void setProductDetail(ProductDetail pDet);
}
