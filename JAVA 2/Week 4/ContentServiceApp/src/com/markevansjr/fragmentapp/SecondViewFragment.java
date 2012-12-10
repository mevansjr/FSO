package com.markevansjr.fragmentapp;

import java.util.HashMap;

import com.parse.ParseObject;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

public class SecondViewFragment extends Fragment {
	
	String _imageUrl;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View view = inflater.inflate(R.layout.second_view, container, false);
		return view;
	}

	@SuppressLint("SetJavaScriptEnabled")
	public void setInfo(HashMap<String, String> data) {
		TextView tv = (TextView) getView().findViewById(R.id.text_view_10);
		final String title = data.get("title");
		final String url = data.get("pf_url");
		final String source = data.get("source_name");
		final String rating = data.get("rating");
		_imageUrl = data.get("source_img");
		tv.setText(title+"\n\n"+url+"\n\n"+rating);
		new DownloadImageTask((ImageView) getView().findViewById(R.id.image_view))
        .execute(_imageUrl);
		
		final String theCheck = data.get("check");
		
		// Set Button
				Button btn = (Button) getView().findViewById(R.id.save_btn);
				
				if (theCheck.equals("true") || theCheck == "true"){
					btn.setVisibility(View.INVISIBLE);
				} else {
					btn.setOnClickListener(new OnClickListener() {
						@Override
						public void onClick(View v) {
							// Searched Recipe is saved in online database on PARSE
							ParseObject savedFavObject = new ParseObject("savedFavObject");
							savedFavObject.put("title", title);
							savedFavObject.put("source", source);
							savedFavObject.put("recipe_url", url);
							savedFavObject.put("rating", rating);
							savedFavObject.put("img_url", _imageUrl);
							savedFavObject.saveInBackground();
							Log.i("fav::", title+" was SAVED.");
						}
					}); 
				}
	}
}
