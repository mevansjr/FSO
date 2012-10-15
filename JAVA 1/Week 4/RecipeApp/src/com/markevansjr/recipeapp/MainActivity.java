package com.markevansjr.recipeapp;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.AsyncTask;
import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;
import android.webkit.WebView;

import com.markevansjr.recipeapp.lib.FavDisplay;
import com.markevansjr.recipeapp.lib.FileStuff;
import com.markevansjr.recipeapp.lib.RecipeDisplay;
import com.markevansjr.recipeapp.lib.WebStuff;
import com.markevansjr.recipeapp.lib.SearchForm;

@SuppressLint("NewApi")
public class MainActivity extends Activity {
	LinearLayout _appLayout;
	Context _context;
	LinearLayout _search;
	Boolean connected = false;
	RecipeDisplay _recipedisplay;
    LinearLayout linearLayout;
	ListView listView;
	FavDisplay _favorites;
	WebView webview;
	TextView t1;
	TextView t2;
	ArrayList<String> _ra = new ArrayList<String>();
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //ActionBar actionBar = getActionBar();
        //actionBar.hide();
        
        _appLayout = new LinearLayout(this);
        _context = this;
        _ra = getFav();
        Log.i("FAV READ", _ra.toString());
        
//        LinearLayout navll = new LinearLayout(this);
//        Drawable f = getResources().getDrawable(R.drawable.navbar);
//        navll.setBackground(f);
//        _appLayout.addView(navll,new LinearLayout.LayoutParams(
//        LinearLayout.LayoutParams.MATCH_PARENT,
//        LinearLayout.LayoutParams.WRAP_CONTENT));
        
        // SEARCH VIEW
        _search = SearchForm.setup(_context, "Find Recipes", "Search");
        final EditText textField = (EditText) _search.findViewById(1);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
        Button searchBtn = (Button) _search.findViewById(2);
        searchBtn.setOnClickListener(new OnClickListener(){
        	@Override
        	public void onClick(View v){
        		// HIDES KEYBOARD
        		InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        		imm.hideSoftInputFromWindow(textField.getWindowToken(), 0);
        		
        		// CALLS SEARCH
        		doSearch(textField.getText().toString());
        	}
        });   
        //Drawable e = getResources().getDrawable(R.drawable.newcellbg);
        _search.setBackgroundColor(Color.DKGRAY);
        //_search.setPadding(5, 15, 5, 5);
        _appLayout.addView(_search);
        
        // DETECT NETWORK
        connected = WebStuff.getConnectionStatus(_context);
        if(connected){
        	Log.i("NETWORK CONNECTION", WebStuff.getConnectionType(_context));
        }
        
        // SET BACKGROUND IMAGE
        //Drawable d = getResources().getDrawable(R.drawable.welcome);
        //_appLayout.setBackground(d);
        
        // WEB VIEW
        webview = new WebView(this);
        webview.loadUrl("http://www.markevansjr.com/android.html");
        webview.setInitialScale(1);
        webview.getSettings().setBuiltInZoomControls(true);
        webview.getSettings().setUseWideViewPort(true);
        webview.setScrollBarStyle(WebView.SCROLLBARS_OUTSIDE_OVERLAY);
        webview.setScrollbarFadingEnabled(false);
        webview.setId(7);
        webview.setPadding(0, 5, 0, 5);
        RelativeLayout rl2 = new RelativeLayout(this);
        RelativeLayout.LayoutParams lay2 = new RelativeLayout.LayoutParams(
            RelativeLayout.LayoutParams.MATCH_PARENT, 
            300);
        lay2.addRule(RelativeLayout.CENTER_IN_PARENT);
        rl2.addView(webview, lay2);
        _appLayout.addView(rl2);
        
        // LIST VIEW
        listView = new ListView(this);
        listView.setBackgroundColor(Color.LTGRAY);
        listView.setId(5);
        //_appLayout.addView(listView,new LinearLayout.LayoutParams(
        //LinearLayout.LayoutParams.MATCH_PARENT,
        //LinearLayout.LayoutParams.WRAP_CONTENT));
        _appLayout.setOrientation(LinearLayout.VERTICAL);
        _appLayout.setBackgroundColor(Color.BLACK);
        
        // ADD FAVS
        _favorites = new FavDisplay(_context, _ra);
        _favorites.setBackgroundColor(Color.DKGRAY);
        _favorites.setGravity(Gravity.BOTTOM);
        RelativeLayout rl = new RelativeLayout(this);
        RelativeLayout.LayoutParams lay = new RelativeLayout.LayoutParams(
            RelativeLayout.LayoutParams.MATCH_PARENT, 
            RelativeLayout.LayoutParams.WRAP_CONTENT);
        lay.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        rl.addView(listView);
        rl.addView(_favorites, lay);
        _appLayout.addView(rl);
        
        setContentView(_appLayout);
    }
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
	    if ((keyCode == KeyEvent.KEYCODE_BACK) && webview.canGoBack()) {
	        webview.goBack();
	        return true;
	    }
	    return super.onKeyDown(keyCode, event);
	}
	
	public void addFav(View view) {
	    Log.e("DO", "SOMETHING");
	}

	private ArrayList<String> getFav() {
		String stored = FileStuff.readStringFile(_context, "temp", true);
		
		ArrayList<String> fav = new ArrayList<String>();
		fav.add("Select Favorite");
		if(stored == null){
			Log.i("PROBLEM", "NO FAV FILE FOUND");
		} else {
			String[] favs = stored.split(",");
			for(int i=0; i<favs.length; i++){
				fav.add(favs[i]);
			}
		}
		return fav;
	}

	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
	
	@SuppressWarnings("unused")
	private void doSearch(String item){
		String apiURL = "http://api.punchfork.com/recipes?key=13c42c860b3e65ae&q="+item+"&count=3";
		String qs;
		try{
			qs = URLEncoder.encode(apiURL, "UTF-8");
		} catch (Exception e){
			Log.e("BAD URL", "ENCODING PROBLEM");
			qs = "";
		}
		URL finalURL;
		try{
			finalURL = new URL(apiURL);
			RecipeRequest rr = new RecipeRequest();
			rr.execute(finalURL);
		} catch (MalformedURLException e){
			Log.e("BAD URL", "MALFORMED URL");
			finalURL = null;
		}
	}
	
	private class RecipeRequest extends AsyncTask<URL, Void, String>{
		@Override
		protected String doInBackground(URL... urls){
			String response = "";
			for(URL url: urls){
				response = WebStuff.getURLStringResponse(url);
			}
			return response;
		}
		
		@Override
		protected void onPostExecute(String result){
			Log.i("URL RESPONSE", result);
			try{
				JSONObject json = new JSONObject(result);
				JSONArray results = json.getJSONArray("recipes");
				
				List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
		        for(int i=0;i<results.length();i++){							
					JSONObject s = results.getJSONObject(i);
					Map<String, String> map = new HashMap<String, String>(2);
					map.put("title", s.getString("title"));
				    map.put("source_name", s.getString("source_name"));
				    map.put("source_url", s.getString("source_url"));
				    data.add(map);
				}
		        
		        //_history.put(_varforsearch, results.toString());
			    //_history.put(s.getString("title"), results.toString());
				//FileStuff.storeObjectFile(_context, "history", _history, false);
				//FileStuff.storeStringFile(_context, "temp", s.toString(), true);
				Log.i("THE RESULTS", results.toString());
				
				final ListView tlv = (ListView) listView.findViewById(5);
				SimpleAdapter adapter = new SimpleAdapter(_context, data,
                        R.layout.list,
                        new String[] {"title", "source_name", "source_url"},
                        new int[] {android.R.id.text1,
                                   android.R.id.text2});
				tlv.setAdapter(adapter);
		        
				tlv.setOnItemClickListener(new OnItemClickListener() {
		        	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
		        		@SuppressWarnings("unchecked")
						HashMap<String, String> o = (HashMap<String, String>) tlv.getItemAtPosition(position);	        		
		        		//Toast.makeText(_context, "URL --> " + o.get("source_url"), Toast.LENGTH_SHORT).show();
		        		
		        		final WebView twv = (WebView) webview.findViewById(7);
		        		twv.loadUrl(o.get("source_url"));
		        		twv.setInitialScale(1);
		        		twv.getSettings().setBuiltInZoomControls(true);
		        		twv.getSettings().setUseWideViewPort(true);
		        		twv.setScrollBarStyle(WebView.SCROLLBARS_OUTSIDE_OVERLAY);
		        		twv.setScrollbarFadingEnabled(false);
		        		
		        		Log.i("LOG", o.get("title"));
		        		_ra.add(o.get("title"));
		        		FileStuff.storeStringFile(_context, "temp", o.get("title"), true);
					}
				});
				
			} catch (JSONException e){
				Log.e("JSON", "JSON OBJECT EXCEPTION");
			}
		}

	
	}
}
