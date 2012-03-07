// Mark Evans
// AVF 1203
// Native Code - iOS / Android - Phonegap

//Geolocation Native Code --------------
//
//         onSuccess Callback
//           This method accepts a `Position` object, which contains
//           the current GPS coordinates

                var map;
                
                $(document).ready(function(){
                                  $(window).unbind();
                                  $(window).bind('pageshow resize orientationchange', function(e){
                                                 max_height();
                                                 });
                                  google.load("maps", "3.5", {"callback": map, other_params: "sensor=true&language=en"});
                                  });
                
                function max_height(){
                    var h = $('div[data-role="header"]').outerHeight(true);
                    var f = $('div[data-role="footer"]').outerHeight(true);
                    var w = $(window).height();
                    var c = $('div[data-role="content"]');
                    var c_h = c.height();
                    var c_oh = c.outerHeight(true);
                    var c_new = w - h - f - c_oh + c_h;
                    var total = h + f + c_oh;
                    if(c_h<c.get(0).scrollHeight){
                        c.height(c.get(0).scrollHeight);
                    }else{
                        c.height(c_new);
                    }
                }
                
                function map(){
                    var latlng = new google.maps.LatLng(39.37, 23.76);
                    var myOptions = {
                        zoom: 6,
                        center: latlng,
                        streetViewControl: true,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    map = new google.maps.Map(document.getElementById("map"), myOptions);
                    
                    navigator.geolocation.getCurrentPosition(geo_success, geo_error, { maximumAge: 3000, timeout: 5000, enableHighAccuracy: true });
                }
                
                function geo_error(error) {
                    alert('code: '    + error.code    + '\n' +
                          'message: ' + error.message + '\n');
                }
                
                function geo_success(position) {
                    map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
                    map.setZoom(15);
                    
                    var info =
                    ('Latitude: '         + position.coords.latitude          + '<br>' +
                     'Longitude: '         + position.coords.longitude         + '<br>' +
                     'Altitude: '          + position.coords.altitude          + '<br>' +
                     'Timestamp: '         + new Date(position.timestamp));
                    
                    var point = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    var marker = new google.maps.Marker({
                                                        position: point,
                                                        map: map
                                                        });
                    var infowindow = new google.maps.InfoWindow({
                                                                content: info
                                                                });
                    google.maps.event.addListener(marker, 'click', function() {
                                                  infowindow.open(map,marker);
                                                  });
                    
                };

        
//Notification Native Code ------------
        
        // Wait for PhoneGap to load
        //
        document.addEventListener("deviceready", onDeviceReady, false);
        
        // PhoneGap is ready
        //
        function onDeviceReady() {
            // Empty
        }
        
        // Show a custom alert
        //
        function showAlert() {
            navigator.notification.alert("Blah! This is an Alert.");
        }
        
        // Beep three times
        //
        function playBeep() {
            navigator.notification.beep(3);
        }
        
        // Vibrate for 2 seconds
        //
        function vibrate() {
            navigator.notification.vibrate(2000);
        }
        
//Camera Native Code ----------------

        function captureSuccess(mediaFiles) {
            navigator.notification.alert('Success taking picture:');
        }
        function captureError(mediaFiles) {
            navigator.notification.alert('Error taking picture: ' + error.code);
        }
        $(document).bind("deviceready",function () {
                         $("#takePhotoButton").bind("tap", function() {
                                                    navigator.device.capture.captureImage(captureSuccess, captureError, {limit: 1});
                                                    });
                         });
                         
//Contact Native Code ----------------

        // Wait for PhoneGap to load
        //
        document.addEventListener("deviceready", onDeviceReady, false);
        
        // PhoneGap is ready
        //
        function onDeviceReady() {
            // specify contact search criteria
            var options = new ContactFindOptions();
            options.filter=""; // empty search string returns all contacts
            options.multiple=true; // return multiple results
            filter = ["displayName"]; // return contact.displayName field
            
            // find contacts
            navigator.contacts.find(filter, onSuccess, onError, options);
        }
        
        // onSuccess: Get a snapshot of the current contacts
        //
        function onSuccess(contacts) {
            for (var i=0; i<contacts.length; i++) {
                    var getListdiv = document.getElementById("list");
                    var newDiv = document.createElement("li");
                    var newPara = document.createElement("p");
                    var itemTxt = document.createTextNode(contacts[i].displayName);
                    newPara.appendChild(itemTxt);
                    newDiv.appendChild(newPara);
                    getListdiv.appendChild(newDiv);
            }
        };
