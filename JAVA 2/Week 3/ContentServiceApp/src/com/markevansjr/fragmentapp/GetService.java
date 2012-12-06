package com.markevansjr.fragmentapp;

import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONArray;
 
import android.app.Activity;
import android.app.IntentService;
import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.os.Messenger;
import android.util.Log;
 
public class GetService  extends IntentService{
    URL finalURL = null;
    int _result;
	String _response = null;
	JSONArray _results;
	String _passedItem = null;
 
    public GetService() {
        super("GetService");
    }
 
    @Override
    protected void onHandleIntent(Intent intent) {
    
    	Bundle extras = intent.getExtras();
        if (extras != null) {
        	_passedItem = (String) extras.get("item");
        	String responseString = "http://api.punchfork.com/recipes?key=13c42c860b3e65ae&q="+_passedItem+"&count=50";
            Log.i("onHandleIntent::", responseString);
            try{
    			finalURL = new URL(responseString);
    			_response = WebStuff.getURLStringResponse(finalURL);
    			if (_response.length() > 0) _result = Activity.RESULT_OK;
    		} catch (MalformedURLException e){
    			Log.e("BAD URL", "MALFORMED URL");
    			finalURL = null;
    		}
        	Messenger messenger = (Messenger) extras.get("messenger");
        	Message msg = Message.obtain();
        	msg.arg1 = _result;
        	msg.obj = _response;
        	Log.i("msg.obj::", msg.obj.toString());
        	try{
        		messenger.send(msg);
        	} catch (android.os.RemoteException e){
        		Log.e(getClass().getName(), "EXCEPTION sending message", e);
        	}
        } 
    }
}