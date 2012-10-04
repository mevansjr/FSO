package com.example.recipe.it.up;

import android.os.Bundle;
import android.app.Activity;
import android.util.Log;
import android.view.Menu;
import android.widget.LinearLayout;
import com.example.recipe.it.up.lib.SetupView;
import com.example.recipe.it.up.lib.Recipe;
import com.example.recipe.it.up.lib.Meals;
import java.util.ArrayList;
import com.example.recipe.it.up.lib.Food;
import com.example.recipe.it.up.lib.FoodItem;
import java.util.Arrays;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;  
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.view.View;

public class MainActivity extends Activity {
	
	private ListView mainListView;  
	private ArrayAdapter<String> listAdapter;
	  
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); 
        setContentView(R.layout.main);
        android.view.View theLL =  findViewById(R.id.info);
        
        LinearLayout ll = new LinearLayout(this);
        // LinearView layout from my View Class
        LinearLayout setup = SetupView.setup(this, "Look for Recipes", "Search");
        
        Button findButton = (Button) setup.findViewById(2);
        findButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				String logstuff = "Dynamic Data from API will search from here";
				Log.i("SEARCH ONCLICK:", logstuff);
			}
		});
        
        ll.addView(setup);
        ((LinearLayout) theLL).addView(ll);
        
        // Static Data in Resources that will be data from an API eventually
        Recipe pizza = new Recipe(getString(R.string.pizza_name), getString(R.string.pizza_source), getString(R.string.pizza_ingredients));
        Recipe cake = new Recipe(getString(R.string.cake_name), getString(R.string.cake_source), getString(R.string.cake_ingredients));
        Recipe drink = new Recipe(getString(R.string.screwdriver_name), getString(R.string.screwdriver_source), getString(R.string.screwdriver_ingredients));
        Recipe pasta = new Recipe(getString(R.string.cajunchicken_name), getString(R.string.cajunchicken_source), getString(R.string.cajunchicken_ingredients));
        Recipe sandwich = new Recipe(getString(R.string.turkeysandwich_name), getString(R.string.turkeysandwich_source), getString(R.string.turkeysandwich_ingredients));
        
        // An Array using the Recipe Class
        final Recipe[] AllFoods = {
        	pizza,
        	cake,
        	drink,
        	pasta,
        	sandwich
        };
        // An Array of Recipes Food Names
        String[] AllFoodNames = {
            	pizza.name,
            	cake.name,
            	drink.name,
            	pasta.name,
            	sandwich.name
            };
        // Find the ListView resource.   
        mainListView = (ListView) findViewById( R.id.mainListView );
        // Created ArrayList Names
        ArrayList<String> allFoodsNamesList = new ArrayList<String>();  
        allFoodsNamesList.addAll( Arrays.asList(AllFoodNames) );
        
        // Created ArrayAdapter using the allFoodsNames list.  
        listAdapter = new ArrayAdapter<String>(this, R.layout.simplerow, allFoodsNamesList); 
        // Set the ArrayAdapter as the ListView's adapter.  
        mainListView.setAdapter(listAdapter);
        
        mainListView.setOnItemClickListener(new OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> arg0,
					View theListAdapter, int arg2, long arg3) {
				TextView s = (TextView) theListAdapter;
				Log.i("SHOW NAME: ", s.getText().toString());
				String selectedRecipe = s.getText().toString();
				for(int i=0; i<AllFoods.length; i++){
	            	Recipe findRecipeStr = AllFoods[i];
	            	if (selectedRecipe == findRecipeStr.name) {
	            		String theIngred = findRecipeStr.ingredients;
	            		Log.i("SHOW INGRED: ", theIngred);
	            	} 
				}
				
			}
        });
        
        // Extracting info from ENUM and Logging it out.
        String app = Meals.APPITIZERS.toString();
        String ent = Meals.ENTREES.toString();
        String des = Meals.DESSERTS.toString();
        String sal = Meals.SALADS.toString();
        String dri = Meals.DRINKS.toString();
        String [] enumArray = { app, ent, des, sal, dri};
        
        // Using ENUM as a comparison for this conditional. This is just to test may come up with a different way to show conditionals.
        if (Meals.APPITIZERS.toString() == "Appitizers"){
        	for(int i=0; i<enumArray.length; i++){
            	String s = enumArray[i];
            	Log.i("ENUM STRING: ", s);
            }
        } else {
        	String m = "ENUM didn't compare correctly";
        	Log.i("Error: ", m);
        }
        
        // An ArrayList using an interface for Food Name and Source. Not really doing anything with it yet.
        ArrayList<Food> foods = new ArrayList<Food>();
        foods.add(new FoodItem("Dry Martini", "Food Network"));
        foods.add(new FoodItem("Chocolate Cake", "All Recipes"));
        foods.add(new FoodItem("Cajun Chicken Pasta", "Food"));
        
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
