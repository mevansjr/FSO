package com.markevansjr.quoteme;

import java.net.URL;
import java.util.ArrayList;
import java.util.Map;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.json.JSONException;
import org.json.JSONObject;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

import com.parse.ParseObject;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
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
	TextView _tv;
	ArrayList<Map<String, String>> _newdata;
	static String _theQuote;
	static String _theAuthor;
	String _stored;
	String _fullQuote;
	String _fullQuoteStr;
	String _fullSourceStr;
	View _view;
	Button _btn;
	JSONObject json;
	String r;
	MainListener listener;
	
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
		_btn = (Button) _view.findViewById(R.id.home_save_btn);
		getQuotes("");
		
		_btn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				ParseObject savedFavObject = new ParseObject("savedObjects");
				savedFavObject.put("savedQuote", _fullQuoteStr);
				savedFavObject.put("savedAuthor", _fullSourceStr);
				savedFavObject.saveInBackground();	
				Toast toast = Toast.makeText(_view.getContext(), "Quote Saved!", Toast.LENGTH_SHORT);
				toast.show();
			}
		});
	    return _view;
	}
    
    public void getQuotes(String item){
		Toast toast = Toast.makeText(_view.getContext(), "LOADING DATA..", Toast.LENGTH_SHORT);
		toast.show();
		
		// Searched Item and Messenger is passed to GetService
		Messenger messenger = new Messenger(theHandler);
		Intent i = new Intent(_view.getContext(), GetService.class);
		i.putExtra("item", item);
		i.putExtra("messenger", messenger);
		getActivity().startService(i);	
    }
    
    // This receives the message from the service
 	Handler theHandler = new Handler(){
 		@SuppressLint("DefaultLocale")
 		public void handleMessage(Message message){
 			Object path = message.obj;
 			if (message.arg1 == 0 && path != null){
 				String a = (String) message.obj.toString();
 				try{
 					json = new JSONObject(a);
 			        Log.i("THE RESULTS", json.toString());
 					String thequote = json.getString("quote");
 					_fullQuoteStr = '"'+thequote+'"';
 					String source = json.getString("source");
 					String sourceFull = "-"+source.substring(0,1).toUpperCase()+source.substring(1,source.length());
 					_fullSourceStr = source.substring(0,1).toUpperCase()+source.substring(1,source.length());
 					_tv.setText(thequote+"\r\n\n"+sourceFull);
 					listener.pass(_tv.getText().toString());
 				} catch (JSONException e){
 					Log.e("JSON", "JSON OBJECT EXCEPTION");
 					Toast toast = Toast.makeText(_view.getContext(), "NO RESULTS!", Toast.LENGTH_LONG);
 					toast.show();
 				}
 			}
 		}
 	};
    
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
