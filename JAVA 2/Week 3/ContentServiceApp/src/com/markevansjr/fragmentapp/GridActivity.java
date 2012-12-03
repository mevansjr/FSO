package com.markevansjr.fragmentapp;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

public class GridActivity extends Activity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		Log.i("BLAH", "BLAH");
		setContentView(R.layout.grid_view_xml);
		
	}

}