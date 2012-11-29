package com.markevansjr.fragmentapp;

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
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends Activity implements MainFragment.MainListener {

	List<Map<String, String>> _data;
	JSONArray _results;
	Context _context;
	EditText _searchTxt;
	Button _searchBtn;
	String _searchedText;
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        _searchTxt = (EditText) findViewById(R.id.editText_1);
        _searchBtn = (Button) findViewById(R.id.button_1);
        _searchedText = _searchTxt.getText().toString();
        
        _searchBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
					//doSearch(_searchedText);
					onCategorySelected("http://punchfork.com/recipes/"+_searchTxt.getText().toString());
            	}
        });
    	
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
				    map.put("pf_url", s.getString("pf_url"));
				    _data.add(map);
				}
		        Log.i("THE RESULTS", _results.toString());
				
			} catch (JSONException e){
				Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
		}
    
	}

	@Override
	public void onCategorySelected(String url) {
		WebViewFragment fragment = (WebViewFragment) getFragmentManager().findFragmentById(R.id.webViewFrag);
		if (fragment != null && fragment.isInLayout()) {
			fragment.setNewPage(url);
		} else {
			Intent intent = new Intent(getApplicationContext(), WebViewActivity.class);
			intent.putExtra("url", url);
			startActivity(intent);
		}
	}
	
}