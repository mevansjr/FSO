package com.example.recipe.it.up;

import android.os.Bundle;
import android.app.Activity;
import android.util.Log;
import android.view.Menu;
import android.widget.LinearLayout;
import com.example.recipe.it.up.lib.View;
import com.example.recipe.it.up.lib.Recipe;
import com.example.recipe.it.up.lib.Meals;
import java.util.ArrayList;
import com.example.recipe.it.up.lib.Food;
import com.example.recipe.it.up.lib.FoodItem;

public class MainActivity extends Activity {
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        LinearLayout ll = new LinearLayout(this);
        
        // Static Data in Resources that will be data from an API eventually
        Recipe pizza = new Recipe(getString(R.string.pizza_name), getString(R.string.pizza_source), "");
        
        // LinearView layout from my View Class
        LinearLayout setup = View.setup(this, pizza.name+"\n"+pizza.source);
        
        // Extracting info from ENUM and Logging it out.
        String app = Meals.APPITIZERS.toString();
        String ent = Meals.ENTREES.toString();
        String des = Meals.DESSERTS.toString();
        String sal = Meals.SALADS.toString();
        String dri = Meals.DRINKS.toString();
        String [] listArray = { app, ent, des, sal, dri};
        
        // Using ENUM as a comparison for this conditional
        if (Meals.APPITIZERS.toString() == "Appitizers"){
        	for(int i=0; i<listArray.length; i++){
            	String s = listArray[i];
            	Log.i("Meals string: ", s);
            }
        } else {
        	String m = "ENUM didn't compare correctly";
        	Log.i("Error: ", m);
        }
        
        // An ArrayList using an interface for Food Name and Source.
        ArrayList<Food> foods = new ArrayList<Food>();
        foods.add(new FoodItem("Dry Martini", "Food Network"));
        foods.add(new FoodItem("Chocolate Cake", "All Recipes"));
        foods.add(new FoodItem("Cajun Chicken Pasta", "Food"));
        
        ll.addView(setup);
        setContentView(ll);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}
