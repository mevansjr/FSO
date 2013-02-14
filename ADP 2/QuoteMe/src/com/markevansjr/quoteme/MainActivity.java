package com.markevansjr.quoteme;

import java.lang.reflect.Field;
import java.util.ArrayList;

import android.os.Bundle;
import android.app.ActionBar;
import android.app.ActionBar.Tab;
import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewConfiguration;
import android.widget.TextView;

public class MainActivity extends Activity {
	
	QuoteList _quoteList = null;
	ArrayList<String> _data = new ArrayList<String>();
	ArrayList<String> _quotes = new ArrayList<String>();
	ArrayList<String> _authors = new ArrayList<String>();
	TextView _tv;
	static String _theQuote;
	static String _theAuthor;
	public static String _passed;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
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
	        //click on about item
	    	Log.i("TAG", "HOME");
	    	bar.selectTab(tabHome);
	        break;
	    case R.id.search_item:
	        //click on about item
	    	Log.i("TAG", "SEARCH");
	    	bar.selectTab(tabSearch);
	        break;
	    case R.id.saved_item:
	        //click on about item
	    	Log.i("TAG", "SAVED");
	    	bar.selectTab(tabSaved);
	        break;
	    }
	    return true;
	}

}
