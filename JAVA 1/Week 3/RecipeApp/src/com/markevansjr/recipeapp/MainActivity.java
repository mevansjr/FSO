package com.markevansjr.recipeapp;

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
import android.graphics.Color;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

import com.markevansjr.recipeapp.lib.FileStuff;
import com.markevansjr.recipeapp.lib.RecipeDisplay;
import com.markevansjr.recipeapp.lib.WebStuff;
import com.markevansjr.recipeapp.lib.SearchForm;

public class MainActivity extends Activity {
	LinearLayout _appLayout;
	Context _context;
	LinearLayout _search;
	Boolean connected = false;
	RecipeDisplay _recipedisplay;
	HashMap <String, String> _history;
    LinearLayout linearLayout;
	ListView listView;
	
	@SuppressWarnings("deprecation")
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        _appLayout = new LinearLayout(this);
        _context = this;
        _history = getHistory();
        //Log.i("HISTORY READ", _history.get("title"));
        
        // SEARCH VIEW
        _search = SearchForm.setup(_context, "Find Recipes", "Search");
        final EditText textField = (EditText) _search.findViewById(1);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
        Button searchBtn = (Button) _search.findViewById(2);
        searchBtn.setOnClickListener(new OnClickListener(){
        	@Override
        	public void onClick(View v){
        		// HIDES KEYBOARD
        		InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        		imm.hideSoftInputFromWindow(textField.getWindowToken(), 0);
        		
        		// CALLS SEARCH
        		doSearch(textField.getText().toString());
        	}
        });   
        _appLayout.addView(_search);
        
        //DETECT NETWORK
        connected = WebStuff.getConnectionStatus(_context);
        if(connected){
        	Log.i("NETWORK CONNECTION", WebStuff.getConnectionType(_context));
        }
        
        // LIST VIEW
        listView = new ListView(this);
        listView.setBackgroundColor(Color.WHITE);
        listView.setId(5);
        _appLayout.addView(listView,new LinearLayout.LayoutParams(
        	    LinearLayout.LayoutParams.FILL_PARENT,
        	    LinearLayout.LayoutParams.WRAP_CONTENT));

        _appLayout.setOrientation(LinearLayout.VERTICAL);
        _appLayout.setBackgroundColor(Color.BLACK);
        setContentView(_appLayout);
    }

	@SuppressWarnings("unchecked")
	private HashMap<String, String> getHistory() {
		Object stored = FileStuff.readObjectFile(_context, "history", false);
		
		HashMap<String, String> history;
		if(stored != null){
			Log.i("HISTORY", "NO HISTORY FILE FOUND");
			history = new HashMap<String, String>();
		} else {
			history = (HashMap<String, String>) stored;
		}
		return history;
	}

	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
	
	@SuppressWarnings("unused")
	private void doSearch(String item){
		String apiURL = "http://api.punchfork.com/recipes?key=13c42c860b3e65ae&q="+item+"&count=10";
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
				JSONArray results = json.getJSONArray("recipes");
				
				List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
		        for(int i=0;i<results.length();i++){							
					JSONObject s = results.getJSONObject(i);
					Map<String, String> map = new HashMap<String, String>(2);
					map.put("title", s.getString("title"));
				    map.put("source_name", s.getString("source_name"));
				    map.put("source_url", s.getString("source_url"));
				    data.add(map);
				    //_history.put(s.getString("title"), results.toString());
					//FileStuff.storeObjectFile(_context, "history", _history, false);
					//FileStuff.storeStringFile(_context, "temp", s.toString(), true);
				}
				Log.i("THE RESULTS", results.toString());
				
				final ListView tlv = (ListView) listView.findViewById(5);
				SimpleAdapter adapter = new SimpleAdapter(_context, data,
                        R.layout.list,
                        new String[] {"title", "source_name", "source_url"},
                        new int[] {android.R.id.text1,
                                   android.R.id.text2});
				tlv.setAdapter(adapter);;
				tlv.setOnItemClickListener(new OnItemClickListener() {
		        	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
		        		@SuppressWarnings("unchecked")
						HashMap<String, String> o = (HashMap<String, String>) tlv.getItemAtPosition(position);	        		
		        		Toast.makeText(_context, "URL --> " + o.get("source_url"), Toast.LENGTH_SHORT).show();
		        		//FileStuff.storeStringFile(_context, "temp", o.get("source_url").toString(), true);
					}
				});
				
			} catch (JSONException e){
				Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
		}

	
	}
}
