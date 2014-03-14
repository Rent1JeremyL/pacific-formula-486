package com.rent1.service;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.HttpResponse;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.rent1.entity.Place;
import com.rent1.gson.BoundingBoxDeserializer;
import com.rent1.json.model.BoundingBox;
import com.rent1.json.model.OpenStreetMap;

public class LongLatService {
	private static final Logger log = Logger.getLogger(LongLatService.class
			.getName());

	private static final String GEOCODE_REQUEST_URL = "http://nominatim.openstreetmap.org/search?";

	private static final String REF_EMAIL = "&email=rent1gae@gmail.com";
	private static final String FORMAT = "&format=json";
	private static final String LIMIT = "&limit=1";
	private static final String DETAILS = "&addressdetails=1";

	static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

	/**
	 * 
	 * @param city
	 * @param state
	 * @param country
	 * @return a full place with longitude and latitude
	 */
	public static Place createPlace(String city, String state, String country) {
		HttpRequestFactory requestFactory = HTTP_TRANSPORT
				.createRequestFactory();

		StringBuilder address = new StringBuilder();
		address.append(city + "+").append(state + "+").append(country);

		try {
			StringBuilder urlBuilder = new StringBuilder(GEOCODE_REQUEST_URL);
			if (StringUtils.isNotBlank(address.toString())) {
				urlBuilder.append("q=").append(address.toString());
				urlBuilder.append(FORMAT).append(LIMIT);
				urlBuilder.append(DETAILS).append(REF_EMAIL);
			}

			GenericUrl url = new GenericUrl(urlBuilder.toString());
			HttpRequest request = requestFactory.buildGetRequest(url);

			HttpResponse resp = request.execute();
			String parse = resp.parseAsString();

			// prepare gson instance
			final GsonBuilder gsonBuilder = new GsonBuilder();
			gsonBuilder.registerTypeAdapter(BoundingBox.class,
					new BoundingBoxDeserializer());

			Gson gson = gsonBuilder.create();
			JsonParser parser = new JsonParser();
			JsonArray jArray = parser.parse(parse).getAsJsonArray();

			for (JsonElement obj : jArray) {
				OpenStreetMap oSM = gson.fromJson(obj, OpenStreetMap.class);
				Place place = new Place(oSM, state);
				return place;
			}

		} catch (Exception e) {
			log.error("Error getting Place from " + GEOCODE_REQUEST_URL, e);
		}
		return null;
	}
}
