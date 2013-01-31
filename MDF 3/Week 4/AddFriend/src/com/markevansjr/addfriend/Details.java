package com.markevansjr.addfriend;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
public class Details extends Activity {
	
	String _allData;
	String _fname;
	String _lname;
	String _phone;
	String _email;
	String _fullname;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_details);
		
		TextView tv = (TextView) findViewById(R.id.textView1);
		Button btn = (Button) findViewById(R.id.button1);
		
		Intent i = getIntent();
		_allData = i.getStringExtra("AllData");
		_fname = i.getStringExtra("fname");
		_lname = i.getStringExtra("lname");
		_phone = i.getStringExtra("phone");
		_email = i.getStringExtra("email");
		_fullname = i.getStringExtra("fullname");
		
		tv.setText(_fullname+"\n"+_phone+"\n"+_email);
		btn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Log.i("TAG NUMBER", _phone);
				if (_phone.length() > 10) {
				       Uri number = Uri.parse("tel:" + _phone);
				       Intent dial = new Intent(Intent.ACTION_CALL, number);
				       startActivity(dial);
				} else {
					Toast toast = Toast.makeText(getApplicationContext(), "INVAILED NUMBER", Toast.LENGTH_LONG);
					toast.show();
				}
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
	    switch(item.getItemId()) {
	    case R.id.add:
	        //click on about item
	    	Log.i("TAG", "ADD");
	    	Intent i = new Intent(getApplicationContext(), AddFriend.class); 
			startActivity(i);
	        break;
	        
	    case R.id.home:
	        //click on about item
	    	Log.i("TAG", "HOME");
	    	Intent ii = new Intent(getApplicationContext(), MainActivity.class); 
			startActivity(ii);
	        break;
    	}
	    return true;
	}
}
