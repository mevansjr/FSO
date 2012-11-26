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

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class SecondActivity extends Activity 
{
	Context _context;
	List<Map<String, String>> _data;
	JSONArray _results;
	ArrayList<String> _stringArray = new ArrayList<String>();
	Intent _intent;
	
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
    	
        String passedString = getIntent().getExtras().getString("search_text");
        setTitle("Recipe: "+passedString);
        
        // CALLS SEARCH
    	doSearch(passedString);
    }
    
    // Calls Activity 3
    public void callThirdActivity(View v)
    {
    	String passedString = getIntent().getExtras().getString("search_text");
    	//Uri theuri;
    	String theString;
    	
    	if (passedString == null || passedString.equals(""))
    	{
    		theString = "http://punchfork.com/";
    		//theuri = Uri.parse(theString);
    		//Log.i("URI", "http://punchfork.com/");
    	} else {
    		theString = "http://punchfork.com/recipes/"+passedString;
    		//theuri = Uri.parse(theString);
    		//Log.i("URI", "http://punchfork.com/recipes/"+passedString);
    	}
    	
//    	Intent intent = new Intent(Intent.ACTION_VIEW,
//		theuri);
//    	startActivity(intent);
    	
    	Intent intent = new Intent(getApplicationContext(), ThirdActivity.class); 
    	intent.putExtra("passedUrl", theString);
    	startActivity(intent);
    }
    
    @SuppressWarnings("unused")
	private void doSearch(String item){
		String apiURL = "http://api.punchfork.com/recipes?key=13c42c860b3e65ae&q="+item+"&count=50";
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
		        
		        final ListView lv = (ListView) findViewById(R.id.listView1);
		        
		        String[] from = new String[] {"title", "source_name", "source_url"};
		        int[] to = new int[] {android.R.id.text1, android.R.id.text2};

		        
		        SimpleAdapter adapter = new SimpleAdapter(getBaseContext(), _data, android.R.layout.simple_list_item_2, from, to);
				lv.setAdapter(adapter);
		        
				lv.setOnItemClickListener(new OnItemClickListener() {
		        	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
		        		@SuppressWarnings("unchecked")
						HashMap<String, String> o = (HashMap<String, String>) lv.getItemAtPosition(position);	        		
		        		//Toast.makeText(getBaseContext(), "URL --> " + o.get("source_url"), Toast.LENGTH_SHORT).show();
		        		//Log.i("LOG", o.get("title"));
//		        		Uri newuri = Uri.parse(o.get("source_url"));
//		        		Intent intent = new Intent(Intent.ACTION_VIEW,
//		        		newuri);
//		        		startActivity(intent);
		        		Intent intent = new Intent(getApplicationContext(), ThirdActivity.class); 
		            	intent.putExtra("passedUrl", o.get("source_url"));
		            	startActivity(intent);
					}
				});
				
			} catch (JSONException e){
				Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
		}
    
	}
    
    // Calls Main Activity
    public void callMainActivity(View v) {
    	finish();
	}

}
