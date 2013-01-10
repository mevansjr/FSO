package com.markevansjr.appintegration;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class Webview extends Activity {
	
	WebView _web;
	
	@SuppressLint("SetJavaScriptEnabled")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.webview);
		
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