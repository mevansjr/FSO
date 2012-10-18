package com.mevansjr.simpleweather;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.util.Log;
import android.widget.LinearLayout;
import android.widget.TextView;

public class WeatherDisplay extends LinearLayout {
	
	String _current = "";
	WeatherInfo _zip;
	WeatherInfo _name;
	WeatherInfo _tempF;
	WeatherInfo _tempC;
	WeatherInfo _forcast;
	WeatherInfo _time;
	JSONObject _weatherdata;
	JSONObject _weatherdataName;
	
	public WeatherDisplay(Context context){
		super(context);
		
		this.setOrientation(LinearLayout.VERTICAL);

		_zip = new WeatherInfo(context, "Zip:");
		_name = new WeatherInfo(context, "Location:");
		_tempF = new WeatherInfo(context, "Temp(F):");
		_tempC = new WeatherInfo(context, "Temp(C):");
		_forcast = new WeatherInfo(context, "Forcast:");
		_time = new WeatherInfo(context, "Time:");
		
		this.addView(_zip);
		this.addView(_name);
		this.addView(_tempF);
		this.addView(_tempC);
		this.addView(_forcast);
		this.addView(_time);
	}
	
	public void updateData(JSONObject data){
		_weatherdata = data;
		try{
			_current = data.getJSONObject("display_location").getString("zip");
			_zip.setInfo(data.getJSONObject("display_location").getString("zip"));
			_name.setInfo(data.getJSONObject("display_location").getString("full"));
			_tempF.setInfo(data.getString("temp_f"));
			_tempC.setInfo(data.getString("temp_c"));
			_forcast.setInfo(data.getString("weather"));
			_time.setInfo(data.getString("observation_time"));
		} catch (JSONException e){
			Log.i("JSON EXCEPTION", data.toString());
		}
	}

	private class WeatherInfo extends LinearLayout {
	
		TextView _info;
		
		public WeatherInfo(Context context){
			super(context);
		}
		
		public WeatherInfo(Context context, String labelText){
			super(context);
			
			this.setOrientation(LinearLayout.HORIZONTAL);
			LayoutParams lp;
			
			TextView label = new TextView(context);
			label.setText(labelText);
			label.setTextAppearance(context, R.style.theLabelStuff);
			lp = new LayoutParams(0,LayoutParams.WRAP_CONTENT,1.0f);
			label.setLayoutParams(lp);
			label.setPadding(8, 0, 0, 0);
			this.addView(label);
			
			_info = new TextView(context);
			_info.setTextAppearance(context, R.style.theInfoStuff);
			lp = new LayoutParams(0,LayoutParams.WRAP_CONTENT,3.0f);
			_info.setLayoutParams(lp);
			_info.setPadding(4, 0, 0, 0);
			this.addView(_info);
		}
		
		public void setInfo(String data){
			_info.setText(data);
		}
	}

}



