package com.markevansjr.quoteme;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

@SuppressLint("HandlerLeak")
public class SearchFragmentTab extends Fragment{
	QuoteList _quoteList = null;
	ArrayList<Map<String, String>> _data = new ArrayList<Map<String,String>>();
	ArrayList<String> _authors = new ArrayList<String>();
	ArrayList<String> _quotes = new ArrayList<String>();
	SimpleAdapter _adapter;
	ArrayAdapter<String> _adapter2;
	JSONArray _results;
	static ListView _lv;
	static String _theQuote;
	static String _theAuthor;
	String _stored;
	String _fullQuote;
	View _view;
	EditText _et;
	Button _searchBtn;
	List<Map<String, String>> _data2;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
	}
	
    @Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) { 	
		_view = inflater.inflate(R.layout.search_frag, container, false);	
		_lv = (ListView) _view.findViewById(R.id.List_View);
		_et = (EditText) _view.findViewById(R.id.editText1);
		_searchBtn = (Button) _view.findViewById(R.id.Search_Button);
		
		_searchBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//Boolean connected = WebStuff.getConnectionStatus(getActivity().getApplicationContext());
				//if (connected){
					InputMethodManager imm = (InputMethodManager) getView().getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
					imm.hideSoftInputFromWindow(_et.getWindowToken(), 0);
					
					if (_et.getText().toString().equals("") || _et.getText().toString().equals(" ") || 
							_et.getText().toString() == "" || _et.getText().toString() == " ")
					{ 
						Toast toast = Toast.makeText(_view.getContext(), "MUST ENTER SOMETHING!", Toast.LENGTH_SHORT);
						toast.show();
					} else{
						getQuotes(_et.getText().toString());
					}
				//} else {
				//	Toast toast = Toast.makeText(_view.getContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
				//	toast.show();
				//}
    		}
		});
		
	    return _view;
	}
    
    // This receives the message from the service
	Handler theHandler = new Handler(){
		@SuppressLint("DefaultLocale")
		public void handleMessage(Message message){
			Object path = message.obj;
			if (message.arg1 == 0 && path != null){
				String a = (String) message.obj.toString();
				try{
					JSONObject json = new JSONObject(a);
			        Log.i("THE RESULTS", json.toString());
			        _data = new ArrayList<Map<String, String>>();
			        Map<String, String> map = new HashMap<String, String>(2);
					map.put("q", json.getString("quote"));
					String source = json.getString("source");
					String sourceFull = "-"+source.substring(0,1).toUpperCase()+source.substring(1,source.length());
				    map.put("a", sourceFull);
				    _data.add(map);
			     
					    // List adapter is set
				        _adapter = new SimpleAdapter(_view.getContext(), _data, R.layout.custom2,
				                new String[] {"q", "a"},
				                new int[] {R.id.ctext1,
				                           R.id.ctext2});
				        _lv.setAdapter(_adapter);
				        
				        _lv.setOnItemClickListener(new OnItemClickListener() {
				        	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
				        		@SuppressWarnings("unchecked")
								HashMap<String, String> o = (HashMap<String, String>) _lv.getItemAtPosition(position);
				        		Log.i("TAG HASH", o.get("q"));
							}
						});
			        
				} catch (JSONException e){
					Log.e("JSON", "JSON OBJECT EXCEPTION");
					Toast toast = Toast.makeText(_view.getContext(), "NO RESULTS!", Toast.LENGTH_LONG);
					toast.show();
				}
			}
		}
	};
	
	public void getQuotes(String item){
			Toast toast = Toast.makeText(_view.getContext(), "LOADING DATA..", Toast.LENGTH_LONG);
			toast.show();
			
			// Searched Item and Messenger is passed to GetService
			Messenger messenger = new Messenger(theHandler);
			Intent i = new Intent(_view.getContext(), GetService.class);
			i.putExtra("item", item);
			i.putExtra("messenger", messenger);
			getActivity().startService(i);	
	}
}