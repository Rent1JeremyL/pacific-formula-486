package com.rent1.reference;

import java.io.Serializable;

import com.googlecode.objectify.annotation.Embed;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Embed
@NoArgsConstructor
@ToString(exclude = { "postCode", "street2" }, includeFieldNames = true)
public class Address implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Getter @Setter private String street1 = "";
	@Getter @Setter private String street2 = "";
	@Getter @Setter private String city = "";
	@Getter @Setter private String state = "";
	@Getter @Setter private String postCode = "";
	@Getter @Setter private String country = "";
}
