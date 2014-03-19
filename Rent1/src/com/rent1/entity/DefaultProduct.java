package com.rent1.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;
import com.rent1.reference.Specification;

@Entity
@Cache
@NoArgsConstructor
public class DefaultProduct implements Product, Comparable<DefaultProduct>{
	@Id
	@Getter
	@Setter
	private Long id;

	@Index
	@Getter
	@Setter
	private String make = "";
	@Getter
	@Setter
	private String makeImg = "";
	@Index
	@Getter
	@Setter
	private String category = "";
	@Getter
	@Setter
	@Index
	private String modelName = "";
	@Getter
	@Setter
	private String productImg = "";
	@Getter
	@Setter
	private String thumbImg = "";
	@Getter
	@Setter
	private String companyHref = "";
	@Getter
	@Setter
	private Specification specs;
	@Load
	private Ref<ProductDetail> productDetail;

	public ProductDetail getProductDetail() {
		return productDetail.get();
	}

	public void setProductDetail(ProductDetail pDet) {
		this.productDetail = Ref.create(pDet);
	}
	
	@Override
	public String toString(){
		return make+", "+modelName;
	}

	@Override
	public int compareTo(DefaultProduct other) {
		return this.toString().compareTo(other.toString());
	}
	
}
