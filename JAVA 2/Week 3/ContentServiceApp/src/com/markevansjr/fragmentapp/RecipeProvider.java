package com.markevansjr.fragmentapp;

import android.content.*;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteQueryBuilder;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

public class RecipeProvider extends ContentProvider {
	// URI for this provider
	public static final Uri CONTENT_URI =
		Uri.parse("content://com.markevansjr.provider.recipeviewer/recipes");
	
	// The database of earthquakes
	private SQLiteDatabase      recipeDB;
	
	// Define all private constants
	private static final String TAG              = "RecipeProvider";
	private static final String DB_NAME          = "recipes.db";
	private static final int    DB_VERSION       = 1;
	private static final String RECIPE_TABLE = "recipes";
	
	// Publish column names
	public static final String KEY_ID            = "_id";
	public static final String KEY_TITLE         = "title";
	public static final String KEY_RATING        = "rating";
	public static final String KEY_IMG_URL  	 = "img_url";
	
	// Publish column indexes
	public static final int TITLE_COLUMN          = 1;
	public static final int RATING_COLUMN         = 2;
	public static final int IMG_COLUMN     	      = 3;
	
	// Constants that differentiate b/w different URI requests
	private static final int RECIPES   = 1;
	private static final int RECIPE_ID = 2;
	
	private static final UriMatcher uriMatcher;
	
	// construct a static UriMatcher object to add two URIs:
	// the first will service the URI for all RECIPES; the
	// second will service the URI for individual quakes.
	static {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		// a URI that ends in earthquakes corresponds to a request
		// for all earthquakes
		uriMatcher.addURI("com.markevansjr.provider.recipeviewer", 
				"recipes", RECIPES);
		// a URI that ends in "earthquake" with a number
		// corresponds to a request to retrieve a specific earthquake
		uriMatcher.addURI("com.markevansjr.provider.recipeviewer/",
				"recipes/#", RECIPE_ID);
	}
	
	// DB Helper class
	private static class recipeDBHelper extends SQLiteOpenHelper {
		
		// db creation table command
		private static final String DB_CREATE = 
			"create table "    + RECIPE_TABLE + " ("
			+ KEY_ID           + " integer primary key autoincrement, "
			+ KEY_TITLE        + " TEXT, "
			+ KEY_RATING       + " TEXT, "
			+ KEY_IMG_URL 	   + " TEXT);";
		
		public recipeDBHelper(Context context, String name, CursorFactory factory, int version) {
			super(context, name, factory, version);
		}

		@Override
		public void onCreate(SQLiteDatabase db) {
			db.execSQL(DB_CREATE);
		}

		@Override
		public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
			Log.w(TAG, "Upgrading database from versoin " + oldVersion + " to "
					+ newVersion + ", which will destroy all old data");
			db.execSQL("DROP TABLE IF EXISTS " + RECIPE_TABLE);
			onCreate(db);
		}
		
	}
	
	@Override
	public boolean onCreate() {
		Context context = getContext();
		recipeDBHelper dbHelper
			= new recipeDBHelper(context, DB_NAME, null, DB_VERSION);
		recipeDB = dbHelper.getWritableDatabase();
		return ( recipeDB == null) ? false : true;
	}
	
	@Override
	public String getType(Uri uri) {
		switch ( uriMatcher.match(uri) ) {
		// if uriMatcher returns QUAKES
		case RECIPES: 
			return "vnd.android.cursor.dir/com.markevansjr.recipeviewer";
		// if uriMatcher returns QUAKE_ID
		case RECIPE_ID: 
			return "vnd.android.cursor.item/com.markevansjr.recipeviewer";
		default: throw new IllegalArgumentException("Unsupported URI: " + uri);
		}
	}
	
	@Override
	public Cursor query(Uri uri, String[] projection, 
			String selection, String[] selectionArgs,
			String sort) 
	{
		SQLiteQueryBuilder qb = new SQLiteQueryBuilder();
		qb.setTables(RECIPE_TABLE);
		switch(uriMatcher.match(uri)) {
		// if this is a row query, add the where clause with the
		// appropriate row number.
		case RECIPE_ID: {
			qb.appendWhere(KEY_ID + "=" + uri.getPathSegments().get(1));
			//for(String s : uri.getPathSegments())
			//	Log.w(TAG, s);
			break;
		}
		default: break;
		
		}
		
		String orderBy;
		// if the sort string is empty, sort by date
		if ( TextUtils.isEmpty(sort) ) {
			orderBy = KEY_RATING;
		}
		else {
			orderBy = sort;
		}
		
		// execute the query against the database
		Cursor c = qb.query(recipeDB, 
							projection, 
							selection, 
							selectionArgs, 
							null, null, 
							orderBy);
		// notify the content resolver about the change
		c.setNotificationUri(getContext().getContentResolver(), uri);
		return c;
	}
	
	@Override
	public Uri insert(Uri inuri, ContentValues initValues) {
		long rowID = recipeDB.insert(RECIPE_TABLE, "recipe",
				initValues);
		
		if ( rowID > 0 ) {
			Uri uri = ContentUris.withAppendedId(CONTENT_URI, rowID);
			getContext().getContentResolver().notifyChange(uri, null);
			return uri;
		}
		throw new SQLException("Failed to insert row into " + inuri);
	}


	@Override
	public int delete(Uri uri, String where, String[] whereArgs) {
		int count;
		switch ( uriMatcher.match(uri) ) {
		case RECIPES:
			count = recipeDB.delete(RECIPE_TABLE, where, whereArgs);
			break;
		case RECIPE_ID:
			String segment = uri.getPathSegments().get(1);
			count = recipeDB.delete(RECIPE_TABLE,
					KEY_ID + "=" + segment
					+ (!TextUtils.isEmpty(where) ? " AND ("
							+ where + ")" : ""), whereArgs);
			break;
		default: throw new IllegalArgumentException("Unsupported URI: " + uri);
		}
		getContext().getContentResolver().notifyChange(uri, null);
		return count;
	}
	

	@Override
	public int update(Uri uri, ContentValues values, String where, 
			String[] whereArgs) 
	{
		int count;
		switch ( uriMatcher.match(uri) ) {
		case RECIPES:
			count = recipeDB.update(RECIPE_TABLE,
					values, where, whereArgs);
			break;
		case RECIPE_ID:
			String segment = uri.getPathSegments().get(1);
			count = recipeDB.update(RECIPE_TABLE,
					values,
					KEY_ID + "=" + segment
					+ (!TextUtils.isEmpty(where) ? " AND ("
							+ where + ")" : ""),
							whereArgs);
			break;
		default: throw new IllegalArgumentException("Uknown URI " + uri);
		}
		
		getContext().getContentResolver().notifyChange(uri, null);
		return count;
	}

}
