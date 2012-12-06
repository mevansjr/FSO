package com.markevansjr.fragmentapp;

import java.util.HashMap;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

public class SecondViewFragment extends Fragment {
	
	String _imageUrl;
	
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
		View view = inflater.inflate(R.layout.second_view, container, false);
		return view;
	}

	@SuppressLint("SetJavaScriptEnabled")
	public void setInfo(HashMap<String, String> data) {
		TextView tv = (TextView) getView().findViewById(R.id.text_view_10);
		String title = data.get("title");
		String url = data.get("pf_url");
		String rating = data.get("rating");
		_imageUrl = data.get("source_img");
		tv.setText(title+"\n\n"+url+"\n\n"+rating);
		new DownloadImageTask((ImageView) getView().findViewById(R.id.image_view))
        .execute(_imageUrl);
	}
}
