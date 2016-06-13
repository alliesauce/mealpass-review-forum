$(window).load(function() {
  loadScript()
  $(".dropdown-toggle").dropdown();
  // console.log('jquery');
});


function initMap() {
  // var center = new google.maps.LatLng(40.739828, -73.990093)
  var lat = document.getElementById("lat").value;
  var lng = document.getElementById("lng").value;
  var label = document.getElementById("name").value;
  // debugger
  var center = new google.maps.LatLng(lat, lng)
  var mapOptions = {
    center: center,
    zoom: 15
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var marker = new google.maps.Marker({
      position: center,
      map: map,
      label: label.to_s
    });
}

function loadScript() {
  console.log("map loading ...");
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?key={{google_key}}&callback=initMap';
  document.body.appendChild(script);
}



