package com.markevansjr.recipeapp.lib;

import android.annotation.TargetApi;
import android.content.Context;
import android.widget.Button;
import android.widget.GridLayout;
import android.widget.TextView;

@TargetApi(14)
public class RecipeDisplay extends GridLayout {

	TextView _title;
	TextView _subTitle;
	Context _context;
	
	public RecipeDisplay(Context context){
		super(context);
		
		_context = context;
		this.setColumnCount(2);
		
		TextView titleLabel = new TextView(_context);
		titleLabel.setText("Recipe: ");
		_title = new TextView(_context);
		
		
		TextView subTitleLabel = new TextView(_context);
		subTitleLabel.setText("Source: ");
		_subTitle = new TextView(_context);
		
		Button addToFav = new Button(_context);
		addToFav.setText("Add");
		
		this.addView(titleLabel);
		this.addView(_title);
		this.addView(subTitleLabel);
		this.addView(_subTitle);
		this.addView(addToFav);
	}
}
