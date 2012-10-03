package com.example.recipe.it.up.lib;

public class Recipe{
	public String name;
	public String source;
	public String ingredients;
	public Recipe(String foodName, String foodSource, String foodIngredients){
		name = foodName;
		source = foodSource;
		ingredients = foodIngredients;
	}
}