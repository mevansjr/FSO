package com.markevansjr.quoteme;

import java.util.ArrayList;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class ImageAdapter extends BaseAdapter {
	private Context context;
	private ArrayList<Map<String, String>> _data = new ArrayList<Map<String, String>>();
 
	public ImageAdapter(Context context, ArrayList<Map<String, String>> objects) {
		this.context = context;
		this._data = objects;
	}
 
	public View getView(int position, View convertView, ViewGroup parent) {
 
		LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
 
		View gridView;
 
		if (convertView == null) {
 
			gridView = new View(context);
 
			// get layout from mobile.xml
			gridView = inflater.inflate(R.layout.custom_grid_item, null);
 
			// set value into textview
			TextView textView = (TextView) gridView
					.findViewById(R.id.grid_item_label);
			try{
				JSONObject o = (JSONObject) _data.get(position);
				textView.setText(o.getString("savedQuote"));
				Log.i("TAG QUOTE GRID", o.getString("savedQuote"));
			} catch (JSONException e){
					Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
 
			// set image based on selected text
			ImageView imageView = (ImageView) gridView.findViewById(R.id.grid_item_image);
			imageView.setImageResource(R.drawable.ic_newpageicon);
 
		} else {
			gridView = (View) convertView;
		}
 
		return gridView;
	}
 
	@Override
	public int getCount() {
		return _data.toArray().length;
	}
 
	@Override
	public Object getItem(int position) {
		return null;
	}
 
	@Override
	public long getItemId(int position) {
		return 0;
	}
 
}