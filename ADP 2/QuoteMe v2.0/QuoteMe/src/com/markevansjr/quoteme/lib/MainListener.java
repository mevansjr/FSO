package com.markevansjr.quoteme.lib;

public interface MainListener {
	public String currentQuote = null;
	public void pass(String pass, String buttonSave, String id, int number);
	public void passForSearch(String objStr, String quote, String author);
	public void passForSaved(String objStr, String quote, String author, String id);
	public void checkForQuote(String thequote, String theauthor);
}

//TODO
	// method to set currentQuote
