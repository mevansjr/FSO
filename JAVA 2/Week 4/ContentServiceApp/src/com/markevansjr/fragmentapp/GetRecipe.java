package com.markevansjr.fragmentapp;

import java.net.MalformedURLException;
import java.net.URL;

import android.app.Activity;
import android.app.IntentService;
import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.os.Messenger;
import android.util.Log;

public class GetRecipe extends IntentService {

	private int _result;
	String _response = null;
	
	public GetRecipe(String search) {
		super(search);
		String apiURL = "http://api.punchfork.com/recipes?key=13c42c860b3e65ae&q="+search+"&count=50";
		URL finalURL = null;
		
		try{
			finalURL = new URL(apiURL);
			_response = WebStuff.getURLStringResponse(finalURL);
			if(_response.length() > 0) _result = Activity.RESULT_OK;
		} catch (MalformedURLException e){
			Log.e("BAD URL", "MALFORMED URL");
			finalURL = null;
		}
	}
	  
	 @Override
	    protected void onHandleIntent(Intent intent) {
		  
		Bundle extras = intent.getExtras();
	    if (extras != null) {
	    	Messenger messenger = (Messenger) extras.get("MESSENGER");
	    	Message msg = Message.obtain();
	    	msg.arg1 = _result;
	    	msg.obj = _response;
	    	try {
	    		messenger.send(msg);
	    	} catch (android.os.RemoteException e1) {
	    		Log.w(getClass().getName(), "Exception sending message", e1);
	    	}
	    }
	}
	
} 
