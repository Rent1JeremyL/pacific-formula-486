// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.
var autocomplete;

function initialize_sbar() {
	// Create the autocomplete object, restricting the search
	// to geographical location types.
	autocomplete = new google.maps.places.Autocomplete(
	/** @type {HTMLInputElement} */
	(document.getElementById('location')), {
		types : [ '(cities)' ]
	});
	// When the user selects an address from the dropdown,
	// populate the address fields in the form.
	// google.maps.event.addListener(autocomplete, 'place_changed', function() {
	// fillInAddress();
	// });
}

// The START and END in square brackets define a snippet for our
// documentation:
// The START and END in square brackets define a snippet for our
// documentation:
// [START region_fillform]
function fillInAddress() {
	// Get the place details from the autocomplete object.
	var place = autocomplete.getPlace();

	for ( var component in locationArray) {
		document.getElementById(component).value = '';
		document.getElementById(component).disabled = false;
	}

	// Get each component of the address from the place details
	// and fill the corresponding field on the form.
	/**
	 * for (var i = 0; i < place.address_components.length; i++) { var
	 * addressType = place.address_components[i].types[0]; if
	 * (componentForm[addressType]) { var val =
	 * place.address_components[i][componentForm[addressType]];
	 * document.getElementById(addressType).value = val; } }
	 */
	// var address = '';
	// if (place.address_components) {
	if (1 == 1) {
		var val = place.address_components[0];
		document.getElementById("loc_city").value = 'Hellow W';
	}
	/**
	 * address = [ (place.address_components[0] &&
	 * place.address_components[0].short_name || ''),
	 * (place.address_components[1] && place.address_components[1].short_name ||
	 * ''), (place.address_components[2] &&
	 * place.address_components[2].short_name || '') ].join(' ');
	 */
}
// [END region_fillform]

// [START region_geolocation]
// Bias the autocomplete object to Canada
function geolocate() {
	// Hard code for Canada
	var geolocation = new google.maps.LatLng(62, -110.0);
	autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
			geolocation));
}
// [END region_geolocation]

// [START Web.xml Servlet re-direct]
function servletPost(xx) {
	$.ajax({
		type : "POST",
		url : "/" + xx
	});
	return false;
}
// [END Web.xml Servlet re-direct]