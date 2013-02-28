package com.markevansjr.quoteme;

import java.net.URL;
import java.util.ArrayList;
import java.util.Map;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.json.JSONObject;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

import com.markevansjr.quoteme.lib.FileStuff;
import com.markevansjr.quoteme.lib.MainListener;
import com.markevansjr.quoteme.lib.MyXMLHandler;
import com.markevansjr.quoteme.lib.QuoteList;
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
import android.os.AsyncTask;
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
	ArrayList<Map<String, String>> _newdata;
	static String _theQuote;
	static String _theAuthor;
	String _stored;
	String _fullQuote;
	String _fullQuoteStr;
	String _fullSourceStr;
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
//							if (_tv.getText().toString().equals(_savedQuote)){
//								Toast toast = Toast.makeText(_view.getContext(), "QUOTE ALREADY SAVED", Toast.LENGTH_SHORT);
//								toast.show();
//							} else {
								ParseObject savedFavObject = new ParseObject("savedObjects");
								savedFavObject.put("savedQuote", MainActivity._finalQuote);
								savedFavObject.put("savedAuthor", MainActivity._finalAuthor);
								savedFavObject.saveInBackground();	
								Toast toast = Toast.makeText(_view.getContext(), "Quote Saved!", Toast.LENGTH_SHORT);
								toast.show();
						} else {
							Toast toast = Toast.makeText(_view.getContext(), "NO CONNECTION", Toast.LENGTH_SHORT);
							toast.show();
						}
						}
						
//						} else {
//							Toast toast = Toast.makeText(_view.getContext(), "QUOTE IS ALREADY SAVED", Toast.LENGTH_SHORT);
//							toast.show();
//						}
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
    
    class MyXMLHandlerTask extends AsyncTask<String, Void, QuoteList> {

	    @SuppressWarnings("unused")
		private Exception exception;

	    protected QuoteList doInBackground(String... urls) {
	        try {
	        	URL url= new URL(urls[0]);
	        	// Handling XML
				SAXParserFactory spf = SAXParserFactory.newInstance();
				SAXParser sp = spf.newSAXParser();
				XMLReader xr = sp.getXMLReader();

				// Create handler to handle XML Tags (extends DefaultHandler)
				MyXMLHandler myXMLHandler = new MyXMLHandler();
				xr.setContentHandler((ContentHandler) myXMLHandler);
				xr.parse(new InputSource(url.openStream()));
	            return MyXMLHandler.getSitesList();
	        } catch (Exception e) {
	            this.exception = e;
	            return null;
	        }
	    }

	    protected void onPostExecute(QuoteList quoteList) {
	    	_quoteList = quoteList;

			Log.i("TAG Q SIZE", String.valueOf(_quoteList.getQuote().size()));
			
			// Stores XML Response into Arraylist - _data
			for (int i = 0; i < _quoteList.getQuote().size(); i++) {
				_data.add(_quoteList.getQuote().get(i));
			}
			 
			// Separates Quote and Author to its own Arraylist
			for (int j=0; j < _data.size(); j++)
			{
				if (j % 2 != 0) {
					String author = _data.get(j);
					_authors.add(author);
				} else {
					String quote = _data.get(j);
					_quotes.add(quote);
				}
			}
			
			// Logs out Quote Array - _quotes
			for (int k=0; k < _quotes.size(); k++){
				_theQuote = _quotes.get(k);
			}
			
			// Logs out Author Array - _authors
			for (int l=0; l < _authors.size(); l++){
				_theAuthor = _authors.get(l);
			}
			
			_fullQuote = _theQuote+"\r\n\n"+" -"+_theAuthor;
			Log.i("TAG FULL QUOTE", _fullQuote);
			FileStuff.storeStringFile(_view.getContext(), "fullquote", _fullQuote, false);
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
