package com.rent1.entity;

import static com.rent1.service.OfyService.ofy;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.beoui.geocell.GeocellManager;
import com.beoui.geocell.model.Point;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;
import com.rent1.reference.Specification;

@Entity
@NoArgsConstructor
public class RentalProduct implements Product {
	@Id
	@Getter
	@Setter
	private Long id;

	@Index
	@Getter
	@Setter
	private String category = "";
	@Load
	private Ref<Product> product;
	@Index
	@Getter
	List<String> geoCells;
	@Getter
	@Setter
	private String city = "";
	@Getter
	@Setter
	private String state = "";
	@Getter
	@Setter
	private String country = "";
	@Getter
	@Setter
	@Index
	private Key<Office> office;
	@Index
	@Getter
	@Setter
	private Key<Company> company;
	@Load
	private Ref<PricePlan> pricePlan;
	@Getter
	@Setter
	private String attachments = "";
	@Getter
	@Setter
	@Index
	private boolean available = true;
	@Getter
	@Setter
	private Date bookingEnds;

	public PricePlan getPricePlan() {
		return pricePlan.get();
	}

	public void setPricePlan(PricePlan pPlan) {
		ofy().save().entity(pPlan).now();
		this.pricePlan = Ref.create(pPlan);
	}

	public Product getProduct() {
		return product.get();
	}

	private void setProduct(Product prod) {
		this.product = Ref.create(prod);
		this.category = prod.getCategory();
	}

	public RentalProduct(Product prod) {
		setProduct(prod);
	}

	private List<String> calculateGeoCells(double lat, double lon) {
		Point p = new Point(lat, lon);
		List<String> cells = GeocellManager.generateGeoCell(p);

		return cells;
	}

	public void setGeoRegion(Place place) {
		this.geoCells = calculateGeoCells(place.getLatitude(),
				place.getLongtitude());
		this.city = place.getCity();
		this.state = place.getState();
		this.country = place.getCountry();
	}

	public String getMake() {
		return getProduct().getMake();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setMake(String make) {
	}

	public String getMakeImg() {
		return getProduct().getMakeImg();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setMakeImg(String makeImg) {
	}

	public String getModelName() {
		return getProduct().getModelName();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setModelName(String modelName) {
	}

	public String getProductImg() {
		return getProduct().getProductImg();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setProductImg(String productImg) {
	}

	public String getThumbImg() {
		return getProduct().getThumbImg();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setThumbImg(String thumbImg) {
	}

	public String getCompanyHref() {
		return getProduct().getCompanyHref();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setCompanyHref(String companyHref) {
	}

	public Specification getSpecs() {
		return getProduct().getSpecs();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setSpecs(Specification specs) {
	}

	@Override
	public ProductDetail getProductDetail() {
		return getProduct().getProductDetail();
	}

	/**
	 * Do not use, does nothing
	 * 
	 * @deprecated
	 */
	public void setProductDetail(ProductDetail pDet) {
	}
}
