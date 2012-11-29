package com.markevansjr.fragmentapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.res.Configuration;
import android.graphics.Color;
import android.os.Bundle;
import android.webkit.WebView;

public class WebViewActivity extends Activity {
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
			String s = extras.getString("url");
			WebView webView = (WebView) findViewById(R.id.webView);
			webView.loadUrl(s);
			webView.setBackgroundColor(Color.DKGRAY);
			webView.getSettings().setJavaScriptEnabled(true);
			webView.getSettings().setLoadWithOverviewMode(true);
			webView.getSettings().setUseWideViewPort(true);
			webView.setScrollBarStyle(WebView.SCROLLBARS_OUTSIDE_OVERLAY);
			webView.setScrollbarFadingEnabled(false);
		}
	}

}
