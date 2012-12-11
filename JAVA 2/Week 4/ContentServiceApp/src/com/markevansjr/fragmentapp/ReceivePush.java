package com.markevansjr.fragmentapp;


import com.parse.ParsePush;

import android.content.Context;

public class  ReceivePush {
	
	Context _context;
	
	static public void getPush(){
	  // Test Push and will also receive push from server side.
      ParsePush push = new ParsePush();
      push.setChannel("Recipe");
      push.setMessage("Welcome to Recipe It Up! Search for your favorite food.");
      push.sendInBackground();
		
	}
}
