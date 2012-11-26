package com.markevansjr.multiactivityapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;

public class ThirdActivity extends Activity 
{
    @SuppressLint("SetJavaScriptEnabled")
	@Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.webview);
        
        String passedString = getIntent().getExtras().getString("passedUrl");
        setTitle("Recipe Browser");
        
        WebView view = (WebView) findViewById(R.id.webView1);
        view.loadUrl(passedString);
        view.getSettings().setJavaScriptEnabled(true);
        view.getSettings().setLoadWithOverviewMode(true);
        view.getSettings().setUseWideViewPort(true);
        view.setScrollBarStyle(WebView.SCROLLBARS_OUTSIDE_OVERLAY);
        view.setScrollbarFadingEnabled(false);
    }
    
    // Calls Main Activity
    public void callMainActivity(View v) {
    	finish();
	}

}
