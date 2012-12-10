package com.markevansjr.fragmentapp;

import java.util.HashMap;

import com.markevansjr.fragmentapp.R;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class SecondViewFragment extends Fragment {
	
	String _imageUrl;
	Context _context;
	String _title;
	String _url;
	String _source;
	String _rating;
	String _theId;
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
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		_view = inflater.inflate(R.layout.second_view, container, false);
		
		return _view;
	}
	
	// Calls Saved Favorites Activity
    public void callFavs(View v)
    {
    	Intent i = new Intent(getActivity().getApplicationContext(), SavedRecipes.class); 
    	startActivity(i);
    }
    
    // Calls Implict Intent
    public void callBrowser(View v)
    {
    	Uri theuri = Uri.parse("http://punchfork.com/");
    	Intent i = new Intent(Intent.ACTION_VIEW, theuri);
    	startActivity(i);
    }

	@SuppressLint("SetJavaScriptEnabled")
	public void setInfo(HashMap<String, String> data) {
		TextView tv = (TextView) getView().findViewById(R.id.text_view_10);
		_title = data.get("title");
		_url = data.get("pf_url");
		_source = data.get("source_name");
		_rating = data.get("rating");
		_theId = data.get("id");
		_imageUrl = data.get("source_img");
		tv.setText(_title+"\n\n"+_url+"\n\n"+_rating);
		new DownloadImageTask((ImageView) getView().findViewById(R.id.image_view))
        .execute(_imageUrl);
		
		final String theCheck = data.get("check");
		
				// Set Button
				Button btn = (Button) _view.findViewById(R.id.save_btn);
				
				if (theCheck.equals("true") || theCheck == "true"){
					//btn.setVisibility(View.INVISIBLE);
					btn.setText("Delete");
					btn.setOnClickListener(new OnClickListener() {
						@Override
						public void onClick(View v) {
							ParseQuery query = new ParseQuery("savedFavObject");
							query.getInBackground(_theId, new GetCallback() {
								@Override
								public void done(ParseObject object, ParseException e) {
									object.deleteInBackground();
									Toast toast = Toast.makeText(_view.getContext(), "Recipe DELETED.", Toast.LENGTH_SHORT);
									toast.show();
								}
							});
						}
					});
				} else {
					btn.setOnClickListener(new OnClickListener() {
						@Override
						public void onClick(View v) {
							// Searched Recipe is saved in online database on PARSE
							ParseObject savedFavObject = new ParseObject("savedFavObject");
							savedFavObject.put("title", _title);
							savedFavObject.put("source", _source);
							savedFavObject.put("recipe_url", _url);
							savedFavObject.put("rating", _rating);
							savedFavObject.put("img_url", _imageUrl);
							savedFavObject.saveInBackground();
							Toast toast = Toast.makeText(_view.getContext(), "Recipe SAVED.", Toast.LENGTH_SHORT);
							toast.show();
							Log.i("fav::", _title+" was SAVED.");
						}
					}); 
				}
	}
}
