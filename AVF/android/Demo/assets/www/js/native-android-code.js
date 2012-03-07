// Native Android code --------------------
	
	var video = document.getElementById('vid1');
				video.addEventListener('click',function(){
  				video.play();
			},false);


    // Wait for PhoneGap to load
    //
    document.addEventListener("deviceready", onDeviceReady, false) {

    // PhoneGap is ready
    //
    function onDeviceReady() {
        navigator.geolocation.getCurrentPosition(onSuccess, onError);
    }

    // onSuccess Geolocation
    //
    function onSuccess(position) {
        var element = document.getElementById('geolocation');
        element.innerHTML = 'Latitude: '           + position.coords.latitude              + '<br />' +
                            'Longitude: '          + position.coords.longitude             + '<br />' +
                            'Altitude: '           + position.coords.altitude              + '<br />' +
                            'Accuracy: '           + position.coords.accuracy              + '<br />' +
                            'Altitude Accuracy: '  + position.coords.altitudeAccuracy      + '<br />' +
                            'Heading: '            + position.coords.heading               + '<br />' +
                            'Speed: '              + position.coords.speed                 + '<br />' +
                            'Timestamp: '          + new Date(position.timestamp)          + '<br />';
    }

    // onError Callback receives a PositionError object
    //
    function onError(error) {
        alert('code: '    + error.code    + '\n' +
              'message: ' + error.message + '\n');
    }
	}

                
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

                // Wait for PhoneGap to load
                //
                document.addEventListener("deviceready", onDeviceReady, false);
                
                // PhoneGap is ready
                //
            function addContact(){
                var sample_contact = { 'firstName': 'John', 'lastName' : 'Smith', 'phoneNumber': '555-5555' };
                
                var firstName = prompt("Enter a first name", sample_contact.firstName);
                if (firstName) {
                    var lastName = prompt("Enter a last name", sample_contact.lastName);
                    if (lastName) {
                        var phoneNumber = prompt("Enter a phone number", sample_contact.phoneNumber);
                        if (phoneNumber) {
                            sample_contact = { 'firstName': firstName, 'lastName' : lastName, 'phoneNumber' : phoneNumber };
                            navigator.contacts.newContact(sample_contact, addContact_Return);
                        }
                    }
                }
            }
            
            function addContact_Return(contact)
            {
                if (contact) {
                    navigator.notification.alert(contact.firstName + " " + contact.lastName, "Contact Returned", "Dismiss");
                }
            }
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
                
                // onError: Failed to get the contacts
                //
                function onError(contactError) {
                    navigator.notification.alert('onError!');
                }
   