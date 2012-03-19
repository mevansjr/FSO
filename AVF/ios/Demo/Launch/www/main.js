// Mark Evans
// Full Sail University
// Mobile Development Program
// ASD 1202

// PHONEGAP CAMERA CODE---------------------------
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
// GET ITEMS FUNCTION-----------------------------
function getItems(){
	for(var i=0, len = localStorage.length; i < len; i++){
		var key = localStorage.key(i);
		var value = localStorage.getItem(key);
		value = value.split(',');
		var name = value[0];
		var college = value[1];
		var sport = value[2];
		var speed = value[3];
		var rating = value[4];
		//console.log("Player ID: "+key);
		var sportImage = "sc-icon.png"; 
		//NEW CODE - JQUERY (REMOVED MANUAL DOM CODE)	
		/*$('#list').append($('<h2>').text(value[0]))
			 		.append($('<h3>').text(value[1]))
			 		.append($('<p>').html("<strong>Speed: </strong>" + value[3] + " seconds"))
			 		.append($('<p>').html("<strong>Sport: </strong>" + value[2]))
			 		.append($('<p>').html("<strong>Rating: </strong>" + value[4]))
			 		.append($('<img>').attr("src", "images/"+sportImage).attr("alt", ""))
			 		.append($('<p>').text(" "))
			 		.append($("<a>").attr( "href", "#").attr("onclick", "deleteItem(" + key + ");").attr("data-role", "button").attr("data-icon", "delete").text("Delete").attr("data-theme", "c").attr("data-inline", "true"))
			 		.append($("<a>").attr( "href", "#").attr("onclick", "editItem(" + key + ");").attr("data-role", "button").attr("data-icon", "gear").text("Edit Info").attr("data-theme", "b").attr("data-inline", "true")
			 	);*/
                var navbar = "<div id='tabbar'>"+
                                "<div id='bottom'>"+
                                    "<a href='#' onclick='takePic();'>Camera</a>"+
                                    "<a href='map.html' rel='external'>Map</a>"+
                                    "<a href='#mostpg'>List</a>"+
                                    "<a href='#addplayer'>Add</a>"+
                			  "</div>"+
                            "</div>";
			 	$('#body').append(
			 		$('<div>').attr("data-role","page").attr("data-theme", "a").attr("id", value[0]).append(
			 		$('<div>').attr("data-role","header").attr("id", "header-new").attr("data-theme", "a").html("<div style='float:left; margin:8px -30px 8px 8px;'><a href='index.html' data-role='button' data-icon='home' data-iconpos='notext'>Button</a></div><h1 id=fix-h1>Scouting Inc</h1>")).append(
			 		$('<div>').attr("data-role", "content").attr("id", "playercontent").attr("class", "adjust").append(
			 			$('<img>').attr("id", "myImage").attr("src", "../CRUD/images/default.png").attr("style", "border:3px solid #fff")).append(
                        $('<p>').html("<h3>"+value[0]+"</h3>"))
			 				.append($('<p>').html(value[1]))
			 		 		.append($('<p>').html("<strong>Speed: </strong>" + value[3] + " seconds"))
					 		.append($('<p>').html("<strong>Sport: </strong>" + value[2]))
	 				 		.append($('<p>').html("<strong>Rating: </strong>" + value[4]))
			 		 		//.append($('<p>').text(" "))
					 		.append($('<a>').attr( "href", "#").attr("onclick", "editItem(" + key + ");").attr("data-role", "button").attr("data-icon", "gear").text("Edit Info").attr("data-theme", "c").attr("data-inline", "true"))
                            .append($('<a>').attr( "href", "#").attr("onclick", "takePic();").attr("data-role", "button").attr("data-icon", "star").text("Take Pic").attr("data-theme", "c").attr("data-inline", "true"))
                            .append($('<a>').attr( "href", "#").attr("onclick", "getPhoto(pictureSource.SAVEDPHOTOALBUM);").attr("data-role", "button").attr("data-icon", "grid").text("Find Pic").attr("data-theme", "b").attr("data-inline", "false").attr("class", "adj")
			 		)
			 	).append(
                    $('<div>').html(navbar))                                                                                                                                       
                );
			 	
			 	$('#dynamic').append(
			 		$('<li>').append(
			 			$('<a>').attr("href", "#"+value[0])
			 			.html('<img src="images/'+sportImage+'" />'+
			 				  '<h3>'+value[0]+'</h3>'+
			 				  '<p>'+value[1]+'</p>'
			 				  )
			 		).append($("<a>").attr( "href", "#").attr("onclick", "deleteItem(" + key + ");").attr("data-role", "button").attr("data-icon", "delete").text("Delete").attr("data-theme", "a").attr("data-inline", "true"))
			 	);
			 	
			 	// CLEAR LOCAL STORAGE EVENT----------------------------
			 	$('#clear').bind('click', function(){
			 		localStorage.clear();
			 		location.reload();
			 		return false;
			 	});
			 	
		}
}
// SAVE ITEMS FUNCTION-----------------------------
function saveItems(id){
	var d = new Date();
    var key= (d.getTime());
    var name = $('#name').val();
    var college = $('#college').val();
    var sport = $('#sport').val();
    var speed = $('#speed').val();
    var rating = $('#rating').val();
	var allItems = [
		name,
		college,
		sport,
		speed,
		rating
	];
	localStorage.setItem(key, allItems);
	location.reload();
}
// EDIT ITEMS FUNCTION-----------------------------
function editItem(id){
	$.mobile.changePage("#addplayer");
	//alert("Loading Player ID: "+id);
	var itemId = id;
	var value = localStorage.getItem(itemId);
	value = value.split(',');
	var name = value[0];
	var college = value[1];
	var sport = value[2];
	var speed = value[3];
	var rating = value[4];
	console.log(itemId);
	$('#name').val(name);
	$('#college').val(college);
	$('#sport').val(sport);
	$('#speed').val(speed);
	$('#rating').val(rating);
	// SHOW EDIT BUTTON, HIDE SUBMIT-------------------
	var editButton = $('#edit-item-button').css('display', 'block');
	var subresButtons = $('#submit-reset-buttons').css('display', 'none');
	var itemList = $('#list').css('display', 'none');
	//WHEN CLICKING EDIT BUTTON------------------------
	function clickEdit(){
		var name = $('#name').val();
		var college = $('#college').val();
		var sport = $('#sport').val();
		var speed = $('#speed').val();
		var rating = $('#rating').val();
		var allItems = [
			name,
			college,
			sport,
			speed,
			rating
		];
		if(name != "" && name != "Name" && college != ""){
			localStorage.setItem(itemId, allItems);
			//alert("player Updated!");
			location.reload();
		}else{
			//alert("Name and College fields are required.");
		}
	};
	$('#edit-item').bind('click', clickEdit);
}

// DELETE ITEM FUNCTION --------------------------------
function deleteItem(id){
	var ask = confirm("Are you sure?");
	if(ask){
		localStorage.removeItem(id);
        //$.mobile.changePage("index.html");
		location.reload();
	}else{
		//alert("Player not removed.");
	}
}
// CLEAR INDEX BUTTON EVENT ----------------------------
$('#index-clear').bind('click', function(){
	location.reload();
	return false;
});
// HIDE EDIT BUTTON EVENT-------------------------------
$('#edit-item-button').css('display', 'none');
// VALIDATE FORM EVENT ---------------------------------
$('#submit').bind('click', function(){
	var getName = $('#name').val();
	var getCollege = $('#college').val();
    var getSport = $('#sport').val();
	if(getName == ""){ 
		$('#name').css('border', '3px solid yellow');
		return false;
	}
	if(getCollege == ""){
		$('#college').css('border', '3px solid yellow');
		return false;
    }
    if(getSport == ""){
        $('#sport').css('border', '3px solid yellow');
        return false;    
	}else{
		$('#name').css('border', '1px solid #ccc');
		$('#college').css('border', '1px solid #ccc');
        $('#sport').css('border', '1px solid #ccc');
		//alert("Player Information has been stored.");
		saveItems(); 
        $.mobile.changePage("#mostpg");
	}
});
