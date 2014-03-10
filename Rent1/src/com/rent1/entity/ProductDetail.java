package com.rent1.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Parent;

@Entity
@NoArgsConstructor
public class ProductDetail {
	@Id
	@Getter
	@Setter
	private Long id;

	@Getter
	@Setter
	private String description = "";

	@Parent
	@Getter
	@Setter
	private Key<DefaultProduct> productKey;

}
