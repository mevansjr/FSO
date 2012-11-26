package com.markevansjr.multiactivityapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends Activity {

	Context _context;
	List<Map<String, String>> _data;
	JSONArray _results;
	ArrayList<String> _stringArray = new ArrayList<String>();
	Intent _intent;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    
    // Calls Activity 2
    public void callSecondActivity(View v)
    {
    	EditText et = (EditText) findViewById(R.id.editText1);
        
    	_intent = new Intent(getApplicationContext(), SecondActivity.class); 
    	_intent.putExtra("search_text", et.getText().toString());
    	if (et.getText().toString().equals("") || et.getText().toString() == null){
    		Toast.makeText(this, "You MUST type in a recipe!", Toast.LENGTH_LONG).show();
    	} else {
    		startActivity(_intent);
    	}
    }
    
    

}
