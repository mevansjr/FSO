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
        
        //TextView tv = (TextView) findViewById(R.id.textView2);
        //Log.i("TEST", getIntent().getExtras().getString("thetext2"));
        //String passedString = getIntent().getExtras().getString("thetext2");
        //tv.setText(passedString);
    }
    
    // Calls Main Activity
    public void callMainActivity(View v) {
    	finish();
	}

}
