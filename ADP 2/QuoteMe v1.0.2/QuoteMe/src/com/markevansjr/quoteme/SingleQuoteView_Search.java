package com.markevansjr.quoteme;

import java.util.ArrayList;

import com.markevansjr.quoteme.lib.QuoteList;
import com.parse.ParseObject;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class SingleQuoteView_Search extends Activity{
	
	QuoteList _quoteList = null;
	ArrayList<String> _data = new ArrayList<String>();
	ArrayList<String> _quotes = new ArrayList<String>();
	ArrayList<String> _authors = new ArrayList<String>();
	TextView _tv;
	static String _theQuote;
	static String _theAuthor;
	public static String _passed;
	public static String _sharedQuote;
	public static String _passedObjStr;
	String _passedQuote;
	String _passedAuthor;
	Button _btn;
	String _passedObj;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.single_quote_view);
		
		_tv = (TextView) findViewById(R.id.singleview_quote_text);
		_tv.setMovementMethod(new ScrollingMovementMethod());
		_btn = (Button) findViewById(R.id.singleview_save_btn);
		
		Intent i = getIntent();
		_passedObj = i.getStringExtra("passedString");
		_passedQuote = i.getStringExtra("passedQuote");
		_passedAuthor = i.getStringExtra("passedAuthor");
		_sharedQuote = _passedQuote+"\r\n\n"+"-"+_passedAuthor;
		_tv.setText(_sharedQuote);
		Log.i("SINGLE", _passedObj);
		
		_btn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				ParseObject savedFavObject = new ParseObject("savedObjects");
				savedFavObject.put("savedQuote", _passedQuote);
				savedFavObject.put("savedAuthor", _passedAuthor);
				savedFavObject.saveInBackground();	
				Toast toast = Toast.makeText(getApplicationContext(), "Quote Saved!", Toast.LENGTH_SHORT);
				toast.show();
			}
		});
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu); 
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
	    
	    switch(item.getItemId()) {
	    case R.id.home_item:
	        //click on hometab item
	    	Intent intent = new Intent();
	        intent.setClass(this, MainActivity.class);
	        startActivity(intent);
	    	Log.i("TAG", "HOME");
	        break;
	    case R.id.search_item:
	        //click on searchtab item
	    	Log.i("TAG", "SEARCH");
	    	Intent intent2 = new Intent();
	        intent2.setClass(this, MainActivity.class);
	    	startActivity(intent2);
	        break;
	    case R.id.saved_item:
	        //click on savedtab item
	    	Log.i("TAG", "SAVED");
	    	Intent intent3 = new Intent();
	        intent3.setClass(this, MainActivity.class);
	    	startActivity(intent3);
	        break;
	    case R.id.share_item:
	        //click on share item
	    	Intent sharingIntent = new Intent(Intent.ACTION_SEND);
	    	sharingIntent.setType("text/plain");
	    	sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, _sharedQuote);
	    	sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "QuoteMe - Quote");
	    	startActivity(Intent.createChooser(sharingIntent, "Share using.."));
	    	Log.i("TAG", "SHARE");
	    	finish();
	        break;
	    }
	    return true;
	}

}
