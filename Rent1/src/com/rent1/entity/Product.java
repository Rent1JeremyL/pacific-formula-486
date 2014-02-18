package com.rent1.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long prodId;

	private String brand;
	private String brandImg;
	private String prodCatagory;
	private String productName;
	private String productImg;
	private String thumbImg;
	private String companyPage;

	public Product() {

	}

	public Long getProdId() {
		return prodId;
	}

	public void setProdId(Long prodId) {
		this.prodId = prodId;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getBrandImg() {
		return brandImg;
	}

	public void setBrandImg(String brandImg) {
		this.brandImg = brandImg;
	}

	public String getProdCatagory() {
		return prodCatagory;
	}

	public void setProdCatagory(String prodCatagory) {
		this.prodCatagory = prodCatagory;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductImg() {
		return productImg;
	}

	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}

	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public String getCompanyPage() {
		return companyPage;
	}

	public void setCompanyPage(String companyPage) {
		this.companyPage = companyPage;
	}

}
