package com.markevansjr.java_week1project;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Button;
import android.widget.EditText;
import android.app.AlertDialog;
import android.content.DialogInterface;

public class MainActivity extends Activity {

	LinearLayout ll;
	LinearLayout.LayoutParams lp;
	TextView tv;
	TextView altTv;
	EditText et;
	boolean addTextView;
	AlertDialog alert;
	
    @SuppressWarnings("deprecation")
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Set up Linear Layout
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
        
        // Alternate TextView for condition
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
        
        // Creates instance of alert
        alert = new AlertDialog.Builder(this).create();
        
        // Edit and Button View
        et = new EditText(this);
        et.setHint("Add a Player's Full Name");
        
        Button b = new Button(this);
        b.setText("Submit");
        // Event onClick listener
        b.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				String entry = et.getText().toString();
				if (entry.length() <= 0){
					// set up alert
					alert.setTitle("Alert");
					alert.setMessage("Player name can NOT be blank!");
					alert.setButton("Close", new DialogInterface.OnClickListener() {
					      public void onClick(final DialogInterface dialog, final int which) {
					    	  //Add Stuff
					    } });
					alert.show();
				} else {
					tv.append(entry+"\r\n");
				}
			}
		});
        
        // Set Form layout horizontal for button and text field
        LinearLayout form = new LinearLayout(this);
        form.setOrientation(LinearLayout.HORIZONTAL);
        form.setLayoutParams(lp);
        form.addView(et);
        form.addView(b);
        
        ll.addView(form);
        setContentView(ll);
}

	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
