package com.markevansjr.fragmentapp;

import android.app.Activity;
import android.app.ListFragment;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class MainFragment extends ListFragment {

	MainListener listener;
	
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

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
        String[] urls = getResources().getStringArray(R.array.cat_links);
		String url = urls[position];
        listener.onCategorySelected(url);
	}
}
