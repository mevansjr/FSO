package com.markevansjr.fragmentapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity implements MainFragment.MainListener {

	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        TextView tv = (TextView) findViewById(R.id.textView_1);
        tv.setText("Recipe Catergories");
        tv.setPadding(5,11,25,12);
    }

	@Override
	public void onCategorySelected(String url) {
		WebViewFragment fragment = (WebViewFragment) getFragmentManager().findFragmentById(R.id.webViewFrag);
		if (fragment != null && fragment.isInLayout()) {
			fragment.setNewPage(url);
		} else {
			Intent intent = new Intent(getApplicationContext(), WebViewActivity.class);
			intent.putExtra("url", url);
			startActivity(intent);
		}
	}
	
}