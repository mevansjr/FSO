package com.markevansjr.multiactivityapp;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

public class SecondActivity extends Activity 
{
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        
        TextView tv = (TextView) findViewById(R.id.textView1);
        Log.i("TEST", getIntent().getExtras().getString("search_text"));
        String passedString = getIntent().getExtras().getString("search_text");
        tv.setText("Searched: "+passedString);
        setTitle("Recipe: "+passedString);
    }
    
    // Calls Activity 3
    public void callThirdActivity(View v)
    {
    	String passedString = getIntent().getExtras().getString("search_text");
    	
    	Intent intent = new Intent(Intent.ACTION_VIEW,
		Uri.parse("http://punchfork.com/recipes/"+passedString));
    	startActivity(intent);
    }
    
    // Calls Main Activity
    public void callMainActivity(View v) {
    	finish();
	}

}
