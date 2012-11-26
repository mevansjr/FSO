package com.markevansjr.multiactivityapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class ThirdActivity extends Activity 
{
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_third);
    }
    
    // Calls Main Activity
    public void callMainActivity(View v) {
    	finish();
	}

}
