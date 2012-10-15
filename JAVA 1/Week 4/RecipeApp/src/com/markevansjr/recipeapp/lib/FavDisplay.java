package com.markevansjr.recipeapp.lib;

import java.util.ArrayList;

import com.markevansjr.recipeapp.R;

import android.content.Context;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.AdapterView;
import android.util.Log;
import android.view.View;

public class FavDisplay extends LinearLayout {

	Spinner _list;
	Context _context;
	String _readFav;
	ArrayList<String> _recipes = new ArrayList<String>();
	
	public FavDisplay(Context context, ArrayList<String> array){
		super(context);
		_context = context;
		_recipes = array;
		
		LayoutParams lp;
		
		_list = new Spinner(_context);
		lp = new LayoutParams(0, LayoutParams.WRAP_CONTENT, 1.0f);
		_list.setLayoutParams(lp);
		ArrayAdapter<String> listAdapter = new ArrayAdapter<String>(_context, R.layout.spinner, _recipes);
		listAdapter.setDropDownViewResource(R.layout.spinnerdropdown);
		_list.setAdapter(listAdapter);
		_list.setOnItemSelectedListener(new OnItemSelectedListener() {
			@Override
			public void onItemSelected(AdapterView<?> parent, View v, int pos, long id){
				Log.i("FAV SELECTED", parent.getItemAtPosition(pos).toString());
			}
			
			@Override
			public void onNothingSelected(AdapterView<?> parent){
				Log.i("FAV SELECTED", "HOME");
			}
		});
		
		updateFavorites();
		
		this.addView(_list);
		
		lp = new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		this.setLayoutParams(lp);
	}
	
	private void updateFavorites(){
		//_readFav = getFav();
		//_recipes.add(_readFav);
		//_recipes.add("Chicken");
		//_recipes.add("Turkey");
	}
}
