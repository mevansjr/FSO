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
import android.graphics.Color;

public class MainActivity extends Activity {

	LinearLayout ll;
	LinearLayout.LayoutParams lp;
	TextView tv;
	TextView header;
	TextView altTv;
	EditText et;
	boolean addTextView;
	AlertDialog alert;
	int total;
	
    @SuppressWarnings("deprecation")
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Set up Linear Layout
        ll = new LinearLayout(this);
        ll.setOrientation(LinearLayout.VERTICAL);
        lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        ll.setLayoutParams(lp);
        
        // Set TextView and header TextView
        header = new TextView(this);
        header.setText("Player Names");
        header.setBackgroundColor(Color.BLUE);
        header.setTextColor(Color.WHITE);
        ll.addView(header);
        tv = new TextView(this);
        
        // Loop of Players
        String[] players = {"Ray Lewis", "Ed Reed", "Joe Flacco", "Ray Rice", "Terrell Suggs"};
        // INT created for amounts of players in array
        int size = players.length;
        for (int i=0; i<size; i++)
        {
          tv.append((players[i]+"\n"));
        }
        
        // Loop for added players using Resource strings
        String[] addedplayers = {getString(R.string.torrey_smith), getString(R.string.ed_dickson)};
        // INT created for amounts of players array
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
			//onClick Function
			@Override
			public void onClick(View v) {
				String entry = et.getText().toString();
				if (entry.length() <= 0){
					// set up alert
					alert.setTitle("Blank Entry");
					alert.setMessage("Player name can NOT be blank!");
					alert.setButton("Close", new DialogInterface.OnClickListener() {
					      public void onClick(final DialogInterface dialog, final int which) {
					    	  //Add Stuff
					    } });
					alert.show();
				} else {
					tv.append(entry+"\r\n");
					alert.setTitle("Added Player");
					alert.setMessage("New Player was added.");
					alert.setButton("Close", new DialogInterface.OnClickListener() {
					      public void onClick(final DialogInterface dialog, final int which) {
					    	  //Add Stuff
					    } });
					alert.show();
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
