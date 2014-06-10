package com.rent1.entity;

import static com.rent1.service.OfyService.ofy;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;
import com.rent1.reference.Category;
import com.rent1.reference.Specification;
import com.rent1.utils.GeoUtils;

@Entity
@NoArgsConstructor
@Cache
public class RentalProduct implements Product, Serializable, Comparable<RentalProduct> {
	private static final long serialVersionUID = 1L;

	@Id @Getter @Setter private Long id;

	@Index @Getter @Setter private String category = "";
	@Load private Ref<Product> product;
	@Index @Getter List<String> geoCells;
	@Getter @Setter private String city = "";
	@Getter @Setter private String state = "";
	@Getter @Setter private String country = "";
	@Index @Getter @Setter private Key<Office> office;
	@Index @Getter @Setter private Key<Company> company;
	@Load private Ref<PricePlan> pricePlan;
	@Index @Getter @Setter private boolean available = true;
	@Getter @Setter private Date bookingEnds;
	@Index @Getter private Set<String> searchStrings;
	
	@Index @Getter private boolean attachment = false;
	@Index @Getter Set<String> compatibleMakeModel;
	
	@Override
	public String toString(){
		return getWebTitle()+"["+getId()+"]";
	}

	@Override
	public int compareTo(RentalProduct other) {
		return this.getWebTitle().compareTo(other.getWebTitle());
	}
	
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
		this.searchStrings = prod.getSearchStrings();
		this.attachment = prod.isAttachment();
		this.compatibleMakeModel = prod.getCompatibleMakeModel();
	}

	public RentalProduct(Product prod) {
		setProduct(prod);
	}

	public void setGeoRegion(Place place) {
		this.geoCells = GeoUtils.calculateGeoCells(place.getLatitude(),
				place.getLongitude());
		this.city = place.getCity();
		this.state = place.getState();
		this.country = place.getCountry();
	}

	public String getMake() {
		return getProduct().getMake();
	}

	/**
	 * Get a space separated title for a HTML Title Page
	 */
	public String getWebTitle() {
		return getMake() + " " + getModelName() + " " + getCategory();
	}

	/**
	 * Get a HTML safe - separated string Web Page path
	 */
	public String getWebPage() {
		String page = getMake() + "-" + getModelName();
		page = page.replace(" ", "-");
		return page;
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
		String page = getWebPage();
		return "/detail/" + id + "/" + page;
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
