package com.markevansjr.fragmentapp;

import android.app.Application;

public class FoodItems extends Application {
    
    // This static field acts as the app's "fake" database of location data.
    public static final FoodModel[] foods = { 
        new FoodModel(0, "Pizza", R.drawable.thumb_222_w_washington),
        new FoodModel(1, "Salad", R.drawable.thumb_150_e_gilman), 
        new FoodModel(2, "Chocolate Cake", R.drawable.thumb_114_state_st),
        new FoodModel(3, "Pina Colata", R.drawable.thumb_23_n_pinckney)
    };
}
