package com.markevansjr.quoteme;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class SavedFragmentTab extends Fragment {
	
	View _view;
	
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
        GridView gridView;
        
    	final String[] quotes = new String[] { 
    		"To live..", "If I were a..","Today's reason to..", "Hello, I am.." };
     
    	gridView = (GridView) _view.findViewById(R.id.gridView1);
        
		gridView.setAdapter(new ImageAdapter(_view.getContext(), quotes));
 
		gridView.setOnItemClickListener(new OnItemClickListener() {
			public void onItemClick(AdapterView<?> parent, View v,
					int position, long id) {
				Toast.makeText(_view.getContext(),((TextView) v.findViewById(R.id.grid_item_label)).getText(), Toast.LENGTH_SHORT).show();
			}
		});
		return _view;
    }
}
