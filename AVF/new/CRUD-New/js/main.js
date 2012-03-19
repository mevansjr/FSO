// Mark Evans
// Full Sail University
// Mobile Development Program
// ASD 1202

// PHONEGAP CAMERA CODE---------------------------
function captureSuccess(mediaFiles) {
    navigator.notification.alert('Player photo saved!');
}
function captureError(mediaFiles) {
    navigator.notification.alert('Error: ' + error.code);
}
$(document).bind("deviceready",function () {
    $("#takePhotoButton").bind("tap", function() {
        navigator.device.capture.captureImage(captureSuccess, captureError, {limit: 1});
    });
});
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
                var navbar = "<div data-role=navbar class=custom>"+
                                "<ul>"+
                                    "<li><a href=index.html rel=external id=iconpic><center><img src=images/custom-home.png /></center></a></li>"+
                                    "<li><a href=index.html#about rel=external id=iconpic><center><img src=images/custom-about.png /></center></a></li>"+
                                    "<li><a href=index.html#mostpg rel=external id=iconpic><center><img src=images/custom-add.png /></center></a></li>"+
                                    "<li><a href=index.html#addplayer rel=external id=iconpic><center><img src=images/custom-addplayer.png /></center></a></li>"+
                                "</ul>"+
                            "</div>";
			 	$('#body').append(
			 		$('<div>').attr("data-role","page").attr("data-theme", "a").attr("data-add-back-btn", "true").attr("id", value[0]).append(
			 		$('<div>').attr("data-role","header").attr("id", "head-fix").attr("data-theme", "a").html("<h1 id=header-fix>Scouting Inc</h1>")).append(
			 		$('<div>').attr("data-role", "content").attr("id", "playercontent").append(
			 			$('<img>').attr("src", "images/default.png")).append(
                        $('<p>').html("<h3>"+value[0]+"</h3>"))
			 				.append($('<p>').html(value[1]))
			 		 		.append($('<p>').html("<strong>Speed: </strong>" + value[3] + " seconds"))
					 		.append($('<p>').html("<strong>Sport: </strong>" + value[2]))
	 				 		.append($('<p>').html("<strong>Rating: </strong>" + value[4]))
			 		 		//.append($('<p>').text(" "))
					 		.append($("<a>").attr( "href", "#").attr("onclick", "editItem(" + key + ");").attr("data-role", "button").attr("data-icon", "gear").text("Edit Info").attr("data-theme", "c").attr("data-inline", "true")
			 		)
			 	).append(
                    $('<div>').attr("data-role","footer").attr("data-position", "fixed").attr("data-theme", "a").html(navbar))                                                                                                                                       
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
        $.mobile.changePage("index.html#mostpg");
	}
});
