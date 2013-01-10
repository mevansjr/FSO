package com.markevansjr.appintegration;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class Webview extends Activity {
	
	WebView _web;
	
	@SuppressLint("SetJavaScriptEnabled")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		//SET FULLSCREEN
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		setContentView(R.layout.webview);
		
		//SET ORIENTATION
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		
		_web = (WebView) findViewById(R.id.webview2);
		
		Intent intent = getIntent();
		String url = intent.getStringExtra("data");
		_web.loadUrl(url);
		WebSettings webSettings = _web.getSettings();
		webSettings.setJavaScriptEnabled(true);
		webSettings.setSupportZoom(true);
		webSettings.getJavaScriptCanOpenWindowsAutomatically();
		
		Log.i("TAG WEBADDRESS", url);
	}
}