package com.markevansjr.sqlite;

import java.util.ArrayList;
import java.util.List;

import com.markevansjr.sqlite.db.VehiclesDataSource;
import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;

@SuppressLint("DefaultLocale")
public class AddActivity extends Activity {

	DetailsActivity d;
	VehiclesDataSource _datasource;
	List<Vehicle> _vehicles = new ArrayList<Vehicle>();
	List<Vehicle> _Allvehicles = new ArrayList<Vehicle>();
	List<Vehicle> _local_vehicles = new ArrayList<Vehicle>();
	ListView _lv;
	Spinner _spinner;
	public String _selectionStr;
	EditText _cc;
	EditText _ct;
	EditText _cv;
	EditText _rp;
	EditText _rs;
	EditText _installdate;
	Button _submitBtn;
	Button _clearBtn;
	Button _closeBtn;
	String call;
	String tag;
	String vin;
	String rp;
	String rs;
	String installdate;
	String datemod;
	String parseid;
	String newParseId;
	ParseObject _obj;
	
	@Override
	@SuppressLint("DefaultLocale")
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_add);
		
		// Initialize Parse
		Parse.initialize(this, "Vw4U41E4V8FO8JnwC1twDxAh6nnGv4Vx6GaJfr1Y", "YTckobCQW0SxY4FI9zHb3TiSEg5f1YCcuUU3rcy7");
		
		
		//SET VIEW ELEMENTS
		_cc = (EditText) findViewById(R.id.editText1);
		_ct = (EditText) findViewById(R.id.editText2);
		_cv = (EditText) findViewById(R.id.editText3);
		_rp = (EditText) findViewById(R.id.editText4);
		_rs = (EditText) findViewById(R.id.editText5);
		_installdate = (EditText) findViewById(R.id.editText6);
		_submitBtn = (Button) findViewById(R.id.button1);
		_clearBtn = (Button) findViewById(R.id.button2);
		_closeBtn = (Button) findViewById(R.id.closebtn);
			
		//SET DB
		_datasource = new VehiclesDataSource(this);
		_datasource.open();
		
		//TRY TO RECEIVE DATA FROM DETAILS VIEW
		try{
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
	
			if (call != null) {
				_cc.setText(call);
			}
			if (tag != null) {
				_ct.setText(tag);
			}
			if (vin != null) {
				_cv.setText(vin);
			}
			if (rp != null) {
				_rp.setText(rp);
			}
			if (rs != null) {
				_rs.setText(rs);
			}
			if (installdate != null) {
				_installdate.setText(installdate);
			}
		} catch (Exception e){
			Log.e("EXCEPTION ADD", e.toString());
		}
		
		//CLEAR EDIT TEXT VIEWS
		_clearBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				_cc.setText("");
				_ct.setText("");
				_cv.setText("");
				_rp.setText("");
				_rs.setText("");
				_installdate.setText("");
			}
		});
		
		//SUBMIT FOR BOTH ADD AND UPDATE TO PARSE
		_submitBtn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (parseid == null) {
					Log.i("TAG SAVE NEW", "New Vehicle");
					try{
						_obj = new ParseObject("newVehicle");
						_obj.put("cc", _cc.getText().toString().toUpperCase());
						_obj.put("cc", _cc.getText().toString().toUpperCase());
						_obj.put("ct", _ct.getText().toString().toUpperCase());
						_obj.put("cv", _cv.getText().toString().toUpperCase());
						_obj.put("rp", _rp.getText().toString().toUpperCase());
						_obj.put("rs", _rs.getText().toString().toUpperCase());
						_obj.put("date", _installdate.getText().toString().toUpperCase());
						_obj.save();
						finish();
						Log.e("PARSE SAVE", "INFO SAVED");
					} catch (Exception e){
						Log.e("EXCEPTION SAVE EMPTY OBJ", e.toString());
					}
				} else {
					Log.i("TAG SAVE UPDATE", "Updated Vehichle");
					Log.i("TAG LOG INFO", _cc.getText()+"\n"+_ct.getText()+"\n"+_cv.getText()+"\n"+_rp.getText()+"\n"+_rs.getText()+"\n"+_installdate.getText());
					try{
						ParseQuery query = new ParseQuery("newVehicle");
						query.getInBackground(parseid, new GetCallback() {
							public void done(final ParseObject obj, ParseException e) {
								if (obj == null) {
									Log.d("issue", "Request failed.");
								} else {
									try{
										obj.put("cc", _cc.getText().toString());
										obj.put("ct", _ct.getText().toString());
										obj.put("cv", _cv.getText().toString());
										obj.put("rp", _rp.getText().toString());
										obj.put("rs", _rs.getText().toString());
										obj.put("date", _installdate.getText().toString());
										obj.save();
										finish();
									} catch (Exception ee){
										Log.e("EXCEPTION SUBMIT UPDATE", ee.toString());
									}
								}
							}
						});
					} catch (Exception e){
						Log.e("EXCEPTION SUBMIT UPDATE", e.toString());
					}
				}
				MainActivity._lv.setAdapter(null);
				finish();
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

