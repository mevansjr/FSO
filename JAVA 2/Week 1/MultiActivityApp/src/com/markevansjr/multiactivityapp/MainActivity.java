package com.markevansjr.multiactivityapp;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;

public class MainActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    
    // Calls Activity 2
    public void callSecondActivity(View v)
    {
    	Intent intent = new Intent(getApplicationContext(), com.markevansjr.multiactivityapp.SecondActivity.class); 
    	startActivity(intent);
    }
    
    // Calls Activity 3
    public void callThirdActivity(View v)
    {
    	Intent intent = new Intent(getApplicationContext(), com.markevansjr.multiactivityapp.ThirdActivity.class); 
    	startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
