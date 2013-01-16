package com.markevansjr.advancedfeatures;

import android.app.Activity;
import android.app.Notification;
import android.content.Context;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.VideoView;

public class Video extends Activity {
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

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.video);
		
		//// GROUP ONE <---------------------- ////
		_context = this;
		_mp = MediaPlayer.create(Video.this, R.raw.intro);
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

	}
}