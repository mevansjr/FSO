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

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

@SuppressLint("HandlerLeak")
public class HomeFragmentTab extends Fragment {
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
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
    	//new MyXMLHandlerTask().execute("http://www.stands4.com/services/v2/quotes.php?uid=2619&tokenid=KEuy1TPkbCPFjL8B&searchtype=RANDOM");
  
		_view = inflater.inflate(R.layout.home_frag, container, false);
		getQuotes("");
		_tv = (TextView) _view.findViewById(R.id.home_quote_text);
//		if (_tv.getText().equals(null)){
//			_tv.setText(_stored);
//		} else {
//			_tv.setText(_fullQuote);
//		}
//		
//		_stored = FileStuff.readStringFile(_view.getContext(), "fullquote", false);
//		if (_stored == null){
//			_tv.setText("Test");
//		} else {
//			_tv.setText(_stored);
//		}
		
	    return _view;
	}
    
    public void getQuotes(String item){
//		Toast toast = Toast.makeText(_view.getContext(), "LOADING DATA..", Toast.LENGTH_LONG);
//		toast.show();
		
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
 					JSONObject json = new JSONObject(a);
 			        Log.i("THE RESULTS", json.toString());
 					String thequote = json.getString("quote");
 					String source = json.getString("source");
 					String sourceFull = "-"+source.substring(0,1).toUpperCase()+source.substring(1,source.length());
 					_tv.setText(thequote+"\r\n\n"+sourceFull);
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
}
