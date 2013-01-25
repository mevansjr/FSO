package com.markevansjr.fragmentapp;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.parse.Parse;
import com.parse.PushService;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.SimpleAdapter;
import android.widget.Spinner;
import android.widget.Toast;

@SuppressLint("HandlerLeak")
public class MainActivity extends Activity implements SearchView.OnQueryTextListener {

	JSONArray _results;
	Context _context;
	EditText _et;
	private SearchView mSearchView;
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
    	Toast toast = Toast.makeText(getApplicationContext(), "DISABLED FEATURE", Toast.LENGTH_SHORT);
		toast.show();
//		Intent i = new Intent(getApplicationContext(), SavedRecipes.class); 
//		startActivity(i);
    }
    
    // Calls Implict Intent
    public void callBrowser(View v)
    {
    	Toast toast = Toast.makeText(getApplicationContext(), "DISABLED FEATURE", Toast.LENGTH_SHORT);
		toast.show();
		
    	ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
				(connec.getNetworkInfo(0).isAvailable() == true)){
			
			//String theurl = "http://punchfork.com/";
//			Uri theuri = Uri.parse(theurl);
//			Intent i = new Intent(Intent.ACTION_VIEW, theuri);
//			startActivity(i);
			
			// Call my Custom Application <--- 
	    	//String scheme = "search://name/"+ theurl;
			//Uri webpage = Uri.parse(scheme);
			
			//Intent browseIntent = new Intent(Intent.ACTION_VIEW, webpage);
			//browseIntent.putExtra("passedData", theurl);
		    //String title = "Select Browser..";
	        //Intent chooser = Intent.createChooser(browseIntent, title);
	        //startActivityForResult(chooser, 1);
		} else {
			Toast toast2 = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
			toast2.show();
		}
    }
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        try {
            ViewConfiguration config = ViewConfiguration.get(this);
            Field menuKeyField = ViewConfiguration.class.getDeclaredField("sHasPermanentMenuKey");
            if(menuKeyField != null) {
                menuKeyField.setAccessible(true);
                menuKeyField.setBoolean(config, false);
            }
        } catch (Exception ex) {
            // Ignore
        }
        
        // Inits my Third Party Library PARSE
        Parse.initialize(this, "TBiseo0g6kBVQZtaSvvdeODiTbAocbPdejnCwySK", "0Nq6dILkHnpHTKQGZqwnzsGAltTPpKlvOJAKvWZH"); 
       
        // Push Notification Subscribe
        PushService.subscribe(getApplicationContext(), "Recipe", MainActivity.class);
        
        // Receive and Update Favorites
        getAndUpdate();
        
        // Find text field and search button
        //_et = (EditText) findViewById(R.id.editText_1);
        //_searchBtn = (Button) findViewById(R.id.button_1);
        
        
        // List View setup for data from PARSE
        _lv = (ListView) findViewById(R.id.listView1);

        // Find Fav Button
        _favBtn = (Button) findViewById(R.id.SavedBtn);
        
//        _favBtn.setOnClickListener(new OnClickListener() {
//			@Override
//			public void onClick(View v) {
//				ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
//				if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
//						(connec.getNetworkInfo(0).isAvailable() == true)){
//				Toast toast = Toast.makeText(getApplicationContext(), "LOADING DATA..", Toast.LENGTH_LONG);
//				toast.show();
//				
//				// Create our installation query
//				ParseQuery pushQuery = ParseInstallation.getQuery();
//				pushQuery.whereEqualTo("Recipe", true);
//				
//				// Send push notification to query
//				ParsePush push = new ParsePush();
//				push.setQuery(pushQuery); // Set our installation query
//				push.setMessage("New Test");
//				push.sendInBackground();
//				
//				ParseQuery query = new ParseQuery("savedFavObject");
//				query.findInBackground(new FindCallback() {
//					public void done(List<ParseObject> objects, ParseException e) {
//						if (e == null) {
//            
//							if (objects.toArray().length > 0){
//								_data2 = new ArrayList<Map<String, String>>();
//            
//								for(int ii=0;ii<objects.toArray().length;ii++){							
//									ParseObject s = objects.get(ii);
//									Map<String, String> map = new HashMap<String, String>(2);
//									map.put("title", s.getString("title"));
//									map.put("source_name", s.getString("source"));
//									map.put("pf_url", s.getString("recipe_url"));
//									map.put("rating", s.getString("rating"));
//									map.put("source_img", s.getString("img_url"));
//									map.put("check", "true");
//									map.put("id", s.getObjectId());
//									_data2.add(map);
//								}
//              
//								// List adapter is set
//								_adapter2 = new SimpleAdapter(getApplicationContext(), _data2, android.R.layout.simple_list_item_2,
//										new String[] {"title", "source_name", "pf_url", "rating", "source_img", "check", "id"},
//										new int[] {android.R.id.text1,
//										android.R.id.text2});
//								_lv.setAdapter(_adapter2);
//              
//								_lv.setOnItemClickListener(new OnItemClickListener() {
//							public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
//								@SuppressWarnings("unchecked")
//								HashMap<String, String> o = (HashMap<String, String>) _lv.getItemAtPosition(position);
//              		
//								SecondViewFragment fragment = (SecondViewFragment) getFragmentManager().findFragmentById(R.id.secViewFrag);
//								if (fragment != null && fragment.isInLayout()) {
//									fragment.setInfo(o);
//								} else {
//									// Info is set to the details view via intent
//									Intent intent = new Intent(getApplicationContext(), SecondViewActivity.class);
//									intent.putExtra("RecipeData", o.toString());
//									intent.putExtra("RecipeTitle", o.get("title"));
//									intent.putExtra("RecipeUrl", o.get("pf_url"));
//									intent.putExtra("RecipeRating", o.get("rating"));
//									intent.putExtra("RecipeImageUrl", o.get("source_img"));
//									intent.putExtra("check", "true");
//									intent.putExtra("id", o.get("id"));
//									startActivity(intent);
//								}
//							}
//						});
//           
//						} else {
//							Log.i("FROM PARSE::", "NO DATA STORED");
//						}
//              
//						} else {
//							Log.e("ERROR::", "ERROR");
//						}
//					}
//				});   
//				} else {
//					Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
//					toast.show();
//				}
//			}
//		});
//        
        // Find spinner and set listAdapter
        _recentsList = (Spinner) findViewById(R.id.spinner1);
		ArrayAdapter<String> listAdapter = new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple_spinner_item, _recentTitle);
		listAdapter.setDropDownViewResource(R.layout.custom_spinner_dropdown);
		_recentsList.setAdapter(listAdapter);
//		_recentsList.setOnItemSelectedListener(new OnItemSelectedListener() {
//        	@Override
//        	public void onItemSelected(AdapterView<?> parent, View v, int pos, long id){
//        		if(pos > 0){
//        			_fav = parent.getItemAtPosition(pos).toString();	
//        			if (_fav.equals("PAST SEARCHES...") || _fav == "PAST SEARCHES..."){
//        			} else {
//        				//_et.setText(_fav);
//        			}
//        		}
//        	}

			//@Override
//			public void onNothingSelected(AdapterView<?> arg0) {
//				// TODO Auto-generated method stub
//				
//			}
       // });
        
		// If view is in Landscape the text field hint and search button text will be different
        if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
        	//_et.setHint(R.string.btn_text2);
        	//_searchBtn.setText(R.string.btn_text4);
        }
        
//        _searchBtn.setOnClickListener(new OnClickListener() {
//			@Override
//			public void onClick(View v) {
//				ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
//				if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
//						(connec.getNetworkInfo(0).isAvailable() == true)){
//					InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
//					imm.hideSoftInputFromWindow(_et.getWindowToken(), 0);
//					
//					if (_et.getText().toString().equals("") || _et.getText().toString().equals(" ") || 
//							_et.getText().toString() == "" || _et.getText().toString() == " ")
//					{ 
//						Toast toast = Toast.makeText(getApplicationContext(), "MUST ENTER RECIPE!", Toast.LENGTH_SHORT);
//						toast.show();
//					}
//					else
//					{
//						getRecipes(_et.getText().toString());
//					}
//					
//					//ReceivePush.getPush();
//			} else {
//				Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
//				toast.show();
//			}
//            	}
//        });
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
	Handler theHandler = new Handler(){
		public void handleMessage(Message message){
			Object path = message.obj;
			if (message.arg1 == RESULT_OK && path != null){
				String a = (String) message.obj.toString();
				try{
					JSONObject json = new JSONObject(a);
					_results = json.getJSONArray("results");
			        Log.i("THE RESULTS", _results.toString());
	    			
	    			// Provider manages the saved results which stores it search history
//			        Uri initProvider = Uri.parse("content://com.markevansjr.ContentServiceApp.provider/"+_et.getText().toString());
//					getContentResolver().update(initProvider, null, _results.toString(), null);
//					getAndUpdate();
			        
			        Log.i("TAG", String.valueOf(_results.length()));
			        if (_results.length() == 0){
			        	Toast toast = Toast.makeText(getApplicationContext(), "NO RESULTS!", Toast.LENGTH_LONG);
						toast.show();
			        }
			        
			        _data = new ArrayList<Map<String, String>>();
					
				    for(int i=0;i<_results.length();i++){							
						JSONObject s = _results.getJSONObject(i);
						Map<String, String> map = new HashMap<String, String>(2);
						map.put("title", s.getString("title"));
						//map.put("source_name", s.getString("source_name"));
					    map.put("pf_url", s.getString("href"));
					    //map.put("rating", s.getString("rating"));
					    map.put("source_img", s.getString("thumbnail"));
					    map.put("check", "false");
					    _data.add(map);
				        
					    // List adapter is set
				        _adapter = new SimpleAdapter(getApplicationContext(), _data, android.R.layout.simple_list_item_2,
				                new String[] {"title", "pf_url", "source_img", "check"},
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
	
	public void getRecipes(String item){
			Toast toast = Toast.makeText(getApplicationContext(), "LOADING DATA..", Toast.LENGTH_LONG);
			toast.show();
			
			//Yay there is a connection
//			if (_et.getText().toString().length() > 0){
//				item = _et.getText().toString();
//			} else {
//				item = _fav;
//			}
//			_passed = item;
//			Log.i("CHECK ITEM", item);
			
			// Searched Item and Messenger is passed to GetService
			Messenger messenger = new Messenger(theHandler);
			Intent i = new Intent(getApplicationContext(), GetService.class);
			i.putExtra("item", item);
			i.putExtra("messenger", messenger);
			startService(i);	
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
	    getMenuInflater().inflate(R.layout.menu, menu);
        MenuItem searchItem = menu.findItem(R.id.menu_search);
        mSearchView = (SearchView) searchItem.getActionView();
        mSearchView.setOnQueryTextListener(this);
        
        return super.onCreateOptionsMenu(menu);
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
	    switch(item.getItemId()) {
	    case R.id.item_about:
	        //click on about item
	    	Log.i("TAG", "ABOUT");
	    	Intent i = new Intent(getApplicationContext(), About.class); 
			startActivity(i);
	        break;
    	}
	    return true;
	}

	 @Override
	 public boolean onQueryTextChange(String newText) {
		 Log.i("TAG ONCHANGE", newText);
		return false;
	 }

	 @Override
	 public boolean onQueryTextSubmit(String query) {
		 Log.i("TAG QUERY", query);
		 
		 	ConnectivityManager connec = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
			if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
					(connec.getNetworkInfo(0).isAvailable() == true)){
				InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
				imm.hideSoftInputFromWindow(mSearchView.getWindowToken(), 0);
				
				if (query.equals("") || query.equals(" ") || 
						query == "" || query == " ")
				{ 
					Toast toast = Toast.makeText(getApplicationContext(), "MUST ENTER RECIPE!", Toast.LENGTH_SHORT);
					toast.show();
				}
				else
				{
					//Yay there is a connection
					if (query.length() > 0){
						//
					} else {
						query = _fav;
					}
					
				 _passed = query;
				 Log.i("CHECK ITEM", query);
					
				 // Searched Item and Messenger is passed to GetService
				 Messenger messenger = new Messenger(theHandler);
				 Intent i = new Intent(getApplicationContext(), GetService.class);
				 i.putExtra("item", query);
				 i.putExtra("messenger", messenger);
				 startService(i);
				}
				
				//ReceivePush.getPush();
		} else {
			Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
			toast.show();
		}
		 		 
		 
		 return false;
	 }
	
}