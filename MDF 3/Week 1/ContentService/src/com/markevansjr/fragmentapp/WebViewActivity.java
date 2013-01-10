package com.markevansjr.fragmentapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.widget.TextView;

public class WebViewActivity extends Activity {
	
	String _s;
	
	@SuppressLint("SetJavaScriptEnabled")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
			finish();
			
			return;
		}

		setContentView(R.layout.webview_activity);
		
		//Passed URL from MainFragment
		Bundle extras = getIntent().getExtras();
		if (extras != null) {
			_s = extras.getString("url");
			TextView tv = (TextView) findViewById(R.id.text_view_10);
			tv.setText(_s);
		}
	}
	
	 @Override
	 protected void onActivityResult(int requestCode, int resultCode, Intent data) {
	  super.onActivityResult(requestCode, resultCode, data);
	  if(resultCode==RESULT_OK && requestCode==1){
	   String returned = data.getStringExtra("url");
	   Intent intent = new Intent(getApplicationContext(), MainActivity.class);
	   intent.putExtra("rurl", returned);
	   setResult(RESULT_OK, intent);
	   finish();
	  }
	 }

}
