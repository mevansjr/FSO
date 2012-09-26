package com.markevansjr.java_week1project;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MainActivity extends Activity {

	LinearLayout ll;
	LinearLayout.LayoutParams lp;
	TextView tv;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        ll = new LinearLayout(this);
        ll.setOrientation(LinearLayout.VERTICAL);
        lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        ll.setLayoutParams(lp);
        
        tv = new TextView(this);
        tv.setText("Player Names\n\n");
        String[] toppings = {"Ray Lewis", "Ed Reed", "Joe Flacco", "Ray Rice", "Terrel Suggs"};
        int size = toppings.length;
        for (int i=0; i<size; i++)
        {
          tv.append((toppings[i]+"\n"));
        }
        
        ll.addView(tv);
        setContentView(ll);
}

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
