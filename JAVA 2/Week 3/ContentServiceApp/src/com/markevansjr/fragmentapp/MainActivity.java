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
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;
import android.widget.AdapterView.OnItemSelectedListener;

public class MainActivity extends Activity implements MainFragment.MainListener {

	static List<Map<String, String>> _data;
	JSONArray _results;
	Context _context;
	EditText _et;
	Button _searchBtn;
	Spinner _list;
	String _history;
	ArrayList<String> _urlArray = new ArrayList<String>();
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        _et = (EditText) findViewById(R.id.editText_1);
        _searchBtn = (Button) findViewById(R.id.button_1);
        
        _urlArray.add("Last Searched...");
        
        _history = getHistory();
        Log.i("HISTORY READ",_history.toString());
        
        _list = (Spinner) findViewById(R.id.spinner1);
		ArrayAdapter<String> listAdapter = new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple_spinner_item, _urlArray);
		listAdapter.setDropDownViewResource(R.layout.custom_spinner_dropdown);
		_list.setAdapter(listAdapter);
		_list.setOnItemSelectedListener(new OnItemSelectedListener() {
        	@Override
        	public void onItemSelected(AdapterView<?> parent, View v, int pos, long id){
        		if(pos > 0){
        			String fav = parent.getItemAtPosition(pos).toString();	
        			if (fav.equals("Last Searched...") || fav == "Last Searched..."){
        				Log.i("FAV SELECTED", "Last Searched...");
        				//_et.setText("");
        			} else {
        				//_et.setText(fav);
        				//onCategorySelected(fav);
        				doSearch(fav);
        			}
        		}
        	}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub
				
			}
        });
        
        if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
        	_et.setHint(R.string.btn_text2);
        	_searchBtn.setText(R.string.btn_text4);
        }
        
        _searchBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
					if (_et.getText().toString().equals("") || _et.getText().toString().equals(" ") || 
							_et.getText().toString() == "" || _et.getText().toString() == " ")
					{ 
						Toast toast = Toast.makeText(getApplicationContext(), "Must Enter a Recipe!", Toast.LENGTH_SHORT);
						toast.show();
					}
					else
					{
						doSearch(_et.getText().toString());
						//onCategorySelected(_et.getText().toString());
						_urlArray.add(_et.getText().toString());
						FileStuff.storeStringFile(getApplicationContext(), "history", _et.getText().toString(), false);
					}
            	}
        });
    }
	
	private String getHistory(){
    	Object stored = FileStuff.readStringFile(getApplicationContext(), "history", false);
    	
    	String history = null;
    	if(stored == null){
    		Log.i("HISTORY","NO HISTORY FILE FOUND");
    	} else {
    		history = (String) stored;
    		_urlArray.add((String) stored);
    	}
    	return history;
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
		        if (_results.length() == 0){
		        	Toast toast = Toast.makeText(getApplicationContext(), "Results not Found!", Toast.LENGTH_SHORT);
					toast.show();
		        } else {
		        	onCategorySelected(_results.toString());
		        }
				
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
			startActivityForResult(intent, 1);
		}
	}
	
}