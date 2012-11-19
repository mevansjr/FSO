package com.markevansjr.multiactivityapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class SecondActivity extends Activity 
{
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
    }
    
    // Calls Main Activity
    public void callMainActivity(View v) {
    	finish();
	}

}
