package com.markevansjr.advancedfeatures;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.VideoView;
import android.widget.AdapterView.OnItemClickListener;

public class Home extends Activity {
	String _btxt;
	MediaPlayer _mp;
	Button _btn1;
	VideoView _vv;
	Context _context;
	Notification _notification;
	String _gpsMsg;
	EditText _et;
	double latitude;
	double longitude;
	ListView _lv;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home);
		_context = this;
		_lv = (ListView) findViewById(R.id.listView1);
	    
		//// GROUP TWO <---------------------- ////
    	GPSTracker gps = new GPSTracker(Home.this);
       	if(gps.canGetLocation()){
       		latitude = gps.getLatitude();
            longitude = gps.getLongitude();
            _gpsMsg ="GPS - Lat: "+latitude+" Lon: "+longitude;
            
       	} else {
            gps.showSettingsAlert();
        }
		
		//// GROUP THREE <---------------------- ////
		Button b4 = (Button) findViewById(R.id.Button4);
		_et = (EditText) findViewById(R.id.editText1);
		b4.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Log.i("TAG", "HELLO");
				NotificationManager nm = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
				NotificationCompat.Builder nbuilder = new NotificationCompat.Builder(_context)
				.setSmallIcon(R.drawable.ic_launcher)
				.setContentTitle(_et.getText().toString()+"..")
				.setContentText(_gpsMsg);
				
				// Dynamic location via GPS
				String url = "http://maps.google.com/?q="+latitude+", "+longitude;
				Intent webIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
				
				webIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
				
				PendingIntent pendingIntent = PendingIntent.getActivity(_context, 0, webIntent, PendingIntent.FLAG_UPDATE_CURRENT);
				
				nbuilder.setContentIntent(pendingIntent);
				_notification = nbuilder.build();
				
				_notification.tickerText = "New Comment!";
				nm.notify(0, _notification);
				
				// Hide Keyboard
				InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
				imm.hideSoftInputFromWindow(_et.getWindowToken(), 0);
				
				ArrayList<Map<String, String>> _data = new ArrayList<Map<String, String>>();
				
				Map<String, String> map = new HashMap<String, String>(2);
				map.put("comment", _et.getText().toString());
				map.put("location", "from "+_gpsMsg);
				_data.add(map);
				    
				SimpleAdapter _adapter = new SimpleAdapter(getApplicationContext(), _data, android.R.layout.simple_list_item_2,
		            new String[] {"comment", "location"},
		            new int[] {android.R.id.text1, android.R.id.text2});
		        _lv.setAdapter(_adapter);
		        
		        _lv.setOnItemClickListener(new OnItemClickListener() {
		        	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
		        		
		        		// Location via GPS
						String url = "http://maps.google.com/?q="+latitude+", "+longitude;
						Intent webIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
						startActivity(webIntent);
		        	}
				});
				
				// Clear search field
				_et.setText("");
			}
		});

	}
}
