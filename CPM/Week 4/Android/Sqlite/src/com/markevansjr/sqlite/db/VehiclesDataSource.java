package com.markevansjr.sqlite.db;

import java.util.ArrayList;
import java.util.List;

import com.markevansjr.sqlite.MainActivity;
import com.markevansjr.sqlite.Vehicle;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class VehiclesDataSource {

	public static final String LOGTAG="MDTADB";
	
	SQLiteOpenHelper dbhelper;
	SQLiteDatabase database;
	Context _context;
	public int all;
	public int search;
	
	private static final String[] allColumns = {
		VehiclesDBOpenHelper.COLUMN_CALL,
		VehiclesDBOpenHelper.COLUMN_TAG,
		VehiclesDBOpenHelper.COLUMN_VIN, 
		VehiclesDBOpenHelper.COLUMN_PROPERTY,
		VehiclesDBOpenHelper.COLUMN_SERIAL,
		VehiclesDBOpenHelper.COLUMN_INSTALLDATE,
		VehiclesDBOpenHelper.COLUMN_PARSEID,
		VehiclesDBOpenHelper.COLUMN_DATEMOD
	};
	
	public VehiclesDataSource(Context context) {
		dbhelper = new VehiclesDBOpenHelper(context);
	}

	public void open() {
		Log.i(LOGTAG, "Database opened");
		database = dbhelper.getWritableDatabase();
	}

	public void close() {
		Log.i(LOGTAG, "Database closed");		
		dbhelper.close();
	}
	
	public final Vehicle create(Vehicle v) {
		ContentValues values = new ContentValues();
		values.put(VehiclesDBOpenHelper.COLUMN_CALL, v.getCall());
		values.put(VehiclesDBOpenHelper.COLUMN_TAG, v.getTag());
		values.put(VehiclesDBOpenHelper.COLUMN_VIN, v.getVin());
		values.put(VehiclesDBOpenHelper.COLUMN_PROPERTY, v.getProperty());
		values.put(VehiclesDBOpenHelper.COLUMN_SERIAL, v.getSerial());
		values.put(VehiclesDBOpenHelper.COLUMN_INSTALLDATE, v.getInstalldate());
		values.put(VehiclesDBOpenHelper.COLUMN_PARSEID, v.getParseid());
		values.put(VehiclesDBOpenHelper.COLUMN_DATEMOD, v.getDatemod());
		long insertid = database.insert(VehiclesDBOpenHelper.TABLE_VEHICLES, null, values);
		v.setId(insertid);
		return v;
	}
	
	public boolean deleteBy(String call){
		int cursor = database.delete(VehiclesDBOpenHelper.TABLE_VEHICLES, VehiclesDBOpenHelper.COLUMN_CALL+"=?", new String[]{call});
		Log.i("TAG DELETE", String.valueOf(cursor));
		MainActivity._lv.setAdapter(null);
		return  cursor > 0;
	}
	
	public boolean deleteAll(){
		int cursor = database.delete(VehiclesDBOpenHelper.TABLE_VEHICLES, null, null);
		return  cursor > 0;
	}
	
	public boolean updateBy(String call, ContentValues cv) {
		int cursor = database.update(VehiclesDBOpenHelper.TABLE_VEHICLES, cv, VehiclesDBOpenHelper.COLUMN_CALL+"=?", new String[]{call});
		return  cursor > 0;
	}
	
	public List<Vehicle> findAll() {
		List<Vehicle> _vehicles = new ArrayList<Vehicle>();
		Cursor cursor = database.query(VehiclesDBOpenHelper.TABLE_VEHICLES,
			allColumns, 
			null,
			null,
			null,
			null,
			null
		);
				
		Log.i(LOGTAG, "Returned " + cursor.getCount() + " rows");
		all = cursor.getCount();
		if (cursor.getCount() > 0) {
			while (cursor.moveToNext()) {
				Vehicle v = new Vehicle();
				v.setCall(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_CALL)));
				v.setTag(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_TAG)));
				v.setVin(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_VIN)));
				v.setProperty(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PROPERTY)));
				v.setSerial(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_SERIAL)));
				v.setInstalldate(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_INSTALLDATE)));
				v.setParseid(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PARSEID)));
				v.setDatemod(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_DATEMOD)));
				_vehicles.add(v);
			}
		} 
		return _vehicles;
	}
	
	public List<Vehicle> findByCallIn(String query) {
		List<Vehicle> _vehicles = new ArrayList<Vehicle>();
		Log.i("TAG FIND CALL QUERY", query);
		Cursor cursor = database.query(VehiclesDBOpenHelper.TABLE_VEHICLES,
			allColumns, 
			VehiclesDBOpenHelper.COLUMN_CALL + " IN ('"+query+"')",
			null,
			null,
			null,
			null
		);
		try{		
			search = cursor.getCount();
			if (cursor.getCount() > 0) {
				while (cursor.moveToNext()) {
					Vehicle v = new Vehicle();
					v.setCall(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_CALL)));
					v.setTag(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_TAG)));
					v.setVin(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_VIN)));
					v.setProperty(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PROPERTY)));
					v.setSerial(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_SERIAL)));
					v.setInstalldate(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_INSTALLDATE)));
					v.setParseid(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PARSEID)));
					v.setDatemod(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_DATEMOD)));
					_vehicles.add(v);
				}
			}
			
		} catch (ClassCastException e) {
			throw new ClassCastException(e.toString());
		}
		return _vehicles;
}
	
	public List<Vehicle> findBy(String query, String col) {
		List<Vehicle> _vehicles = new ArrayList<Vehicle>();
		if (col.equals("CALL NUMBER")){
			Log.i("TAG FIND BY CALL QUERY", query);
			Cursor cursor = database.query(VehiclesDBOpenHelper.TABLE_VEHICLES,
				allColumns, 
				VehiclesDBOpenHelper.COLUMN_CALL + "='"+query+"'",
				null,
				null,
				null,
				null
			);
			try{
				
			search = cursor.getCount();
			if (cursor.getCount() > 0) {
				while (cursor.moveToNext()) {
					Vehicle v = new Vehicle();
					v.setCall(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_CALL)));
					v.setTag(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_TAG)));
					v.setVin(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_VIN)));
					v.setProperty(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PROPERTY)));
					v.setSerial(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_SERIAL)));
					v.setInstalldate(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_INSTALLDATE)));
					v.setParseid(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PARSEID)));
					v.setDatemod(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_DATEMOD)));
					_vehicles.add(v);
				}
			}
			
			} catch (ClassCastException e) {
				throw new ClassCastException(e.toString());
			}
		} else if (col.equals("TAG NUMBER")){
			Log.i("TAG FIND BY CALL QUERY", query);
			Cursor cursor = database.query(VehiclesDBOpenHelper.TABLE_VEHICLES,
				allColumns, 
				VehiclesDBOpenHelper.COLUMN_TAG + "='"+query+"'",
				null,
				null,
				null,
				null
			);
			try{
				
			if (cursor.getCount() > 0) {
				while (cursor.moveToNext()) {
					Vehicle v = new Vehicle();
					v.setCall(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_CALL)));
					v.setTag(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_TAG)));
					v.setVin(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_VIN)));
					v.setProperty(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PROPERTY)));
					v.setSerial(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_SERIAL)));
					v.setInstalldate(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_INSTALLDATE)));
					v.setParseid(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PARSEID)));
					v.setDatemod(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_DATEMOD)));
					_vehicles.add(v);
				}
			}
			
			} catch (ClassCastException e) {
				throw new ClassCastException(e.toString());
			}
		} else if (col.equals("VIN NUMBER")){
			Log.i("TAG FIND BY CALL QUERY", query);
			Cursor cursor = database.query(VehiclesDBOpenHelper.TABLE_VEHICLES,
				allColumns, 
				VehiclesDBOpenHelper.COLUMN_VIN + "='"+query+"'",
				null,
				null,
				null,
				null
			);
			try{
				
			if (cursor.getCount() > 0) {
				while (cursor.moveToNext()) {
					Vehicle v = new Vehicle();
					v.setCall(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_CALL)));
					v.setTag(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_TAG)));
					v.setVin(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_VIN)));
					v.setProperty(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PROPERTY)));
					v.setSerial(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_SERIAL)));
					v.setInstalldate(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_INSTALLDATE)));
					v.setParseid(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_PARSEID)));
					v.setDatemod(cursor.getString(cursor.getColumnIndex(VehiclesDBOpenHelper.COLUMN_DATEMOD)));
					_vehicles.add(v);
				}
			}
			
			} catch (ClassCastException e) {
				throw new ClassCastException(e.toString());
			}
		}
		return _vehicles;
	}
	
}
