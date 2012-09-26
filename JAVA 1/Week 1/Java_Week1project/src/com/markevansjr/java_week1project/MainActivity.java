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
	TextView altTv;
	boolean addTextView;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Set up Layout and Params
        ll = new LinearLayout(this);
        ll.setOrientation(LinearLayout.VERTICAL);
        lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        ll.setLayoutParams(lp);
        
        // Set TextView
        tv = new TextView(this);
        tv.setText("Player Names\n\n");
        // Loop of Players and casted an INT
        String[] players = {"Ray Lewis", "Ed Reed", "Joe Flacco", "Ray Rice", "Terrell Suggs"};
        int size = players.length;
        for (int i=0; i<size; i++)
        {
          tv.append((players[i]+"\n"));
        }
        
        // Loop for added players using Resource strings
        String[] addedplayers = {getString(R.string.torrey_smith), getString(R.string.ed_dickson)};
        int addedsize = addedplayers.length;
        for (int i=0; i<addedsize; i++)
        {
          tv.append((addedplayers[i]+"\n"));
        }
        
        altTv = new TextView(this);
        altTv.setText("Boolean was not set to yes.");
        
        // Added textView to Layout with condition and boolean values
        String input = "yes";
        if (input.equals("yes")) {
           addTextView = true;
           ll.addView(tv);
        } else {
        	addTextView = false;
        	ll.addView(altTv);
        }
        setContentView(ll);
}

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
