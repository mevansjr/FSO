package com.markevansjr.sqlite;

import java.util.ArrayList;
import java.util.List;

import com.markevansjr.sqlite.db.VehiclesDataSource;
import com.parse.Parse;
import com.parse.ParseObject;

import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;

@SuppressLint("DefaultLocale")
public class DetailsActivity extends Activity {

	VehiclesDataSource _datasource;
	List<Vehicle> _vehicles = new ArrayList<Vehicle>();
	List<Vehicle> _Allvehicles = new ArrayList<Vehicle>();
	List<Vehicle> _local_vehicles = new ArrayList<Vehicle>();
	ListView _lv;
	Spinner _spinner;
	public String _selectionStr;
	TextView _cc;
	TextView _ct;
	TextView _cv;
	TextView _rp;
	TextView _rs;
	TextView _installdate;
	TextView _parseid;
	TextView _datemod;
	Button _updateBtn;
	Button _deleteBtn;
	Button _closeBtn;
	String call;
	String tag;
	String vin;
	String rp;
	String rs;
	String installdate;
	String parseid;
	String datemod;
	
	@Override
	@SuppressLint("DefaultLocale")
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_details);
		
		// Initialize Parse
		Parse.initialize(this, "Vw4U41E4V8FO8JnwC1twDxAh6nnGv4Vx6GaJfr1Y", "YTckobCQW0SxY4FI9zHb3TiSEg5f1YCcuUU3rcy7");
		
		//SET VIEW ELEMENTS
		_cc = (TextView) findViewById(R.id.textView1);
		_ct = (TextView) findViewById(R.id.textView2);
		_cv = (TextView) findViewById(R.id.textView3);
		_rp = (TextView) findViewById(R.id.textView4);
		_rs = (TextView) findViewById(R.id.textView5);
		_installdate = (TextView) findViewById(R.id.textView6);
		_parseid = (TextView) findViewById(R.id.textView7);
		_datemod = (TextView) findViewById(R.id.textView9);
		_updateBtn = (Button) findViewById(R.id.button1);
		_deleteBtn = (Button) findViewById(R.id.button2);
		_closeBtn = (Button) findViewById(R.id.closebtn);
			
		//SET DB
		_datasource = new VehiclesDataSource(this);
		_datasource.open();
		
		//RECEIVE INTENT DATA
		Intent i = getIntent();
		call = i.getStringExtra("call");
		tag = i.getStringExtra("tag");
		vin = i.getStringExtra("vin");
		rp = i.getStringExtra("rp");
		rs = i.getStringExtra("rs");
		installdate = i.getStringExtra("installdate");
		parseid = i.getStringExtra("parseid");
		datemod = i.getStringExtra("datemod");
		Log.i("TAG PASSED INFO", call+"\n"+tag+"\n"+vin+"\n"+rp+"\n"+rs+"\n"+installdate+"\n"+parseid+"\n"+datemod);
		
		//SET TEXTVIEW WITH DATA
		_cc.setText("CALL: "+call);
		_ct.setText("TAG: "+tag);
		_cv.setText("VIN: "+vin);
		_rp.setText("PROPERTY TAG: "+rp);
		_rs.setText("RADIO SERIAL: "+rs);
		_installdate.setText("INSTALL DATE: "+installdate);
		_parseid.setText("PARSE ID: "+parseid);
		_datemod.setText(datemod);
		
		
		//DELETE FROM DB ADD TO DELETE PARSE CLASS
		_deleteBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				_datasource.deleteBy(call);
				try{
					ParseObject obj = new ParseObject("deleteVehicle");
					obj.put("cc", call);
					obj.put("ct", tag);
					obj.put("cv", vin);
					obj.put("rp", rp);
					obj.put("rs", rs);
					obj.put("date", installdate);
					obj.save();
					finish();
				} catch (Exception ee){
					Log.e("EXCEPTION SUBMIT UPDATE", ee.toString());
				}
			}
		});
		
		//SEND UPDATE DATA TO ADD ACTIVITY
		_updateBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent i = new Intent(getApplicationContext(), AddActivity.class); 
				i.putExtra("call", call);
				i.putExtra("tag", tag);
				i.putExtra("vin", vin);
				i.putExtra("rp", rp);
				i.putExtra("rs", rs);
				i.putExtra("installdate", installdate);
				i.putExtra("parseid", parseid);
				i.putExtra("datemod", datemod);
				startActivity(i);
			}
		});
		
		//CLOSE VIEW
		_closeBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				MainActivity._btn.setText("Show All");
				finish();
			}
		});
	}
	
	@Override
	protected void onResume() {
		super.onResume();
		_datasource.open();
	}
	
	@Override
	protected void onPause() {
		super.onPause();
		_datasource.close();
	}
}

