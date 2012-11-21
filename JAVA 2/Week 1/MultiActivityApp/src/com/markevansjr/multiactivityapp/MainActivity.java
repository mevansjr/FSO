package com.markevansjr.multiactivityapp;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends Activity {

	Context _context;
	List<Map<String, String>> _data;
	JSONArray _results;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    
    // Calls Activity 2
    public void callSecondActivity(View v)
    {
    	EditText et = (EditText) findViewById(R.id.editText1);
        
    	// CALLS SEARCH
    	doSearch(et.getText().toString());
    	
    	Intent intent = new Intent(getApplicationContext(), SecondActivity.class); 
    	intent.putExtra("search_text", et.getText().toString());
    	startActivity(intent);
    }
    
    @SuppressWarnings("unused")
	private void doSearch(String item){
		String apiURL = "http://api.punchfork.com/recipes?key=13c42c860b3e65ae&q="+item+"&count=3";
		String qs;
		try{
			qs = URLEncoder.encode(apiURL, "UTF-8");
		} catch (Exception e){
			Log.e("BAD URL", "ENCODING PROBLEM");
			qs = "";
		}
		URL finalURL;
		try{
			finalURL = new URL(apiURL);
			RecipeRequest rr = new RecipeRequest();
			rr.execute(finalURL);
		} catch (MalformedURLException e){
			Log.e("BAD URL", "MALFORMED URL");
			finalURL = null;
		}
	}
	
	private class RecipeRequest extends AsyncTask<URL, Void, String>{
		@Override
		protected String doInBackground(URL... urls){
			String response = "";
			for(URL url: urls){
				response = WebStuff.getURLStringResponse(url);
			}
			return response;
		}
		
		@Override
		protected void onPostExecute(String result){
			Log.i("URL RESPONSE", result);
			try{
				JSONObject json = new JSONObject(result);
				_results = json.getJSONArray("recipes");
				
				_data = new ArrayList<Map<String, String>>();
			
		        for(int i=0;i<_results.length();i++){							
					JSONObject s = _results.getJSONObject(i);
					Map<String, String> map = new HashMap<String, String>(2);
					map.put("title", s.getString("title"));
				    map.put("source_name", s.getString("source_name"));
				    map.put("source_url", s.getString("source_url"));
				    _data.add(map);
				}
				Log.i("THE RESULTS", _results.toString());
				
				
			} catch (JSONException e){
				Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
		}
    
	}

}
