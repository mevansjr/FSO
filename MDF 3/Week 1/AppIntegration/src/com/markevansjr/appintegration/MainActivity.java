package com.markevansjr.appintegration;

import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.webkit.WebView;
import android.widget.TextView;

public class MainActivity extends Activity {

	static final int URL_REQUEST = 1;
	TextView _tv;
	String _theurl;
	WebView _web;
	String _name;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		Log.i("TAG", "TAG1");
		Intent intent = getIntent();
		 
	    String action = intent.getAction();
	    Log.i("TAG", action);
	    
	    if (intent.hasExtra("passedData")){
	    	Log.i("TAG", "TAG1-a");
	    	Uri data1 = intent.getData();
		    
		    String name = data1.getPath();
		    _name = name.substring(1, name.length());
		    Log.i("TAG NAME", _name);
		    Intent i = new Intent(this, Webview.class);
		    i.putExtra("data", _name);
		    startActivity(i);
	    } else {
	    	Log.i("TAG", "TAG1-b");
	    }
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
	    // Check which request we're responding to
	    if (requestCode == URL_REQUEST) {
	        // Make sure the request was successful
	        if (resultCode == RESULT_OK) {
	        	Log.i("TAG", "TAG2");
	    	    String action = data.getAction();
	    	    Uri data1 = data.getData();
	    	    _theurl = data.getStringExtra("passedData");
	    	    
	    	    if (_theurl == null || _theurl.equals("") || _theurl == "" || _theurl.equals(null)){
	    	    	//_tv.setText(_theurl);
	    	    	Log.i("TAG", "TAG3");
	    	    } else {
	    	    	//_tv.setText("Something went wrong!");
	    	    	Log.i("TAG", "TAG4");
	    	    }
	    	 
	    	    String name = data1.getPath();
	    	    Log.i("TAG NAME", name);
	    	    Log.i("TAG ACTION", action);
	        }
	    }
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
}
