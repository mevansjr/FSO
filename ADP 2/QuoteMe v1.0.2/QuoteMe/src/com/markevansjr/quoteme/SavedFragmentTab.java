package com.markevansjr.quoteme;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.SimpleAdapter;
import android.widget.AdapterView.OnItemClickListener;

public class SavedFragmentTab extends Fragment {
	
	View _view;
	ArrayList<Map<String, String>> _data = new ArrayList<Map<String,String>>();
	GridView _gridView;
	MainListener listener;
	
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
    	
    	_view = inflater.inflate(R.layout.saved_frag, container, false);
    	_gridView = (GridView) _view.findViewById(R.id.gridView1);
    	
    	ParseQuery query = new ParseQuery("savedObjects");
		query.findInBackground(new FindCallback() {
			public void done(List<ParseObject> objects, ParseException e) {
				if (e == null) {
    
					if (objects.toArray().length > 0){
						_data = new ArrayList<Map<String, String>>();
    
						for(int ii=0;ii<objects.toArray().length;ii++){							
							ParseObject s = objects.get(ii);
							Map<String, String> map = new HashMap<String, String>(2);
							map.put("savedQuote", s.getString("savedQuote"));
							String quote = s.getString("savedQuote");
							if (quote.length() >= 9){
								String pQuote = quote.substring(0, 9);
								map.put("pQuote", pQuote+"..");
							} else {
								map.put("pQuote", quote);
							}
							map.put("savedAuthor", s.getString("savedAuthor"));
							map.put("image", Integer.toString(R.drawable.ic_newpageicon));
							map.put("theId", s.getObjectId());
							_data.add(map);
						}
				 
				        // Keys used in Hashmap
				        String[] from = {"image","pQuote"};
				 
				        // Ids of views in listview_layout
				        int[] to = { R.id.grid_item_image,R.id.grid_item_label};
				 
				        // Instantiating an adapter to store each items
				        // R.layout.listview_layout defines the layout of each item
				        SimpleAdapter adapter = new SimpleAdapter(_view.getContext(), _data, R.layout.custom_grid_item, from, to);
				 
						
						_gridView.setAdapter(adapter);
						 
						_gridView.setOnItemClickListener(new OnItemClickListener() {
							@SuppressWarnings("unchecked")
							public void onItemClick(AdapterView<?> parent, View v, int position, long id) {
								HashMap<String, String> o = (HashMap<String, String>) _gridView.getItemAtPosition(position);
								//Toast.makeText(_view.getContext(),o.get("savedQuote"), Toast.LENGTH_SHORT).show();
								listener.passObjectString(o.toString(),o.get("savedQuote"), o.get("savedAuthor"));
							}
						});
					}
				}
			}
		});
        
		return _view;
    }
    
    @Override
	public void onAttach(Activity activity) {
		super.onAttach(activity);
		try{
			listener = (MainListener) activity;
		} catch (ClassCastException e) {
			throw new ClassCastException(activity.toString() + " must implement MainListener");
		}
	}
}
