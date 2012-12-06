package com.markevansjr.fragmentapp;

public class Recipe {
	private String mTitle;
	private String mRating;
	private String mImgUrl;
	
	public String getTitle(){ 
		return mTitle; 
	}
	public String getRating(){ 
		return mRating; 
	}
	public String getImgUrl(){ 
		return mImgUrl; 
	}
	
	public void setTitle(String t){ 
		t = mTitle; 
	}
	public void setRating(String r){ 
		r = mRating; 
	}
	public void setImgUrl(String i){ 
		i = mImgUrl; 
	}
	
	public Recipe(String t, String r,String i){
		mTitle = t;
		mRating = r;
		mImgUrl = i;
	}
}