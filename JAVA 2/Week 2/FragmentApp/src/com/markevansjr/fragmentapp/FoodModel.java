package com.markevansjr.fragmentapp;

// A very simple model that defines the location data that this app deals with.
public class FoodModel {
    public int    id;
    public String name;
    public int    picture;
    
    public FoodModel(int id, String address, int picture) {
        this.id      = id;
        this.name = address;
        this.picture = picture;
    }
}
