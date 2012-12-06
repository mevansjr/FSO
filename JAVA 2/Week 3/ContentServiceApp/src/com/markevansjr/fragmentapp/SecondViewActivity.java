package com.markevansjr.fragmentapp;


import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class SecondViewActivity extends Activity {
	
	String _passedRecipeData;
	String _passedTitle;
	String _passedSource;
	String _passedUrl;
	String _passedRating;
	String _passedImgUrl;

	@SuppressLint("SetJavaScriptEnabled")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
			finish();
			
			return;
		}

		setContentView(R.layout.secondview_activity);
		
		//Passed Data from MainFragment
		Intent i = getIntent();
		_passedRecipeData = i.getStringExtra("RecipeData");
		_passedTitle = i.getStringExtra("RecipeTitle");
		_passedUrl = i.getStringExtra("RecipeUrl");
		_passedRating = i.getStringExtra("RecipeRating");
		_passedImgUrl = i.getStringExtra("RecipeImageUrl");
		
		TextView tv = (TextView) findViewById(R.id.text_view_10);
		tv.setText(_passedTitle+"\n\n"+_passedUrl+"\n\n"+_passedRating);
		new DownloadImageTask((ImageView) findViewById(R.id.image_view))
        .execute(_passedImgUrl);
	}
	
//	 @Override
//	 protected void onActivityResult(int requestCode, int resultCode, Intent data) {
//	  super.onActivityResult(requestCode, resultCode, data);
//	  if(resultCode==RESULT_OK && requestCode==1){
//	   String returned = data.getStringExtra("url");
//	   Intent intent = new Intent(getApplicationContext(), MainActivity.class);
//	   intent.putExtra("rurl", returned);
//	   setResult(RESULT_OK, intent);
//	   finish();
//	  }
//	 }

}
