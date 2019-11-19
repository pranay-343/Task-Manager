<html>
<head>
<title>How to draw Path on Map using Google Maps Direction API</title>
<style>
#map-layer {
    max-width: 100%;
    min-height: 100%;
}
.lbl-locations {
    font-weight: bold;
    margin-bottom: 15px;
}
.locations-option {
    display:none;
    margin-right: 15px;
}
.btn-draw {
    background: green;
    color: #ffffff;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
</head>
<body>
    
    <?php
    foreach ($wayPoints as $wayPoint) {
    ?>
      <div class="locations-option"><input type="checkbox" name="way_points[]" class="way_points" value="<?php echo $wayPoint; ?>"> <?php echo $wayPoint; ?></div>
    <?php
    }
    ?>
    </div>
    
    <div id="map-layer"></div>
    <script>
        var map;
        var waypoints
        function initMap() {
                var mapLayer = document.getElementById("map-layer"); 
                var centerCoordinates = new google.maps.LatLng(28.6139, 77.2090);
                var defaultOptions = { center: centerCoordinates, zoom: 8 }
                map = new google.maps.Map(mapLayer, defaultOptions);
    
            var directionsService = new google.maps.DirectionsService;
            var directionsDisplay = new google.maps.DirectionsRenderer;
            directionsDisplay.setMap(map);
 
      
                    waypoints = Array();
                    $('.way_points').each(function() {
                    waypoints.push({
                        // location: ($(this).val()),
                        location: ($(this).val()),
                        stopover: true
                    });
                    });
                     console.log(waypoints);
                var locationCount = waypoints.length;
                if(locationCount > 0) {

                    var start = waypoints[0].location;
                    var end = waypoints[locationCount-1].location;
                    
                    drawPath(directionsService, directionsDisplay,start,end);
                }
        
            
        }
            function drawPath(directionsService, directionsDisplay,start,end) {
            directionsService.route({
              origin: start,
              destination: end,
              waypoints: waypoints,
              optimizeWaypoints: true,
              travelMode: 'DRIVING'
            }, function(response, status) {
                if (status === 'OK') {
                directionsDisplay.setDirections(response);
                } else {
                window.alert('Problem in showing direction due to ' + status);
                }
            });
      }
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=<?php echo API_KEY; ?>&callback=initMap">
    </script>
</body>
</html>