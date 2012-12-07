package com.markevansjr.fragmentapp;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.*;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.net.Uri;
import android.util.Log;

public class RecipeProvider extends ContentProvider {
	
	public static String PROVIDER_NAME = "com.markevansjr.ContentServiceApp.provider";
	public static final Uri CONTENT_URI = Uri.parse("content://"+PROVIDER_NAME+"/item");
	private static final UriMatcher uriMatcher;
	static {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI("com.markevansjr.ContentServiceApp.provider", "", 1);
		uriMatcher.addURI("com.markevansjr.ContentServiceApp.provider", "*", 2);
	}
	
	HashMap<String, String> _recents;

		@Override
		public int delete(Uri arg0, String arg1, String[] arg2) {
			// TODO Auto-generated method stub
			return 0;
		}
		

		@Override
		public String getType(Uri uri) {
			switch (uriMatcher.match(uri)){
			case 1:
				return "com.markevansjr.ContentServiceApp.provider.recents";
			case 2:
				return "com.markevansjr.ContentServiceApp.search";
				default:
					throw new IllegalArgumentException("Unsupported URI: "+ uri);
		}
	}


		@Override
		public Uri insert(Uri uri, ContentValues values) {
			// TODO Auto-generated method stub
			return null;
		}


		@SuppressWarnings("unchecked")
		@Override
		public boolean onCreate() {
			Context context = getContext();
			Object stored = FileStuff.readObjectFile(context, "recent", false);
			if (stored == null){
				_recents = new HashMap<String, String>();
				return false;
			} else {
				_recents = (HashMap<String, String>) stored;
				return true;
			}
		}


		@Override
		public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
			MatrixCursor result = new MatrixCursor(new String[] {"_id", "title", "source_name", "rating", "pf_url", "source_img"});
			if(uriMatcher.match(uri)==2){
				String item = uri.getPathSegments().get(0).toString();
				String value = _recents.get(item);
				if(value != null){
					try{
						JSONObject data = new JSONObject(value);
						result.addRow(new Object[] {0, data.get("title"), data.get("source_name"), data.get("rating"), data.get("pf_url"), data.get("source_img") });
					} catch (JSONException e) {
						Log.e("JSON EXCEPTION", e.toString());
					}
				}
			} else {
				int id = 0;
				for (Map.Entry<String, String> entry : _recents.entrySet()){
					String value = entry.getValue();
					try{
						JSONObject data = new JSONObject(value);
						result.addRow(new Object[] {id, data.get("title"), data.get("source_name"), data.get("rating"), data.get("pf_url"), data.get("source_img") });
					} catch (JSONException e){
						Log.e("JSON EXCEPTION", e.toString());
					}
				}
			}
			return result;
		}


		@Override
		public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
			if(uriMatcher.match(uri)==2){
				String item = uri.getPathSegments().get(0).toString();
				_recents.put(item, selection);
				FileStuff.storeObjectFile(getContext(), "recent", _recents, false);
				return 1;
			} else {
				return 0;
			}
		}
}
