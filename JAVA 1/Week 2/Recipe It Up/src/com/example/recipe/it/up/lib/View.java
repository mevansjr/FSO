package com.example.recipe.it.up.lib;

import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.content.Context;

public class View {
	
	public static LinearLayout setup(Context context, String textForTV){
		LinearLayout ll = new LinearLayout(context);
		LayoutParams lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        ll.setLayoutParams(lp);
		
        TextView tv = new TextView(context);
        tv.setText(textForTV); 
        
        ll.addView(tv);
        
		return ll;
	}
}
