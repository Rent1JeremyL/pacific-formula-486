// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.
var autocomplete;

function initialize_locate() {
	// Create the autocomplete object, restricting the search
	// to geographical location types.
	autocomplete = new google.maps.places.Autocomplete(
	/** @type {HTMLInputElement} */
	(document.getElementById('location')), {
		types : [ 'geocode' ]
	});
}

// The START and END in square brackets define a snippet for our
// documentation:

// [START region_geolocation]
// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var geolocation = new google.maps.LatLng(position.coords.latitude,
					position.coords.longitude);
			autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
					geolocation));
		});
	}
}
// [END region_geolocation]