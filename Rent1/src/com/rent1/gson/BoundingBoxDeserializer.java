package com.rent1.gson;

import java.lang.reflect.Type;

import org.apache.commons.logging.impl.Log4JLogger;

import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.rent1.json.model.BoundingBox;

public final class BoundingBoxDeserializer implements JsonDeserializer<BoundingBox> {

    /** The event logger. */
	private static final Log4JLogger log = new Log4JLogger(
			BoundingBoxDeserializer.class.getName());
    /**
* {@inheritDoc}
*
* @see com.google.gson.JsonDeserializer#deserialize(com.google.gson.JsonElement,
* java.lang.reflect.Type, com.google.gson.JsonDeserializationContext)
*/
    @Override
    public BoundingBox deserialize(final JsonElement json, final Type typeOfT,
            final JsonDeserializationContext context) {

        final BoundingBox bbox;

        if (json.isJsonArray()) {
            final JsonArray bboxJsonArray = json.getAsJsonArray();
            bbox = new BoundingBox();
            bbox.setSouth(bboxJsonArray.get(0).getAsDouble());
            bbox.setNorth(bboxJsonArray.get(1).getAsDouble());
            bbox.setWest(bboxJsonArray.get(2).getAsDouble());
            bbox.setEast(bboxJsonArray.get(3).getAsDouble());
        } else {
            throw new JsonParseException("Unexpected data: " + json.toString());
        }

        return bbox;
    }
}
