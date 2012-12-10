package com.markevansjr.fragmentapp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.markevansjr.fragmentapp.R;
import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.AdapterView.OnItemClickListener;

public class SavedRecipes extends Activity {
	
	ListView _lv;
	List<Map<String, String>> _data2;
	SimpleAdapter _adapter2;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if (getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
			finish();
			
			return;
		}

		setContentView(R.layout.saved_recipes);
		
		// Inits my Third Party Library PARSE
        Parse.initialize(this, "PV07xPdLpxzJKBKUS2UP6iJ0W9GbEHvmfPMMQovz", "OPxrcJKt4Pe26WHvCAeuI86hnGzXjOlO1NmyfJyP");
        
        // List View setup for data from PARSE
        _lv = (ListView) findViewById(R.id.listView2);

        ParseQuery query = new ParseQuery("savedFavObject");
        query.findInBackground(new FindCallback() {
          public void done(List<ParseObject> objects, ParseException e) {
            if (e == null) {
            
            if (objects.toArray().length > 0){
            _data2 = new ArrayList<Map<String, String>>();
            	
              for(int ii=0;ii<objects.toArray().length;ii++){							
      			ParseObject s = objects.get(ii);
      			Map<String, String> map = new HashMap<String, String>(2);
    			map.put("title", s.getString("title"));
    			map.put("source_name", s.getString("source"));
    		    map.put("pf_url", s.getString("recipe_url"));
    		    map.put("rating", s.getString("rating"));
    		    map.put("source_img", s.getString("img_url"));
    		    map.put("check", "true");
    		    map.put("id", s.getObjectId());
    		    _data2.add(map);
              }
              
           // List adapter is set
              _adapter2 = new SimpleAdapter(getApplicationContext(), _data2, android.R.layout.simple_list_item_2,
                      new String[] {"title", "source_name", "pf_url", "rating", "source_img", "check", "id"},
                      new int[] {android.R.id.text1,
                                 android.R.id.text2});
              _lv.setAdapter(_adapter2);
              
              _lv.setOnItemClickListener(new OnItemClickListener() {
              	public void onItemClick(AdapterView<?> parent, View view, int position, long id) {        		
              		@SuppressWarnings("unchecked")
      				HashMap<String, String> o = (HashMap<String, String>) _lv.getItemAtPosition(position);
              		
              		SecondViewFragment fragment = (SecondViewFragment) getFragmentManager().findFragmentById(R.id.secViewFrag);
              		if (fragment != null && fragment.isInLayout()) {
              			fragment.setInfo(o);
              		} else {
              			// Info is set to the details view via intent
              			Intent intent = new Intent(getApplicationContext(), SecondViewActivity.class);
              			intent.putExtra("RecipeData", o.toString());
              			intent.putExtra("RecipeTitle", o.get("title"));
              			intent.putExtra("RecipeUrl", o.get("pf_url"));
              			intent.putExtra("RecipeRating", o.get("rating"));
              			intent.putExtra("RecipeImageUrl", o.get("source_img"));
              			intent.putExtra("check", "true");
              			intent.putExtra("id", o.get("id"));
              			startActivity(intent);
              		}
      			}
      		});
           
            } else {
            	Log.i("FROM PARSE::", "NO DATA STORED");
            }
              
            } else {
              Log.e("ERROR::", "ERROR");
            }
          }
        });
		
	}
}
