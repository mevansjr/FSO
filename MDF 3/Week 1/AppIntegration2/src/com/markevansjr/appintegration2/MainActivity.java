package com.markevansjr.appintegration2;

import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends Activity {
	
	EditText _et;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		_et = (EditText) findViewById(R.id.editText1);
		Button btn = (Button) findViewById(R.id.button1);
		_et.setText("http://www.");
		
		btn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Log.i("URL", _et.getText().toString());
			    
				if (_et.getText().toString() == "" || _et.getText().toString().equals(""))
				{
					Toast toast = Toast.makeText(getApplicationContext(), "Search Field is empty!", Toast.LENGTH_SHORT);
					toast.show();
				} else {
					String scheme = "search://name/" +_et.getText().toString();
					Uri webpage = Uri.parse(scheme);
					
					Intent browseIntent = new Intent(Intent.ACTION_VIEW, webpage);
					browseIntent.putExtra("passedData", "http://www."+_et.getText().toString()+".com");
				    String title = (String) getResources().getText(R.string.chooser_title);
			        Intent chooser = Intent.createChooser(browseIntent, title);
			        startActivityForResult(chooser, 1);
				}
		        
			}
        });
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
}
