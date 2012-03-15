//NETWORK CODE
function check_network() {
    var networkState = navigator.network.connection.type;
    
    var states = {};
    states[Connection.UNKNOWN]  = 'Unknown connection';
    states[Connection.ETHERNET] = 'Ethernet connection';
    states[Connection.WIFI]     = 'WiFi connection';
    states[Connection.CELL_2G]  = 'Cell 2G connection';
    states[Connection.CELL_3G]  = 'Cell 3G connection';
    states[Connection.CELL_4G]  = 'Cell 4G connection';
    states[Connection.NONE]     = 'No network connection';
    
    confirm('Connection type:\n ' + states[networkState]);
}

//ALERT CODE
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


//PICTURE CODE
var pictureSource;   // picture source
var destinationType; // sets the format of returned value 

// Wait for PhoneGap to connect with the device
//
document.addEventListener("deviceready",onDeviceReady,false);

// PhoneGap is ready to be used!
//
function onDeviceReady() {
    pictureSource=navigator.camera.PictureSourceType;
    destinationType=navigator.camera.DestinationType;
}



// Called when a photo is successfully retrieved
//
function onPhotoURISuccess(imageURI) {
    // Uncomment to view the image file URI 
    // console.log(imageURI);
    
    // Get image handle
    //
    var largeImage = document.getElementById('myImage');
    
    // Unhide image elements
    //
    largeImage.style.display = 'block';
    
    // Show the captured photo
    // The inline CSS rules are used to resize the image
    //
    largeImage.src = imageURI;
}


// A button will call this function
//
function getPhoto(source) {
    // Retrieve image file location from specified source
    navigator.camera.getPicture(onPhotoURISuccess, onFail, { quality: 50, 
                                destinationType: destinationType.FILE_URI,
                                sourceType: source });
}

// Called if something bad happens.
// 
function onFail(message) {
    alert('Failed because: ' + message);
}

function captureSuccess(mediaFiles) {
    navigator.notification.alert('Success taking picture');
}
function captureError(mediaFiles) {
    navigator.notification.alert('Error taking picture: ' + error.code);
}
function takePic() {
    navigator.device.capture.captureImage(captureSuccess, captureError, {limit: 1});
}

//CONTACTS CODE
function contacts_success(contacts) {
    alert(contacts.length
          + ' contacts returned.'
          + (contacts[2] && contacts[2].name ? (' Third contact is ' + contacts[2].name.formatted)
             : ''));
}

function get_contacts() {
    var obj = new ContactFindOptions();
    obj.filter = "";
    obj.multiple = true;
    navigator.contacts.find(
                            [ "displayName", "name" ], contacts_success,
                            fail, obj);
}
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
    
//Code for Android phone - HTML 5 Video
var video = document.getElementById('vid1');
video.addEventListener('click',function(){
  video.play();
},false);
var vid = document.getElementById('vid2');
vid.addEventListener('click',function(){
  vid.play();
},false);
var video3 = document.getElementById('vid3');
video3.addEventListener('click',function(){
  video3.play();
},false);