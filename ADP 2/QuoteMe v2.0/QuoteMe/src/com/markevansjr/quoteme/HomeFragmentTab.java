package com.markevansjr.quoteme;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.markevansjr.quoteme.lib.FileStuff;
import com.markevansjr.quoteme.lib.MainListener;
import com.markevansjr.quoteme.lib.QuoteList;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.graphics.Typeface;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

@SuppressLint("HandlerLeak")
public class HomeFragmentTab extends Fragment{
	QuoteList _quoteList = null;
	ArrayList<String> _data = new ArrayList<String>();
	ArrayList<String> _quotes = new ArrayList<String>();
	ArrayList<String> _authors = new ArrayList<String>();
	static TextView _tv;
	static ArrayList<String> _recentQuote = new ArrayList<String>();
	HashMap<String, String> _recent = new HashMap<String, String>();
	ArrayList<Map<String, String>> _newdata;
	static String _theQuote;
	static String _theAuthor;
	String _stored;
	String _fullQuote;
	String _fullQuoteStr;
	String _fullSourceStr;
	List<Map<String, String>> _data2;
	View _view;
	static Button _btn_save;
	Button _btn_delete;
	JSONObject json;
	String r;
	MainListener listener;
	String _savedQuote;
	public static String _savedButton = "YES";
	String _theId;
	String _checkNull;
	String _savedQuote2;
	String _currentQuote;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
	}
	
    @Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		_view = inflater.inflate(R.layout.home_frag, container, false);
		getRecents();
		_tv = (TextView) _view.findViewById(R.id.home_quote_text);
		_tv.setMovementMethod(new ScrollingMovementMethod());
		Typeface tf = Typeface.createFromAsset(_view.getContext().getAssets(), "fonts/m-reg.ttf");
		Typeface tf2 = Typeface.createFromAsset(_view.getContext().getAssets(), "fonts/m-bold.ttf");
		_tv.setTypeface(tf);
		_btn_save = (Button) _view.findViewById(R.id.home_save_btn);
		_btn_delete = (Button) _view.findViewById(R.id.home_delete_btn);
		_btn_save.setTypeface(tf2);
		_btn_delete.setTypeface(tf2);
		_savedButton = FileStuff.readStringFile(_view.getContext(), "buttonSave", false);
		Log.i("------TAG BUTTON SAVE CHECK-------", _savedButton);
		_theId = FileStuff.readStringFile(_view.getContext(), "theId", false);
		Log.i("------TAG MAIN ID-------", _theId);
		
		ConnectivityManager connec = (ConnectivityManager)_view.getContext().getSystemService(Context.CONNECTIVITY_SERVICE);
		_savedQuote = FileStuff.readStringFile(_view.getContext(), "savedQuote", false);
		Log.i("------TAG MAIN SAVE QUOTE-------", _savedQuote);
		_savedQuote2 = FileStuff.readStringFile(_view.getContext(), "QOD", false);
		Log.i("------TAG MAIN QOD-------", _savedQuote2);
		
			if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
					(connec.getNetworkInfo(0).isAvailable() == true)){
				_tv.setText(_savedQuote);
			} else {
    			Toast toast = Toast.makeText(_view.getContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
    			toast.show();
    		}
				
				// Save Button
				_btn_save.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View v) {
						if (_savedButton.equals("YES")){
						ConnectivityManager connec = (ConnectivityManager)_view.getContext().getSystemService(Context.CONNECTIVITY_SERVICE);
						if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
								(connec.getNetworkInfo(0).isAvailable() == true)){
							ParseQuery query = new ParseQuery("savedObjects");
							Log.i("TAG GET PARSE", "SHOW ALL");
							query.findInBackground(new FindCallback() {
							public void done(List<ParseObject> objects, ParseException e) {
								if (e == null) {
									_recentQuote.clear();
					 
										for(int ii=0;ii<objects.toArray().length;ii++){							
											ParseObject s = objects.get(ii);
											_recent = new HashMap<String, String>(2);
											String q = s.getString("savedQuote");
											_recent.put(q, q);
										}
										
										String find = MainActivity._finalQuote;
										Log.i("TAG CHECK CURRENT MAIN", find);
										for(String key : _recent.keySet()) {
											Log.i("TAG CHECK LOOP", key);
											_recentQuote.add(key);
										}
										FileStuff.storeObjectFile(_view.getContext(), "recent", _recentQuote, false);
										
										if (_recentQuote.contains(find)){
											Toast toast = Toast.makeText(_view.getContext(), "QUOTE ALREADY SAVED", Toast.LENGTH_SHORT);
											toast.show();
										} else {
											ParseObject savedFavObject = new ParseObject("savedObjects");
											savedFavObject.put("savedQuote", MainActivity._finalQuote);
											savedFavObject.put("savedAuthor", MainActivity._finalAuthor);
											savedFavObject.saveInBackground();	
											Toast toast = Toast.makeText(_view.getContext(), "Quote Saved!", Toast.LENGTH_SHORT);
											toast.show();
										}						
									}
								}
							});
						} else {
							Toast toast = Toast.makeText(_view.getContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
							toast.show();
						}
						}
					}
				});
				
				// Delete Button
				_btn_delete.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View v) {
						if (_savedButton.equals("NO")){
						ConnectivityManager connec = (ConnectivityManager)_view.getContext().getSystemService(Context.CONNECTIVITY_SERVICE);
						if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
								(connec.getNetworkInfo(0).isAvailable() == true)){
							
						ParseQuery query = new ParseQuery("savedObjects");
						query.getInBackground(_theId, new GetCallback() {
							@Override
							public void done(ParseObject object, ParseException e) {
								object.deleteInBackground();
								Toast toast = Toast.makeText(_view.getContext(), "Quote Deleted!", Toast.LENGTH_SHORT);
								toast.show(); 
							}
						});
						
						_recentQuote.clear();
						
					} else {
						Toast toast = Toast.makeText(_view.getContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
						toast.show();
					}
				
					} else {
						Toast toast = Toast.makeText(_view.getContext(), "DELETE IS DISABLED", Toast.LENGTH_SHORT);
						toast.show();
					}
					}
				});

	    return _view;
	}
    
  @SuppressWarnings("unchecked")
	private void getRecents() {
  	Object content = FileStuff.readObjectFile(_view.getContext(), "recent", false);
		if (content == null) {
			Log.i("RECENTS", "NO RECENTS FOUND");
			_recentQuote = new ArrayList<String>();
		} else {
			_recentQuote = (ArrayList<String>) content;
		}
  }
    
    @Override
	public void onAttach(Activity activity) {
		super.onAttach(activity);
		try{
			listener = (MainListener) activity;
		} catch (ClassCastException e) {
			throw new ClassCastException(activity.toString() + " must implement MainListener");
		}
	}
}
