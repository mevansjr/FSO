package com.markevansjr.fragmentapp;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.ListFragment;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

public class MainFragment extends ListFragment {

	MainListener listener;
	Context _context;
	ArrayList<Map<String, String>> _data = new ArrayList<Map<String, String>>();
	
	public interface MainListener{
		public void onCategorySelected(String url);
	}
	
	@Override
	public void onAttach(Activity activity){
		super.onAttach(activity);
		try{
			listener = (MainListener) activity;
		} catch (ClassCastException e){
			Log.e("FRAGMENT ERROR","CALLING ACTIVITY DOES NOT IMPLEMENT MAINLISTENER");
		}
	}
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setListAdapter(ArrayAdapter.createFromResource(getActivity()
                .getApplicationContext(), R.array.cat_titles,
                android.R.layout.simple_list_item_1));	
	}
	
	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
        	
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
				JSONArray _results = json.getJSONArray("recipes");
				
				//
			
		        for(int i=0;i<_results.length();i++){							
					JSONObject s = _results.getJSONObject(i);
					Map<String, String> map = new HashMap<String, String>(2);
					map.put("title", s.getString("title"));
				    map.put("pf_url", s.getString("pf_url"));
				    _data.add(map);
				}
		        Log.i("THE RESULTS", _results.toString());
		        if (_results.length() == 0){
		        	Toast toast = Toast.makeText(getView().getContext(), "Results not Found!", Toast.LENGTH_SHORT);
					toast.show();
		        } else {
		        	listener.onCategorySelected(_results.toString());
		        }
				
			} catch (JSONException e){
				Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
		}
    
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
        String[] urls = getResources().getStringArray(R.array.cat_links);
		String url = urls[position];
		doSearch(url);
	}
}
