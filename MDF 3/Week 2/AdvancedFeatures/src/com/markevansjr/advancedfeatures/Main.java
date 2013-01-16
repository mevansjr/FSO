package com.markevansjr.advancedfeatures;

import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.VideoView;
import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

public class Main extends Activity {
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

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		//// GROUP ONE <---------------------- ////
		_context = this;
		_mp = MediaPlayer.create(Main.this, R.raw.intro);
		_btn1 = (Button) findViewById(R.id.button1);
		_btxt = "Play";
		
		// AUDIO PLAYBACK
		_btn1.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				if(_btxt.equals("Play")){
					_mp.start();
					_btxt = "Pause";
					_btn1.setText(_btxt);
				} else {
					_mp.pause();
					_btxt = "Play";
					_btn1.setText(_btxt);
				}
			}
		});
		_btn1.setText(_btxt);
		
		// VIDEO PLAYBACK
		final Button b2 = (Button) findViewById(R.id.button2);
		b2.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				_vv = (VideoView) findViewById(R.id.videoView1);
				String uripath = "android.resource://"+ getPackageName() + "/" + R.raw.intro;
				_vv.setVideoURI(Uri.parse(uripath));
				if(b2.getText().equals("Play Video")){
					b2.setText("Pause Video");
					_vv.start();
				} else {
					b2.setText("Play Video");
					_vv.pause();
				}
			}
		});
		b2.setText("Play Video");
		
		//// GROUP TWO <---------------------- ////
		// create class object
    	GPSTracker gps = new GPSTracker(Main.this);
    	// check if GPS enabled
       	if(gps.canGetLocation()){
       		latitude = gps.getLatitude();
            longitude = gps.getLongitude();
            // \n is for new line
            //Toast.makeText(getApplicationContext(), "Your Location is - \nLat: " + latitude + "\nLong: " + longitude, Toast.LENGTH_LONG).show();
            _gpsMsg ="GPS - Lat: "+latitude+" Lon: "+longitude;
            
       	}else{
       		// can't get location
            // GPS or Network is not enabled
            // Ask user to enable GPS/network in settings
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
				
				// Clear search field
				_et.setText("");
			}
		});

	}
}
