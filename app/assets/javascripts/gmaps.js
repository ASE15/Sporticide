function set_map(location){
    var mapOptions = {
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

        address = location

    var geocoder = new google.maps.Geocoder();

    geocoder.geocode({
            'address':address
        },

        function(result, status){
            if (status == google.maps.GeocoderStatus.OK){
                map.setCenter(result[0].geometry.location);

                var marker = new google.maps.Marker({
                    map: map,
                    position: result[0].geometry.location
                });
            }else{
                alert("Geocode was not successful for the following reason: " + status);
            }
        });
    return false;
}

