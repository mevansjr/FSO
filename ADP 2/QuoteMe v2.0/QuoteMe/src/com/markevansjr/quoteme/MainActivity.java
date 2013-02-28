package com.markevansjr.quoteme;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import com.markevansjr.quoteme.lib.FileStuff;
import com.markevansjr.quoteme.lib.GetService;
import com.markevansjr.quoteme.lib.MainListener;
import com.markevansjr.quoteme.lib.QuoteList;
import com.parse.Parse;

import android.net.ConnectivityManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.ActionBar.Tab;
import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewConfiguration;
import android.widget.TextView;
import android.widget.Toast;

@SuppressLint("HandlerLeak")
public class MainActivity extends Activity implements MainListener {
	
	QuoteList _quoteList = null;
	ArrayList<String> _data = new ArrayList<String>();
	ArrayList<String> _quotes = new ArrayList<String>();
	ArrayList<String> _authors = new ArrayList<String>();
	TextView _tv;
	static String _theQuote;
	static String _theAuthor;
	public static String _passed;
	public static String _sharedQuote = null;
	public static String _passedObjStr;
	public static String _passedQuote;
	public static String _passedAuthor;
	public static String _finalQuote;
	public static String _finalAuthor;
	HashMap<String, String> _recent = new HashMap<String, String>();
	ArrayList<String> _recentTitle = new ArrayList<String>();
	String currentQuote = null;

	
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		// Initialize Parse
		Parse.initialize(this, "AzORciWSbRjYRJ44OTDjmAufXcn7H87qXcz2wrKQ", "TBfaHCiVKpTQ5PvNgCj2zg8SHO8viYjTDuOCPVab");
		
		// Set Save Condition
		FileStuff.storeStringFile(getBaseContext(), "buttonSave", "YES", false);
		
		// Generate Quote
		ConnectivityManager connec = (ConnectivityManager)getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE);
		if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
				(connec.getNetworkInfo(0).isAvailable() == true)){
			getQuote("");
		} else {
			Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
			toast.show();
		}
		
		// Set ActionBar
		ActionBar bar = getActionBar();
	    
	    bar.setDisplayShowCustomEnabled(true);
	    bar.setDisplayShowTitleEnabled(false);
        bar.setDisplayShowHomeEnabled(true);
        bar.setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM, ActionBar.DISPLAY_SHOW_CUSTOM);
        bar.setCustomView(R.layout.custom);
        
        View homeIcon = findViewById(android.R.id.home);
        ((View) homeIcon.getParent()).setVisibility(View.GONE);
        
        bar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
        
	    ActionBar.Tab tabHome = bar.newTab().setText("Home");
	    ActionBar.Tab tabSearch = bar.newTab().setText("Search");
	    ActionBar.Tab tabSaved = bar.newTab().setText("Saved");

	    Fragment fragmentA = new HomeFragmentTab();
	    Fragment fragmentB = new SearchFragmentTab();
	    Fragment fragmentC = new SavedFragmentTab();

	    tabHome.setTabListener(new MyTabsListener(fragmentA));
	    tabSearch.setTabListener(new MyTabsListener(fragmentB));
	    tabSaved.setTabListener(new MyTabsListener(fragmentC));

	    bar.addTab(tabHome);
	    bar.addTab(tabSearch);
	    bar.addTab(tabSaved);
	    
	    try {
	        ViewConfiguration config = ViewConfiguration.get(this);
	        Field menuKeyField = ViewConfiguration.class.getDeclaredField("sHasPermanentMenuKey");
	        if(menuKeyField != null) {
	            menuKeyField.setAccessible(true);
	            menuKeyField.setBoolean(config, false);
	        }
	    } catch (Exception ex) {
	        // Ignore
	    }
	}
	
	public void getQuote(String item){
		//Toast toast = Toast.makeText(_view.getContext(), "LOADING DATA..", Toast.LENGTH_SHORT);
		//toast.show();
		
		// Searched Item and Messenger is passed to GetService
		Messenger messenger = new Messenger(theHandler);
		Intent i = new Intent(getApplicationContext(), GetService.class);
		i.putExtra("item", item);
		i.putExtra("messenger", messenger);
		startService(i);	
    }
    
    // This receives the message from the service
 	Handler theHandler = new Handler(){
 		@SuppressLint("DefaultLocale")
 		public void handleMessage(Message message){
 			Object path = message.obj;
 			if (message.arg1 == 0 && path != null){
 				String a = (String) message.obj.toString();
 				try{
 					JSONObject json = new JSONObject(a);
 			        Log.i("THE RESULTS", json.toString());
 					String thequote = json.getString("quote");
 					String source = json.getString("source");
 					String sourceFull = "-"+source.substring(0,1).toUpperCase()+source.substring(1,source.length());
 					_finalQuote = thequote;
 					_finalAuthor = sourceFull;
 					HomeFragmentTab._tv.setText(thequote+"\r\n\n"+sourceFull);
 					FileStuff.storeStringFile(getApplicationContext(), "QOD", thequote+"\r\n\n"+sourceFull, false);
 					//listener.pass(_tv.getText().toString(), "YES", "API", 1);
 				} catch (JSONException e){
 					Log.e("JSON", "JSON OBJECT EXCEPTION");
 					Toast toast = Toast.makeText(getApplicationContext(), "NO RESULTS!", Toast.LENGTH_LONG);
 					toast.show();
 				}
 			}
 		}
 	};
	
	protected class MyTabsListener implements ActionBar.TabListener {

	    private Fragment fragment;

	    public MyTabsListener(Fragment fragment) {
	        this.fragment = fragment;
	    }

	    public void onTabReselected(Tab tab, FragmentTransaction ft) {
	    }

	    public void onTabSelected(Tab tab, FragmentTransaction ft) {
	        ft.add(R.id.fragment_container, fragment, null);
	    }

	    public void onTabUnselected(Tab tab, FragmentTransaction ft) {
	        // some people needed this line as well to make it work: 
	        ft.remove(fragment);
	    }
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu); 
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
		ActionBar bar = getActionBar();
        
	    ActionBar.Tab tabHome = bar.getTabAt(0);
	    ActionBar.Tab tabSearch = bar.getTabAt(1);
	    ActionBar.Tab tabSaved = bar.getTabAt(2);
	    
	    switch(item.getItemId()) {
	    case R.id.home_item:
	        //click on hometab item
	    	Log.i("TAG", "HOME");
	    	bar.selectTab(tabHome);
	        break;
	    case R.id.search_item:
	        //click on searchtab item
	    	Log.i("TAG", "SEARCH");
	    	bar.selectTab(tabSearch);
	        break;
	    case R.id.saved_item:
	        //click on savedtab item
	    	Log.i("TAG", "SAVED");
	    	bar.selectTab(tabSaved);
	        break;
	    case R.id.share_item:
	        //click on share item
	    	ConnectivityManager connec = (ConnectivityManager)getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE);
			if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
					(connec.getNetworkInfo(0).isAvailable() == true)){
				_sharedQuote = HomeFragmentTab._tv.getText().toString();
				Intent sharingIntent = new Intent(Intent.ACTION_SEND);
				sharingIntent.setType("text/plain");
				sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, _sharedQuote);
				sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "QuoteMe - Quote");
				startActivity(Intent.createChooser(sharingIntent, "Share using.."));
				Log.i("TAG", "SHARE");
				//finish();
			} else {
				Toast toast = Toast.makeText(getApplicationContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
				toast.show();
			}
	        break;
	    }
	    return true;
	}

	@Override
	public void pass(String pass, String buttonSave, String id, int number) {
		ActionBar bar = getActionBar();
	    ActionBar.Tab tabHome = bar.getTabAt(0);
		//_sharedQuote = pass;
		FileStuff.storeStringFile(getBaseContext(), "savedQuote", pass, false);
		FileStuff.storeStringFile(getBaseContext(), "buttonSave", buttonSave, false);
		FileStuff.storeStringFile(getBaseContext(), "theId", id, false);
		FileStuff.storeStringFile(getBaseContext(), "checkNull", String.valueOf(number), false);
		HomeFragmentTab._tv.setText(pass);
		bar.selectTab(tabHome);
	}

	@Override
	public void passForSearch(String objStr, String quote, String author) {
		_finalQuote = quote;
		_finalAuthor = author;
	}
	
	@Override
	public void passForSaved(String objStr, String quote, String author, String id) {
		_finalQuote = quote;
		_finalAuthor = author;
	}
	
	@Override
	public void checkForQuote(String thequote, String theauthor) {
		//
	}

}
