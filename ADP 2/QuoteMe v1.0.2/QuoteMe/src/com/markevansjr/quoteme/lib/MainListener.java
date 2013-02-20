package com.markevansjr.quoteme.lib;

public interface MainListener {
	public void pass(String pass);
	public void passForSearch(String objStr, String quote, String author);
	public void passForSaved(String objStr, String quote, String author, String id);
}
