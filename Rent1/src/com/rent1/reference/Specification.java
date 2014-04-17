package com.rent1.reference;

import java.io.Serializable;
import java.util.Map;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.EmbedMap;

@Embed
@NoArgsConstructor
public class Specification implements Serializable{
	private static final long serialVersionUID = 1L;
	
	public static final String TRACK_WIDTH = "Width, Track:";
	public static final String WEIGHT = "Weight:";
	public static final String DRUM_WIDTH = "Width, Drum:";

	@Getter
	@Setter
	private String primarySpecType = "";
	@Getter
	@Setter
	private String primarySpecValue = "";
	@Getter
	@Setter
	private String secondarySpecType = "";
	@Getter
	@Setter
	private String secondarySpecValue = "";
	@EmbedMap
	@Getter
	@Setter
	private Map<String, String> extraSpecs;
	
}
