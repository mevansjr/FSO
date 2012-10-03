package com.example.recipe.it.up.lib;

public class FoodItem implements Food {

	String name;
	String source;
	
	public FoodItem(String name, String source) {
		setName(name);
		setSource(source);
	}
	
	@Override
	public boolean setName(String name) {
		this.name = name;
		return true;
	}
	
	@Override
	public boolean setSource(String source) {
		this.source = source;
		return true;
	}
	
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return this.name;
	}
	
	@Override 
	public String getSource() {
		// TODO Auto-generated method stub
		return this.source;
	}
}
