package com.mevansjr.simpleweather;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import com.mevansjr.simpleweather.lib.FileStuff;
import com.mevansjr.simpleweather.lib.WebStuff;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.Toast;
import android.widget.AdapterView.OnItemSelectedListener;

public class Main extends Activity {

	Context _context;
	LinearLayout _LinearLayout;
	public SearchForm _searchDisplay;
	WeatherDisplay _weatherDisplay;
	FavDisplay _favs;
	HashMap<String, String> _history;
	String _imageURLStr;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        _context = this;
        _LinearLayout = new LinearLayout(this);
        _history = getHistory();
        Log.i("HISTORY READ",_history.toString());
        
        //ADD SEARCH DISPLAY
        _searchDisplay = new SearchForm(_context, "Enter Zip Code", "Search");
        _searchDisplay.setBackgroundColor(Color.LTGRAY);
        _searchDisplay.setId(2);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
        //ADD SEARCH FUNCTIONALITY
        Button searchButton = _searchDisplay.getButton();
        searchButton.setTextColor(Color.WHITE);
        
        searchButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				// HIDES KEYBOARD
        		InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        		imm.hideSoftInputFromWindow(_searchDisplay.getField().getWindowToken(), 0);
        		Boolean connected = WebStuff.getConnectionStatus(_context);
            	if(connected){
            		String zip = _searchDisplay.getField().getText().toString();
            		_searchDisplay.getField().setText(zip);
            		_searchDisplay.getField().setHintTextColor(Color.DKGRAY);
					doSearch(zip);
            	} else {
            		Toast toast = Toast.makeText(_context, "No network connection.", Toast.LENGTH_SHORT);
            		toast.show();
            	}
			}
		}); 
        _LinearLayout.addView(_searchDisplay);
        
        //ADD WEATHER DISPLAY
        _weatherDisplay = new WeatherDisplay(_context);
        LayoutParams lp = new LayoutParams(LayoutParams.MATCH_PARENT, 0, 1.0f);
        _weatherDisplay.setLayoutParams(lp);
        _LinearLayout.addView(_weatherDisplay);
        
        //ADD IMAGEVIEW
        //ImageView img = new ImageView(this);
        //img.setImageResource(R.drawable.logo);
        //img.setPadding(105, 0, 0, 155);
        //_LinearLayout.addView(img);
        
        //ADD FAVS AND FUNCTIONALITY
        ArrayList<String> favs = new ArrayList<String>(Arrays.<String>asList(FileStuff.readStringFile(_context, "favorites", true).split(",")));
        _favs = new FavDisplay(_context, favs);
        _favs._list.setOnItemSelectedListener(new OnItemSelectedListener() {
        	@Override
        	public void onItemSelected(AdapterView<?> parent, View v, int pos, long id){
        		if(pos > 0){
        			String symbol = parent.getItemAtPosition(pos).toString();				
        			_searchDisplay.getField().setText(symbol);
        			doSearch(symbol);
        		}
        	}
		
        	@Override
        	public void onNothingSelected(AdapterView<?> parent){
        		Log.i("FAVORITE SELECTED", "NONE");
        	}
        });   
  		_favs._addBtn.setOnClickListener(new OnClickListener() {
  			@Override
  			public void onClick(View v) {
  				String zip = _weatherDisplay._current;
  				if(zip.length() > 0){
  					Boolean found = false;
  					int foundpos = 0;
  					for(int i=1, j=_favs._zipsArray.size(); i<j; i++){
  						if(_favs._zipsArray.get(i).compareTo(zip)==0){
  							found = true;
  							foundpos = i;
  							break;
  						}
  					}
  					if(!found){
  						_favs._zipsArray.add(zip);
  						storeFavs(zip);
  						_favs._list.setSelection(_favs._zipsArray.size()-1);
  					} else {
  						_favs._list.setSelection(foundpos);
  					}
  				} else {
  					Toast toast =  Toast.makeText(_context, "Zip not found.", Toast.LENGTH_SHORT);
  					toast.show();
  				}
  			}
  		});
  		_favs.setBackgroundColor(Color.LTGRAY);
  		_LinearLayout.addView(_favs);
  		
        
        //SET UP MAIN VIEW
        _LinearLayout.setOrientation(LinearLayout.VERTICAL);
        _LinearLayout.setBackgroundColor(Color.DKGRAY);
        
        setContentView(_LinearLayout);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
    
    private void storeFavs(String item){
    	StringBuilder sb = new StringBuilder();
			for(int i=1, q=_favs._zipsArray.size(); i<q; i++){
				sb.append(_favs._zipsArray.get(i));
				sb.append(",");
			}
			String favString = sb.toString().substring(0, sb.toString().length()-1);
			Boolean stored = FileStuff.storeStringFile(_context,"favorites", favString, true);
			Toast toast;
			if(stored){
				toast = Toast.makeText(_context, "Updated Favorites", Toast.LENGTH_SHORT);
				toast.show();
			} else {
				toast = Toast.makeText(_context, "Unable to Update Favorites", Toast.LENGTH_SHORT);
				toast.show();
			}
    }
    
    private void doSearch(String item){
    	Boolean connected = WebStuff.getConnectionStatus(_context);
    	if(connected){
    		String blank = "";
    		int comparsionResult = item.compareTo(blank) ;
    		if(comparsionResult == 0 && connected){
				Toast toast = Toast.makeText(_context, "You Must Enter a Zip Code", Toast.LENGTH_SHORT);
				toast.show();
			} else {
				String theURL = "http://api.wunderground.com/api/6beda32b11e9a729/conditions/q/"+item+".json";
	    		URL finalURL;
	    		try{
	    			finalURL = new URL(theURL);
	    			Request qr = new Request();
	    			qr.execute(finalURL);
	    		} catch (MalformedURLException e){
	    			Log.e("BAD URL", "MALFORMED URL");
	    			finalURL = null;
	    		}
			}
    	} else if(_history.containsKey(item)){
    		String jsonString = (String) _history.get(item);
    		_weatherDisplay.updateData(buildJSON(jsonString));
    	} else {
    		Toast toast = Toast.makeText(_context, "No network connection", Toast.LENGTH_SHORT);
    		toast.show();
    	}
    }
    
    private JSONObject buildJSON(String jsonString){
    	JSONObject data;
    	try{
			data = new JSONObject(jsonString);
		} catch (JSONException e){
			data = null;
		}
    	return data;
    }
    
    @SuppressWarnings("unchecked")
	private HashMap<String, String> getHistory(){
    	Object stored = FileStuff.readObjectFile(_context, "history", false);
    	
    	HashMap<String, String> history;
    	if(stored == null){
    		Log.i("HISTORY","NO HISTORY FILE FOUND");
    		history = new HashMap<String, String>(); 
    	} else {
    		history = (HashMap<String, String>) stored;
    	}
    	return history;
    }
    
    private class Request extends AsyncTask<URL, Void, String>{
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
			JSONObject json = buildJSON(result);
			try{
				JSONObject results = json.getJSONObject("current_observation");
				Log.i("RESULTS", results.toString());
					_weatherDisplay.updateData(results);
					String zip = _searchDisplay.getField().getText().toString();
					_history.put(zip, results.toString());
					FileStuff.storeObjectFile(_context, "history", _history, false);
				
			} catch (JSONException e){
				Log.e("JSON EXCEPTION","ERROR PARSING");
				Toast toast = Toast.makeText(_context, "Bad Zip Code", Toast.LENGTH_SHORT);
				toast.show();
			}
    	}
    }

    
}
