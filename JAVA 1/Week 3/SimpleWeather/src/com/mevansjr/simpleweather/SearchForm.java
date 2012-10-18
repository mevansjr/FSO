package com.mevansjr.simpleweather;

import android.content.Context;
import android.text.InputType;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

public class SearchForm extends LinearLayout{

	EditText _searchField;
	Button _searchButton;
	
	public SearchForm(Context context){
		super(context);
	}
	
	public SearchForm(Context context, String hint, String buttonText){
		super(context);
		
		LayoutParams lp;
		
		_searchField = new EditText(context);
		_searchField.setInputType(InputType.TYPE_CLASS_NUMBER);
		lp = new LayoutParams(0, LayoutParams.WRAP_CONTENT, 1.0f);
		_searchField.setLayoutParams(lp);
		_searchField.setHint(hint);
		
		_searchButton = new Button(context);
		_searchButton.setText(buttonText);
		
		this.addView(_searchField);
		this.addView(_searchButton);
		
		lp = new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT);
		this.setLayoutParams(lp);
	}
	
	public EditText getField(){
		return _searchField;
	}
	
	public Button getButton(){
		return _searchButton;
	}
	
}
