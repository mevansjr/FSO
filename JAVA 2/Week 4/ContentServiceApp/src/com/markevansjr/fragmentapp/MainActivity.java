package com.markevansjr.fragmentapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseInstallation;
import com.parse.ParseObject;
import com.parse.ParsePush;
import com.parse.ParseQuery;
import com.parse.PushService;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Spinner;
import android.widget.Toast;
import android.widget.AdapterView.OnItemSelectedListener;

@SuppressLint("HandlerLeak")
public class MainActivity extends Activity {

	JSONArray _results;
	Context _context;
	EditText _et;
	Button _searchBtn;
	Button _favBtn;
	Spinner _list;
	ListView _lv;
	String _history;
	String _passedData;
	List<Map<String, String>> _data;
	List<Map<String, String>> _data2;
	SimpleAdapter _adapter;
	SimpleAdapter _adapter2;
	ArrayList<String> _titleArray = new ArrayList<String>();
	String _fav;
	String _passed;
	HashMap<String, String> _recent = new HashMap<String, String>();
	Spinner _recentsList;
	ArrayList<String> _recentTitle = new ArrayList<String>();
	boolean _check = false;
	Boolean _connected = false;
	
	// Calls Saved Favorites Activity
    public void callFavs(View v)
    {	
		Intent i = new Intent(getApplicationContext(), SavedRecipes.class); 
		startActivity(i);
    }
    
    // Calls Implict Intent
    public void callBrowser(View v)
    {
    	ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
				(connec.getNetworkInfo(0).isAvailable() == true)){
			Uri theuri = Uri.parse("http://punchfork.com/");
			Intent i = new Intent(Intent.ACTION_VIEW, theuri);
			startActivity(i);
		} else {
			Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
			toast.show();
		}
    }
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        // Inits my Third Party Library PARSE
        Parse.initialize(this, "PV07xPdLpxzJKBKUS2UP6iJ0W9GbEHvmfPMMQovz", "OPxrcJKt4Pe26WHvCAeuI86hnGzXjOlO1NmyfJyP");
       
        // Push Notification Subscribe
        PushService.subscribe(getApplicationContext(), "Recipe", MainActivity.class);
        
        // Receive and Update Favorites
        getAndUpdate();
        
        // Find text field and search button
        _et = (EditText) findViewById(R.id.editText_1);
        _searchBtn = (Button) findViewById(R.id.button_1);
        
        // List View setup for data from PARSE
        _lv = (ListView) findViewById(R.id.listView1);

        // Find Fav Button
        _favBtn = (Button) findViewById(R.id.SavedBtn);
        
        _favBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
				if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
						(connec.getNetworkInfo(0).isAvailable() == true)){
				Toast toast = Toast.makeText(getApplicationContext(), "LOADING DATA..", Toast.LENGTH_LONG);
				toast.show();
				
				// Create our installation query
				ParseQuery pushQuery = ParseInstallation.getQuery();
				pushQuery.whereEqualTo("Recipe", true);
				
				// Send push notification to query
				ParsePush push = new ParsePush();
				push.setQuery(pushQuery); // Set our installation query
				push.setMessage("New Test");
				push.sendInBackground();
				
				ParseQuery query = new ParseQuery("savedFavObject");
				query.findInBackground(new FindCallback() {
					public void done(List<ParseObject> objects, ParseException e) {
						if (e == null) {
            
							if (objects.toArray().length > 0){
								_data2 = new ArrayList<Map<String, String>>();
            
								for(int ii=0;ii<objects.toArray().length;ii++){							
									ParseObject s = objects.get(ii);
									Map<String, String> map = new HashMap<String, String>(2);
									map.put("title", s.getString("title"));
									map.put("source_name", s.getString("source"));
									map.put("pf_url", s.getString("recipe_url"));
									map.put("rating", s.getString("rating"));
									map.put("source_img", s.getString("img_url"));
									map.put("check", "true");
									map.put("id", s.getObjectId());
									_data2.add(map);
								}
              
								// List adapter is set
								_adapter2 = new SimpleAdapter(getApplicationContext(), _data2, android.R.layout.simple_list_item_2,
										new String[] {"title", "source_name", "pf_url", "rating", "source_img", "check", "id"},
										new int[] {android.R.id.text1,
										android.R.id.text2});
								_lv.setAdapter(_adapter2);
              
								_lv.setOnItemClickListener(new OnItemClickListener() {
							public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
								@SuppressWarnings("unchecked")
								HashMap<String, String> o = (HashMap<String, String>) _lv.getItemAtPosition(position);
              		
								SecondViewFragment fragment = (SecondViewFragment) getFragmentManager().findFragmentById(R.id.secViewFrag);
								if (fragment != null && fragment.isInLayout()) {
									fragment.setInfo(o);
								} else {
									// Info is set to the details view via intent
									Intent intent = new Intent(getApplicationContext(), SecondViewActivity.class);
									intent.putExtra("RecipeData", o.toString());
									intent.putExtra("RecipeTitle", o.get("title"));
									intent.putExtra("RecipeUrl", o.get("pf_url"));
									intent.putExtra("RecipeRating", o.get("rating"));
									intent.putExtra("RecipeImageUrl", o.get("source_img"));
									intent.putExtra("check", "true");
									intent.putExtra("id", o.get("id"));
									startActivity(intent);
								}
							}
						});
           
						} else {
							Log.i("FROM PARSE::", "NO DATA STORED");
						}
              
						} else {
							Log.e("ERROR::", "ERROR");
						}
					}
				});   
				} else {
					Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
					toast.show();
				}
			}
		});
        
        // Find spinner and set listAdapter
        _recentsList = (Spinner) findViewById(R.id.spinner1);
		ArrayAdapter<String> listAdapter = new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple_spinner_item, _recentTitle);
		listAdapter.setDropDownViewResource(R.layout.custom_spinner_dropdown);
		_recentsList.setAdapter(listAdapter);
		_recentsList.setOnItemSelectedListener(new OnItemSelectedListener() {
        	@Override
        	public void onItemSelected(AdapterView<?> parent, View v, int pos, long id){
        		if(pos > 0){
        			_fav = parent.getItemAtPosition(pos).toString();	
        			if (_fav.equals("PAST SEARCHES...") || _fav == "PAST SEARCHES..."){
        			} else {
        				_et.setText(_fav);
        			}
        		}
        	}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub
				
			}
        });
        
		// If view is in Landscape the text field hint and search button text will be different
        if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
        	_et.setHint(R.string.btn_text2);
        	_searchBtn.setText(R.string.btn_text4);
        }
        
        _searchBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
				if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
						(connec.getNetworkInfo(0).isAvailable() == true)){
					InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
					imm.hideSoftInputFromWindow(_et.getWindowToken(), 0);
					
					if (_et.getText().toString().equals("") || _et.getText().toString().equals(" ") || 
							_et.getText().toString() == "" || _et.getText().toString() == " ")
					{ 
						Toast toast = Toast.makeText(getApplicationContext(), "MUST ENTER RECIPE!", Toast.LENGTH_SHORT);
						toast.show();
					}
					else
					{
						getRecipes(_et.getText().toString());
					}
					
					ReceivePush.getPush();
			} else {
				Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
				toast.show();
			}
            	}
        });
    }
	
	private void updateRecents() {
    	for(String key : _recent.keySet()) {
    		_recentTitle.add(key);
    	}
    }
    
    @SuppressWarnings("unchecked")
	private HashMap<String, String> getRecents() {
    	Object stored = FileStuff.readObjectFile(getApplicationContext(), "recent", false);
    	
    	HashMap<String, String> recents;
    	if (stored == null) {
			Log.i("RECENTS", "NO RECENTS FOUND");
			recents = new HashMap<String, String>();
		} else {
			recents = (HashMap<String, String>) stored;
		}
    	return recents;
    }
    
    private void getAndUpdate() {
    	if (!_recentTitle.isEmpty()) {
    		_recentTitle.clear();
		}
    	_recentTitle.add("PAST SEARCHES...");
    	_recent = getRecents();
    	updateRecents();
    }
	
    // This receives the message from the service
	private Handler theHandler = new Handler(){
		public void handleMessage(Message message){
			Object path = message.obj;
			if (message.arg1 == RESULT_OK && path != null){
				String a = (String) message.obj.toString();
				try{
					JSONObject json = new JSONObject(a);
					_results = json.getJSONArray("recipes");
			        Log.i("THE RESULTS", _results.toString());
	    			
	    			// Provider manages the saved results which stores it search history
			        Uri initProvider = Uri.parse("content://com.markevansjr.ContentServiceApp.provider/"+_et.getText().toString());
					getContentResolver().update(initProvider, null, _results.toString(), null);
					getAndUpdate();
			        
			        _data = new ArrayList<Map<String, String>>();
					
				    for(int i=0;i<_results.length();i++){							
						JSONObject s = _results.getJSONObject(i);
						Map<String, String> map = new HashMap<String, String>(2);
						map.put("title", s.getString("title"));
						map.put("source_name", s.getString("source_name"));
					    map.put("pf_url", s.getString("pf_url"));
					    map.put("rating", s.getString("rating"));
					    map.put("source_img", s.getString("source_img"));
					    map.put("check", "false");
					    _data.add(map);
				        
					    // List adapter is set
				        _adapter = new SimpleAdapter(getApplicationContext(), _data, android.R.layout.simple_list_item_2,
				                new String[] {"title", "source_name", "pf_url", "rating", "source_img", "check"},
				                new int[] {android.R.id.text1,
				                           android.R.id.text2});
				        _lv.setAdapter(_adapter);
				        
				        _lv.setOnItemClickListener(new OnItemClickListener() {
				        	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
				        		@SuppressWarnings("unchecked")
								HashMap<String, String> o = (HashMap<String, String>) _lv.getItemAtPosition(position);
				        		
				        		SecondViewFragment fragment = (SecondViewFragment) getFragmentManager().findFragmentById(R.id.secViewFrag);
				        		if (fragment != null && fragment.isInLayout()) {
				        			fragment.setInfo(o);
				        		} else {
				        			// Info is set to the details view via intent
				        			Intent intent = new Intent(getApplicationContext(), SecondViewActivity.class);
				        			intent.putExtra("RecipeData", o.toString());
				        			intent.putExtra("RecipeTitle", o.get("title"));
				        			intent.putExtra("RecipeSource", o.get("source_name"));
				        			intent.putExtra("RecipeUrl", o.get("pf_url"));
				        			intent.putExtra("RecipeRating", o.get("rating"));
				        			intent.putExtra("RecipeImageUrl", o.get("source_img"));
				        			intent.putExtra("check", o.get("check"));
				        			startActivity(intent);
				        		}
							}
						});
				    }
			        
				} catch (JSONException e){
					Log.e("JSON", "JSON OBJECT EXCEPTION");
				}
			}
		}
	};
	
	private void getRecipes(String item){
			Toast toast = Toast.makeText(getApplicationContext(), "LOADING DATA..", Toast.LENGTH_LONG);
			toast.show();
			
			//Yay there is a connection
			if (_et.getText().toString().length() > 0){
				item = _et.getText().toString();
			} else {
				item = _fav;
			}
			_passed = item;
			Log.i("CHECK ITEM", item);
			
			// Searched Item and Messenger is passed to GetService
			Messenger messenger = new Messenger(theHandler);
			Intent i = new Intent(getApplicationContext(), GetService.class);
			i.putExtra("item", item);
			i.putExtra("messenger", messenger);
			startService(i);	
	}
	
}