package com.markevansjr.addfriend;

import java.util.HashMap;

import com.parse.Parse;
import com.parse.ParseObject;

import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

@SuppressLint("SetJavaScriptEnabled")
public class MainActivity extends Activity {
	
	HashMap<String, String> _recents;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		Parse.initialize(this, "PV07xPdLpxzJKBKUS2UP6iJ0W9GbEHvmfPMMQovz", "OPxrcJKt4Pe26WHvCAeuI86hnGzXjOlO1NmyfJyP"); 
		
		WebView myWebView = (WebView) findViewById(R.id.webView1);
		myWebView.loadUrl("http://www.markevansjr.com/AndroidApp/index.html");
		
		WebSettings webSettings = myWebView.getSettings();
		webSettings.setJavaScriptEnabled(true);
		myWebView.addJavascriptInterface(new WebAppInterface(this), "Android");
		
		myWebView.setWebViewClient(new WebViewClient());
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
	    switch(item.getItemId()) {
	    case R.id.add:
	        //click on about item
	    	Log.i("TAG", "ADD");
	    	Intent i = new Intent(getApplicationContext(), AddFriend.class); 
			startActivity(i);
	        break;
	        
	    case R.id.home:
	        //click on about item
	    	Log.i("TAG", "HOME");
	    	Intent ii = new Intent(getApplicationContext(), MainActivity.class); 
			startActivity(ii);
	        break;
    	}
	    return true;
	}
	
	public class WebAppInterface {
	    Context mContext;

	    /** Instantiate the interface and set the context */
	    WebAppInterface(Context c) {
	        mContext = c;
	    }

	    /** Show a toast from the web page */
	    //@JavascriptInterface
	    public void showData(String[] data) {
	        Log.i("SHOW DATA", data[0]+"\n"+data[1]+"\n"+data[2]+"\n"+data[3]);
	        
	        String firstName = data[0];
	        String lastName = data[1];
	        String phoneNumber = data[2];
	        String emailAddress =data[3];
	        
	        if (data[0].equals("") || data[1].equals("") || data[2].equals("") || data[3].equals("")) {
	        	Toast toast = Toast.makeText(getApplicationContext(), "CHECK YOUR FIELDS", Toast.LENGTH_LONG);
				toast.show();
	        } else {
	        	ParseObject contactObject = new ParseObject("ContactObject");
	        	contactObject.put("fname", firstName);
	        	contactObject.put("lname", lastName);
	        	contactObject.put("phone", phoneNumber);
	        	contactObject.put("email", emailAddress);
	        	contactObject.saveInBackground();
	        
	        	Intent i = new Intent(mContext, AddFriend.class); 
				startActivity(i);
	        }
	    }
	  
	}
}
