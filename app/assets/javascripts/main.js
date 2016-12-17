var map;
var infowindow;

//Creacion del mapa con los parametros de zonnn y declaracion de variables a utilizar
var initMap = function() {
  var map = new google.maps.Map(document.getElementById('map'),  {
    center: {lat: -34.397, lng: 150.644},
    zoom: 16
  });
  var infoWindow = new google.maps.InfoWindow({map: map});
  var geocoder = new google.maps.Geocoder();

  document.getElementById('submit').addEventListener('click', function() {
    geocodeAddress(geocoder, map);
  });
  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      infoWindow.setPosition(pos);
      infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }
};//end of initMap


function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
    'Error: The Geolocation service failed.' :
    'Error: Your browser doesn\'t support geolocation.');
}//end of handleLocationError


  //funcion que me permite geolocalizar la direccion
function geocodeAddress(geocoder, resultsMap) {
  var address = document.getElementById('address').value;
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      resultsMap.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location,
        draggable:true
      });
      google.maps.event.addListener(marker, 'dragend', function(evt){
        latitude.value = evt.latLng.lat().toFixed(3);
        longitude.value = evt.latLng.lng().toFixed(3);
      });
      var lng = results[0].geometry.location.lng();
      var lat = results[0].geometry.location.lat();
      latitude.value = lat;
      longitude.value = lng;
      console.log("longitude : ",lng ,"latitude : ", lat);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}//geocodeAddress

document.addEventListener("DOMContentLoaded", function(){
  var longitude = document.querySelector("#longitude");
  var latitude = document.querySelector("#latitude");
  console.log(longitude, latitude);
  var gmap = document.getElementById('map');
  if(gmap){
    console.log(gmap);
    initMap();
  }

});//addEventListener
