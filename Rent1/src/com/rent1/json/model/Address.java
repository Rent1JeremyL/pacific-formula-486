package com.rent1.json.model;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Getter;

@NoArgsConstructor
public class Address {
	@Getter@Setter private String house_number;
	@Getter@Setter private String road;
	@Getter@Setter private String city;
	@Getter@Setter private String town;
	@Getter@Setter private String suburb;
	@Getter@Setter private String county;
	@Getter@Setter private String state;
	@Getter@Setter private String country;
	@Getter@Setter private String country_code;
	@Getter@Setter private String postcode;
}
