package com.markevansjr.sqlite;

import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.markevansjr.sqlite.db.VehiclesDBOpenHelper;
import com.markevansjr.sqlite.db.VehiclesDataSource;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.os.AsyncTask;
import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.Spinner;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemSelectedListener;

@SuppressLint({ "DefaultLocale", "SimpleDateFormat" })
public class MainActivity extends Activity implements SearchView.OnQueryTextListener {

	private SearchView mSearchView;
	static VehiclesDataSource _datasource;
	static List<Vehicle> _vehicles = new ArrayList<Vehicle>();
	static List<String> _resultsArr = new ArrayList<String>();
	static List<Vehicle> _Allvehicles = new ArrayList<Vehicle>();
	List<Vehicle> _local_vehicles = new ArrayList<Vehicle>();
	public static ListView _lv;
	Spinner _spinner;
	static Button _btn;
	static Context _context;
	public String _selectionStr;
	static Date date_dm;
	
	@Override
	@SuppressLint("DefaultLocale")
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		// INITIALIZE PARSE
		Parse.initialize(this, "Vw4U41E4V8FO8JnwC1twDxAh6nnGv4Vx6GaJfr1Y", "YTckobCQW0SxY4FI9zHb3TiSEg5f1YCcuUU3rcy7");
		
		// SET SOME VIEW ELEMENTS
		_context = getApplicationContext();
		_lv = (ListView) findViewById(R.id.listView1); 
		_selectionStr = "CALL NUMBER";
		Log.i("TAG SPINNER STRING", _selectionStr);
		_spinner = (Spinner) findViewById(R.id.spinner1);
		ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this, R.array.spinner_array, android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		_spinner.setAdapter(adapter);
		_spinner.setOnItemSelectedListener(new OnItemSelectedListener() {
        	@Override
        	public void onItemSelected(AdapterView<?> parent, View v, int pos, long id){
        			_selectionStr = parent.getItemAtPosition(pos).toString();				
        			Log.i("TAG SPINNER STRING", _selectionStr);
        	}
		
        	@Override
        	public void onNothingSelected(AdapterView<?> parent){
        		Log.i("FAVORITE SELECTED", "NONE");
        	}
        }); 
			
		//SET DB AND SYNC WITH PARSE
		_datasource = new VehiclesDataSource(this);
		_datasource.open();
		_Allvehicles = _datasource.findAll();
		syncDB();
		syncDelete();
		syncParseByModDate();
		
		//TIMER TO SYNC PARSE EVERY 3 MINUTES
		ScheduledExecutorService scheduleTaskExecutor = Executors.newScheduledThreadPool(5);
		scheduleTaskExecutor.scheduleAtFixedRate(new Runnable() {
			public void run() {
				try{
					Log.e("FIRE ASYNC", "TASK STARTED");
	    			Request qr = new Request();
	    			qr.execute();
	    		} catch (Exception e){
	    			Log.e("BAD", e.toString());
	    		}
			}
		}, 0, 3, TimeUnit.MINUTES);
		
		//WILL SHOW ALL IN DB AND SYNC TO PARSE
		_btn = (Button) findViewById(R.id.showAllBtn);
		_btn.setText("Show All");
		_btn.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Log.i("TAG", "Show All");
		    	ArrayAdapter<Vehicle> adapter = new ArrayAdapter<Vehicle>(getApplicationContext(), R.layout.custom_list, _Allvehicles);
		    	_lv.setAdapter(adapter);
		    	_lv.setOnItemClickListener(new OnItemClickListener() {
					public void onItemClick(AdapterView<?> parent, View view, int position, long id) { 
						Vehicle v = _Allvehicles.get(position);
						Log.i("TAG SELECT CALL", v.getCall());
						Intent i = new Intent(getApplicationContext(), DetailsActivity.class); 
						i.putExtra("call", v.getCall());
						i.putExtra("tag", v.getTag());
						i.putExtra("vin", v.getVin());
						i.putExtra("rp", v.getProperty());
						i.putExtra("rs", v.getSerial());
						i.putExtra("installdate", v.getInstalldate());
						i.putExtra("parseid", v.getParseid());
						i.putExtra("datemod", v.getDatemod());
						startActivity(i);
					}
				});
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
	
	@SuppressLint({"DefaultLocale" })
	private static void createDataFromParse() {
		ParseQuery query = new ParseQuery("newVehicle");
		query.findInBackground(new FindCallback() {
			
			@SuppressLint("DefaultLocale")
			public void done(List<ParseObject> objects, ParseException e) {
				
				if (e == null) {
					for(int ii=0;ii<objects.toArray().length;ii++){	
						ParseObject s = objects.get(ii);
						Vehicle v = new Vehicle();
						v.setCall(s.getString("cc").toUpperCase());
						v.setTag(s.getString("ct").toUpperCase());
						v.setVin(s.getString("cv").toUpperCase());
						v.setProperty(s.getString("rp").toUpperCase());
						v.setSerial(s.getString("rs").toUpperCase());
						v.setInstalldate(s.getString("date").toUpperCase());
						v.setParseid(s.getObjectId());
						v.setDatemod(s.getUpdatedAt().toString());
						v = _datasource.create(v);
						_Allvehicles.add(v);
					}
					Log.i("TAG COUNT", String.valueOf(_vehicles.toArray().length));
				} else {
					Log.e("ERROR::", "ERROR");
				}
			}
		});
	}
	
	public static int getCountFromParse()
    {
		ParseQuery query = new ParseQuery("newVehicle");
		try{
			query.count();
			return query.count();
		} catch (Exception e){
			Log.e("EXCEPTION QUERY COUNT", e.toString());
		}
		return 0;
    }
	
	public static void syncDelete()
    {
		ParseQuery query = new ParseQuery("deleteVehicle");
		query.findInBackground(new FindCallback() {
			public void done(List<ParseObject> objects, ParseException e) {
				List<Vehicle> _d = new ArrayList<Vehicle>();
				Log.i("DELETE PARSE COUNT", String.valueOf(objects.size()));
				if (e == null) {
					for(int i=0;i<objects.toArray().length;i++){	
						ParseObject s = objects.get(i);
						
						Date parseDate = s.getUpdatedAt();
						
						final Vehicle v = new Vehicle();
						v.setCall(s.getString("cc").toUpperCase());
						v.setTag(s.getString("ct").toUpperCase());
						v.setVin(s.getString("cv").toUpperCase());
						v.setProperty(s.getString("rp").toUpperCase());
						v.setSerial(s.getString("rs").toUpperCase());
						v.setInstalldate(s.getString("date").toUpperCase());
						v.setParseid(s.getObjectId());
						v.setDatemod(s.getUpdatedAt().toString());
						
						Log.i("DELETE PARSE CALL", v.getCall());
						
						_d = _datasource.findAll();
						for(int ii=0;ii<_d.size();ii++){
							Vehicle vv = _d.get(ii);
							String dm = vv.getDatemod();
							try {
								SimpleDateFormat format = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy");
								date_dm = format.parse(dm);
							} catch (Exception ee){
								Log.e("EXCEPTION DATE", ee.toString());
							}
							
							if (vv.getCall().equals(v.getCall()))
							{
								Log.i("PARSE CALL", v.getCall());
								Log.i("LOCAL CALL", vv.getCall());
								int intParse = (int) parseDate.getTime();
								int intLocal = (int) date_dm.getTime();
								Log.i("PARSE DATE", v.getCall() +" DATE: "+parseDate.toString()+" Value: "+String.valueOf(intParse));
								Log.i("LOCAL DATE", vv.getCall() + " DATE: "+date_dm.toString()+" Value: "+String.valueOf(intLocal));
								if (intParse > intLocal)
								{
									_datasource.deleteBy(v.getCall());
								} else {
									try{
										// DELETE FROM DELETE CLASS
										ParseQuery query = new ParseQuery("deleteVehicle");
										query.getInBackground(vv.getParseid(), new GetCallback() {
											public void done(final ParseObject obj, ParseException e) {
												if (obj == null) {
													Log.d("issue", "Request failed.");
												} else {
													try{
														obj.delete();
													} catch (Exception ee){
														Log.e("EXCEPTION SUBMIT UPDATE", ee.toString());
													}
												}
											}
										});
										
										// ADD NEW VEHICLE
										ParseObject obj = new ParseObject("newVehicle");
										obj.put("cc", v.getCall());
										obj.put("ct", v.getTag());
										obj.put("cv", v.getVin());
										obj.put("rp", v.getProperty());
										obj.put("rs", v.getSerial());
										obj.put("date", v.getInstalldate());
										obj.save();
									} catch (Exception ee){
										Log.e("EXCEPTION DELETE SAVE", ee.toString());
									}
								}
							}
						}
						
					}
				} else {
					Log.e("ERROR::", "ERROR");
				}
			}
		});
    }
	
	public static void syncParseByModDate()
    {		
		// QUERY IF VEHICLES WITHIN 10 MINUTES
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date myDate = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(myDate);
		cal.add(Calendar.MINUTE, -10);
		String date = format.format(cal.getTime());
		Log.i("TAG DATE", date);
		ParseQuery query = new ParseQuery("newVehicle");
		query.whereGreaterThan("updatedAt", cal.getTime());
		query.findInBackground(new FindCallback() {
			public void done(List<ParseObject> objects, ParseException e) {
				List<Vehicle> _t = new ArrayList<Vehicle>();
				Log.i("TAG COUNT", String.valueOf(objects.size()));
				if (e == null) {
					for(int ii=0;ii<objects.toArray().length;ii++){	
						ParseObject s = objects.get(ii);
					
						final Vehicle v = new Vehicle();
						v.setCall(s.getString("cc").toUpperCase());
						v.setTag(s.getString("ct").toUpperCase());
						v.setVin(s.getString("cv").toUpperCase());
						v.setProperty(s.getString("rp").toUpperCase());
						v.setSerial(s.getString("rs").toUpperCase());
						v.setInstalldate(s.getString("date").toUpperCase());
						v.setParseid(s.getObjectId());
						v.setDatemod(s.getUpdatedAt().toString());
						Log.i("TAG PARSE STR", v.getCall()+" DATE: "+ v.getDatemod());
						
						//CHECK LOCAL DB FOR CALL FROM PARSE
						_t = _datasource.findByCallIn(v.getCall());
						Log.i("TAG COUNT _t", String.valueOf(_t.size()));
						if (_t.size() == 0)
						{
							//VEHICLE WAS NOT FOUND SO IT WILL BE ADDED
							_datasource.create(v);
							Log.i("ADD TO SQL", "CREATED");
						} else {
							//VEHICLE WAS FOUND SO IT WILL BE UPDATED
							ParseQuery query = new ParseQuery("newVehicle");
							query.whereEqualTo("cc", v.getCall());
							query.findInBackground(new FindCallback() {
								public void done(List<ParseObject> objects, ParseException e) {
									Log.i("QUERY PARSE FOR CALL", String.valueOf(objects.size()));
									if (e == null) {
										ContentValues values = new ContentValues();
										values.put(VehiclesDBOpenHelper.COLUMN_CALL, v.getCall());
										values.put(VehiclesDBOpenHelper.COLUMN_TAG, v.getTag());
										values.put(VehiclesDBOpenHelper.COLUMN_VIN, v.getVin());
										values.put(VehiclesDBOpenHelper.COLUMN_PROPERTY, v.getProperty());
										values.put(VehiclesDBOpenHelper.COLUMN_SERIAL, v.getSerial());
										values.put(VehiclesDBOpenHelper.COLUMN_INSTALLDATE, v.getInstalldate());
										values.put(VehiclesDBOpenHelper.COLUMN_PARSEID, v.getParseid());
										values.put(VehiclesDBOpenHelper.COLUMN_DATEMOD, v.getDatemod());
										_datasource.updateBy(v.getCall(), values);
									} else {
										Log.e("ERROR::", "ERROR");
									}
								}
							});
						}
					}
				} else {
					Log.e("ERROR::", "ERROR");
				}
			}
		});
    }
	
	public static void syncDB()
    {	
		_Allvehicles = _datasource.findAll();
		Log.i("TAG SIZE", "Original Count: "+String.valueOf(_Allvehicles.size()));
		Log.i("TAG SIZE", "Parse Count: "+String.valueOf(getCountFromParse()));
		if (_Allvehicles.size() == 0) {
			Log.i("TAG EMPTY", "DATA REFILL");
			_datasource.deleteAll();
			createDataFromParse();
			_Allvehicles = _datasource.findAll();
		}
		Toast ts = Toast.makeText(_context, "DATABASE SYNC IN PROGRESS", Toast.LENGTH_SHORT);
		ts.show();
    }
	
	public void search(String query)
    {	
		_vehicles = _datasource.findBy(query, _selectionStr);
		Log.i("TAG SEARCH VEH COUNT", String.valueOf(_vehicles.size()));
		if (_vehicles.size() == 0) {
			Toast t = Toast.makeText(getApplicationContext(), _selectionStr+": No results for ("+query+")", Toast.LENGTH_SHORT);
			t.setGravity(Gravity.CENTER_VERTICAL, 0, 0);
			t.show();
		} else {
			_vehicles = _datasource.findBy(query, _selectionStr);
		}
		_btn.setText("Show All ("+String.valueOf(_datasource.search)+")");
		ArrayAdapter<Vehicle> adapter = new ArrayAdapter<Vehicle>(getApplicationContext(), R.layout.custom_list, _vehicles);
		_lv.setAdapter(adapter);
		_lv.setOnItemClickListener(new OnItemClickListener() {
			public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
				Vehicle v = _vehicles.get(position);
				Log.i("TAG SELECT CALL", v.getCall());
				Intent i = new Intent(getApplicationContext(), DetailsActivity.class); 
				i.putExtra("call", v.getCall());
				i.putExtra("tag", v.getTag());
				i.putExtra("vin", v.getVin());
				i.putExtra("rp", v.getProperty());
				i.putExtra("rs", v.getSerial());
				i.putExtra("installdate", v.getInstalldate());
				i.putExtra("parseid", v.getParseid());
				i.putExtra("datemod", v.getDatemod());
				startActivity(i);
			}
		});
    }
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
	    getMenuInflater().inflate(R.layout.menu, menu);
        MenuItem searchItem = menu.findItem(R.id.menu_search);
        mSearchView = (SearchView) searchItem.getActionView();
        mSearchView.setOnQueryTextListener(this);
        return super.onCreateOptionsMenu(menu);
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
	    switch(item.getItemId()) {
	    case R.id.item_add:
	    	Log.i("TAG", "Add");
			Intent i = new Intent(getApplicationContext(), AddActivity.class); 
			startActivity(i);
			
	        break;
	    case R.id.item_clear:
	    	Log.i("TAG", "Clear");
	    	_lv.setAdapter(null);
	    	_lv.setOnItemClickListener(new OnItemClickListener() {
				public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
					Log.i("TAG SELECT", String.valueOf(position));
				}
			});
	        break;
    	}
	    return true;
	}

	@Override
	public boolean onQueryTextChange(String arg0) {
		return false;
	}

	@Override
	public boolean onQueryTextSubmit(String query) {
		search(query);
		return false;
	}
	
	private class Request extends AsyncTask<URL, Void, String>{
    	@Override
    	protected String doInBackground(URL... urls){
    		String s = null;
    		return s;
    	}
    	@Override
    	protected void onPostExecute(String s){
			try{
				//CALL DELETE FUNCTION
				syncDelete();
				//CALL SYNC PARSE FUNCTION
				syncParseByModDate();
			} catch (Exception e){
				Log.e("EXCEPTION","ERROR");
				Toast toast = Toast.makeText(_context, "ERROR WITH SYNC", Toast.LENGTH_SHORT);
				toast.show();
			}
    	}
    }
}

