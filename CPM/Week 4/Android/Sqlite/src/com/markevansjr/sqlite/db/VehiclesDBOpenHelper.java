package com.markevansjr.sqlite.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class VehiclesDBOpenHelper extends SQLiteOpenHelper {

	private static final String LOGTAG = "MDTADB";

	private static final String DATABASE_NAME = "mdta.db";
	private static final int DATABASE_VERSION = 1;
	
	public static final String TABLE_VEHICLES = "Vehicles";
	public static final String COLUMN_ID = "id";
	public static final String COLUMN_CALL = "call";
	public static final String COLUMN_TAG = "tag";
	public static final String COLUMN_VIN = "vin";
	public static final String COLUMN_PROPERTY = "property";
	public static final String COLUMN_SERIAL = "serial";
	public static final String COLUMN_INSTALLDATE = "installdate";
	public static final String COLUMN_PARSEID = "parseid";
	public static final String COLUMN_DATEMOD = "datemod";
	
	public static final String TABLE_CREATE = "CREATE TABLE IF NOT EXISTS "+TABLE_VEHICLES+" ("+COLUMN_ID+" INTEGER PRIMARY KEY AUTOINCREMENT, "+COLUMN_CALL+" TEXT, "+COLUMN_TAG+" TEXT, "+COLUMN_VIN+" TEXT, "+COLUMN_PROPERTY+" TEXT, "+COLUMN_SERIAL+" TEXT, "+COLUMN_INSTALLDATE+" TEXT, "+COLUMN_PARSEID+" TEXT, "+COLUMN_DATEMOD+" TEXT);";
	
	public VehiclesDBOpenHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL(TABLE_CREATE);
		Log.i(LOGTAG, "Table has been created");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL("DROP TABLE IF EXISTS " + TABLE_VEHICLES);
		onCreate(db);
	}

}
