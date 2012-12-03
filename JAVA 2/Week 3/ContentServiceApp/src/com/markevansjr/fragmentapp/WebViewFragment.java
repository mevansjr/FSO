package com.markevansjr.fragmentapp;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class WebViewFragment extends Fragment {
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View view = inflater.inflate(R.layout.web_view, container, false);
		return view;
	}

	@SuppressLint("SetJavaScriptEnabled")
	public void setNewPage(String url) {
		TextView tv = (TextView) getView().findViewById(R.id.text_view_10);
		tv.setText(url);
		Log.i("TAG from WebFrag:",url);
	}
}
