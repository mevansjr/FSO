package com.markevansjr.recipeapp.lib;

public enum Meals {
	ENTREES("Entree"),
	APPITIZERS("Appitizers"),
	DRINKS("Drinks"),
	SALADS("Salads"),
	DESSERTS("Desserts");
	    
	private Meals(final String text) {
	        this.text = text;
	    }

	    private final String text;

	    @Override
	    public String toString() {
	    	// TODO Auto-generated method stub
	    	return text;
	    }
}