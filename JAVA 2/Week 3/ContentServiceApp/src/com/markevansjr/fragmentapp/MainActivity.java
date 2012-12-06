package com.markevansjr.fragmentapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
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
	Spinner _list;
	ListView _lv;
	String _history;
	String _passedData;
	List<Map<String, String>> _data;
	SimpleAdapter _adapter;
	ArrayList<String> _urlArray = new ArrayList<String>();
	GetRecipe getRecipe;
	String _fav;
	String _passed;
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        _et = (EditText) findViewById(R.id.editText_1);
        _searchBtn = (Button) findViewById(R.id.button_1);
        
        // Adapter setup
        _lv = (ListView) findViewById(R.id.listView1);
        
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
        			_fav = parent.getItemAtPosition(pos).toString();	
        			if (_fav.equals("Last Searched...") || _fav == "Last Searched..."){
        				Log.i("FAV SELECTED", "Last Searched...");
        				//_et.setText("");
        			} else {
        				getRecipes(_fav);
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
					InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
					imm.hideSoftInputFromWindow(_et.getWindowToken(), 0);
					if (_et.getText().toString().equals("") || _et.getText().toString().equals(" ") || 
							_et.getText().toString() == "" || _et.getText().toString() == " ")
					{ 
						Toast toast = Toast.makeText(getApplicationContext(), "Must Enter a Recipe!", Toast.LENGTH_SHORT);
						toast.show();
					}
					else
					{
						getRecipes(_et.getText().toString());
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
	
	private Handler theHandler = new Handler(){
		public void handleMessage(Message message){
			Object path = message.obj;
			if (message.arg1 == RESULT_OK && path != null){
				String a = (String) message.obj.toString();
				try{
					JSONObject json = new JSONObject(a);
					_results = json.getJSONArray("recipes");
			        Log.i("THE RESULTS", _results.toString());
			        
			        _data = new ArrayList<Map<String, String>>();
					
				    for(int i=0;i<_results.length();i++){							
						JSONObject s = _results.getJSONObject(i);
						Map<String, String> map = new HashMap<String, String>(2);
						map.put("title", s.getString("title"));
						map.put("source_name", s.getString("source_name"));
					    map.put("pf_url", s.getString("pf_url"));
					    map.put("rating", s.getString("rating"));
					    map.put("source_img", s.getString("source_img"));
					    _data.add(map);
				        
				        _adapter = new SimpleAdapter(getApplicationContext(), _data, android.R.layout.simple_list_item_2,
				                new String[] {"title", "source_name", "source_url", "rating", "source_img"},
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
				        			Intent intent = new Intent(getApplicationContext(), SecondViewActivity.class);
				        			intent.putExtra("RecipeData", o.toString());
				        			intent.putExtra("RecipeTitle", o.get("title"));
				        			intent.putExtra("RecipeUrl", o.get("pf_url"));
				        			intent.putExtra("RecipeRating", o.get("rating"));
				        			intent.putExtra("RecipeImageUrl", o.get("source_img"));
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
		if (_et.getText().toString().length() > 0){
			item = _et.getText().toString();
		} else {
			item = _fav;
		}
		_passed = item;
		Log.i("CHECK ITEM", item);
		Messenger messenger = new Messenger(theHandler);
		Intent i = new Intent(getApplicationContext(), GetService.class);
		i.putExtra("item", item);
		i.putExtra("messenger", messenger);
		startService(i);
	}
	
}