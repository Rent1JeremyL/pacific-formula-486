package com.rent1.entity;

import java.io.Serializable;
import java.util.Set;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.log4j.Logger;

import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;
import com.rent1.reference.Specification;
import com.rent1.utils.StringUtils2;

@Entity
@Cache
@NoArgsConstructor
public class DefaultProduct implements Product, Serializable, Comparable<DefaultProduct> {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(DefaultProduct.class);

	@Id @Getter @Setter private Long id;

	@Index @Getter @Setter private String make = "";
	@Getter @Setter private String makeImg = "";
	@Index @Getter @Setter private String category = "";
	@Index @Getter @Setter private String modelName = "";
	@Getter @Setter private String productImg = "";
	@Getter @Setter private String thumbImg = "";
	//private String companyHref = "";
	@Getter @Setter private Specification specs;
	@Load private Ref<ProductDetail> productDetail;
	@Index @Getter private Set<String> searchStrings;

	public ProductDetail getProductDetail() {
		return productDetail.get();
	}

	public void setProductDetail(ProductDetail prodDetail) {
		this.productDetail = Ref.create(prodDetail);
	}

	@Override
	public String toString() {
		return make + " " + modelName;
	}

	@Override
	public int compareTo(DefaultProduct other) {
		return this.toString().compareTo(other.toString());
	}

	/**
	 * Create a searchable string based on category, make and model name.<br>
	 * <br>
	 * * Should always be called after @DefaultProduct creation.
	 */
	public void createSearchStrings() {
		String desc = category + " " + make + " " + modelName;

		try {
			searchStrings = StringUtils2.tokenize(desc);
		} catch (Exception e) {
			log.error(e.getMessage());
			log.error("Failed to create searchable product. Id["+getId()+"]");
		}
		searchStrings = StringUtils2.breakdownFragments(searchStrings);
	}
	
	public String getCompanyHref() {
		String page = getWebPage();
		return "/preview/" + id + "/" + page;
	}
	
	public String getWebTitle() {
		return getMake() + " " + getModelName() + " " + getCategory();
	}

	public String getWebPage() {
		String page = getMake() + "-" + getModelName();
		page = page.replace(" ", "-");
		return page;
	}
}
