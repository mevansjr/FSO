//collapse page navs after use
$(function(){
	$('body').delegate('.content-secondary .ui-collapsible-content', 'click',  function(){
		$(this).trigger("collapse")
	});
});

function setDefaultTransition(){
	var winwidth = $( window ).width(),
		trans ="slide";
		
	if( winwidth >= 1000 ){
		trans = "none";
	}
	else if( winwidth >= 650 ){
		trans = "fade";
	}

	$.mobile.defaultPageTransition = trans;
}


$(function(){
	setDefaultTransition();
	$( window ).bind( "throttledresize", setDefaultTransition );
});

$(document).ready(function(){

	$("#week1video").jPlayer({
		ready: function () {
			$(this).jPlayer("setMedia", {
				m4v: "http://dl.dropbox.com/u/11686909/AVF%20-%20Video%201.m4v",
				poster: "https://dl-web.dropbox.com/get/Photos/videoposter.png?w=dd626a6a"
			}).jPlayer("stop");
		},
		ended: function (event) {
			$(this).jPlayer("stop");
		},
		swfPath: "js",
		supplied: "m4v"
	})

});

function videoOS(){
	var ua = navigator.userAgent.toLowerCase();
	var isAndroid = ua.indexOf("android") > -1; //&& ua.indexOf("mobile");
	if(isAndroid) {
	  document.location.href = 'index.html#1-html5video-droid';
	}else{
		document.location.href = 'index.html#1-html5video';
	}
}

function videolink(){
	var winwidth = $( window ).width();	
	if( winwidth <= 479 ){
		document.location.href = 'http://dl.dropbox.com/u/11686909/AVF%20-%20Video%201.m4v';
	}
	else if( winwidth >= 480 ){
		document.location.href = 'index.html#1-video';
	}
}