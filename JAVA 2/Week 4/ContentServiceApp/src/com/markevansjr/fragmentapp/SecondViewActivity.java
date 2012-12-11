package com.markevansjr.fragmentapp;

import com.markevansjr.fragmentapp.R;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

@SuppressLint("DefaultLocale")
public class SecondViewActivity extends Activity {
	
	String _passedRecipeData;
	String _passedTitle;
	String _passedSource;
	String _passedUrl;
	String _passedRating;
	String _passedImgUrl;

	@SuppressLint({ "SetJavaScriptEnabled", "DefaultLocale" })
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
			finish();
			
			return;
		}

		setContentView(R.layout.secondview_activity);
		
		
		// Passed Data from MainFragment
		Intent i = getIntent();
		_passedRecipeData = i.getStringExtra("RecipeData");
		_passedTitle = i.getStringExtra("RecipeTitle");
		_passedSource = i.getStringExtra("RecipeSource");
		_passedUrl = i.getStringExtra("RecipeUrl");
		_passedRating = i.getStringExtra("RecipeRating");
		_passedImgUrl = i.getStringExtra("RecipeImageUrl");
		String theCheck = i.getStringExtra("check");
		final String theId = i.getStringExtra("id");
		
		// Set Button
		Button btn = (Button) findViewById(R.id.save_btn);
		
		if (theCheck.equals("true") || theCheck == "true"){
			//btn.setVisibility(View.INVISIBLE);
			btn.setText("Delete");
			btn.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
					ParseQuery query = new ParseQuery("savedFavObject");
					query.getInBackground(theId, new GetCallback() {
						@Override
						public void done(ParseObject object, ParseException e) {
							object.deleteInBackground();
							Toast toast = Toast.makeText(getApplicationContext(), "RECIPE DELETED", Toast.LENGTH_SHORT);
							toast.show();
						}
					});
				}
			});
		} else {
			btn.setText("Save to Favorite");
			btn.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View v) {
					// Searched Recipe is saved in online database on PARSE
					ParseObject savedFavObject = new ParseObject("savedFavObject");
					savedFavObject.put("title", _passedTitle);
					savedFavObject.put("source", _passedSource);
					savedFavObject.put("recipe_url", _passedUrl);
					savedFavObject.put("rating", _passedRating);
					savedFavObject.put("img_url", _passedImgUrl);
					savedFavObject.saveInBackground();
					Toast toast = Toast.makeText(getApplicationContext(), "RECIPE SAVED", Toast.LENGTH_SHORT);
					toast.show();
					Log.i("fav::", _passedTitle+" WAS SAVED.");
				}
			}); 
		}	
	
		// Text view is set and image is loaded from API URL
		TextView tv = (TextView) findViewById(R.id.text_view_10);
		tv.setText(_passedTitle.toUpperCase()+"\n"+"Rating: "+_passedRating);
		ImageView img = (ImageView) findViewById(R.id.image_view);
		new DownloadImageTask(img).execute(_passedImgUrl);
	}
	
	// Calls Saved Favorites Activity
    public void callFavs(View v)
    {
    	Intent i = new Intent(getApplicationContext(), SavedRecipes.class); 
    	startActivity(i);
    }
    
    // Calls Implict Intent
    public void callBrowser(View v)
    {
    	Uri theuri = Uri.parse(_passedUrl);
    	Intent i = new Intent(Intent.ACTION_VIEW, theuri);
    	startActivity(i);
    }
}
