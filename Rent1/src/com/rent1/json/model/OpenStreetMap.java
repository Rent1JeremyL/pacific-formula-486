package com.rent1.json.model;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Getter;

@NoArgsConstructor
public class OpenStreetMap {
	@Getter@Setter private Long place_id;
	@Getter@Setter private String licence;
	@Getter@Setter private String osm_type;
	@Getter@Setter private Long osm_id;
	@Getter@Setter private BoundingBox boundingbox;
	@Getter@Setter private double lat;
	@Getter@Setter private double lon;
	@Getter@Setter private String display_name;
	@Getter@Setter private String type;
	@Getter@Setter private double importance;
	@Getter@Setter private String icon;
	@Getter@Setter private Address address;
}
