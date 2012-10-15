package com.markevansjr.recipeapp.lib;

import android.content.Context;
import android.widget.Button;
import android.widget.TableLayout;
import android.widget.TableRow;

public class TableDisplay extends TableLayout
{
    @SuppressWarnings("deprecation")
	public TableDisplay(Context context) {
        super(context);

        setLayoutParams(new TableLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
        TableRow row = new TableRow(context);
        row.setLayoutParams(new TableRow.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));

        Button b = new Button(getContext());
        b.setText("hello");
        b.setLayoutParams(new LayoutParams(TableRow.LayoutParams.FILL_PARENT, TableRow.LayoutParams.WRAP_CONTENT));
        row.addView(b); 
        addView(row);
    }
}