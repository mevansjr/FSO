// Mark Evans
// AVF 1203
// Native Code - iOS / Android - Phonegap
//Geolocation Native Code --------------
//
//         onSuccess Callback
//           This method accepts a `Position` object, which contains
//           the current GPS coordinates
        var onSuccess = function(position) {
            var getdiv = document.getElementById("spot");
            var newli  = document.createElement("li");
            var newli2 = document.createElement("li");
            var newli3 = document.createElement("li");
            var geolat = document.createTextNode('Latitude: '+ position.coords.latitude + '\n');
            console.log(position.coords.latitude);
            var geolon = document.createTextNode('Longitude: '+ position.coords.longitude + '\n');
            console.log(position.coords.longitude);
            var geotim = document.createTextNode('Timestamp: '+ new Date(position.timestamp) + '\n');
            newli.appendChild(geolat);
            getdiv.appendChild(newli);
            newli2.appendChild(geolon);
            getdiv.appendChild(newli2);
            newli3.appendChild(geotim);
            getdiv.appendChild(newli3);
        };      
         //onError Callback receives a PositionError object
        function onError(error) {
            alert('code: '    + error.code    + '\n' +
                  'message: ' + error.message + '\n');
        }
       navigator.geolocation.getCurrentPosition(onSuccess, onError, { maximumAge: 8000, timeout: 10000, enableHighAccuracy: true });
//       
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