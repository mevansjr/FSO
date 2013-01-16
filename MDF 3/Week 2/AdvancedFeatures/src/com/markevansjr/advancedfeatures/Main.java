package com.markevansjr.advancedfeatures;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TabHost;
import android.widget.TextView;
import android.app.TabActivity;
import android.content.Intent;

@SuppressWarnings("deprecation")
public class Main extends TabActivity {

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		setTabs() ;
	}
	
	private void setTabs()
	{
		addTab("Home", R.drawable.tab_home, Home.class);
		addTab("Media", R.drawable.tab_video, Video.class);
	}
	
	private void addTab(String labelId, int drawableId, Class<?> c)
	{
		TabHost tabHost = getTabHost();
		Intent intent = new Intent(this, c);
		TabHost.TabSpec spec = tabHost.newTabSpec("tab" + labelId);	
		
		View tabIndicator = LayoutInflater.from(this).inflate(R.layout.tab_indicator, getTabWidget(), false);
		TextView title = (TextView) tabIndicator.findViewById(R.id.title);
		title.setText(labelId);
		ImageView icon = (ImageView) tabIndicator.findViewById(R.id.icon);
		icon.setImageResource(drawableId);
		
		spec.setIndicator(tabIndicator);
		spec.setContent(intent);
		tabHost.addTab(spec);
	}
}
