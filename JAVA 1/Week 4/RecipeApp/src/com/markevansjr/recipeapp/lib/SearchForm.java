package com.markevansjr.recipeapp.lib;
import android.widget.LinearLayout.LayoutParams;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.EditText;
import android.content.Context;
import android.graphics.Color;

public class SearchForm {
	

	@SuppressWarnings("deprecation")
	public static LinearLayout setup(Context context, String hint, String buttonText){
		LinearLayout ll = new LinearLayout(context);
		LayoutParams lp = new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT);
        ll.setLayoutParams(lp);
		
        EditText et = new EditText(context);
        lp = new LayoutParams(0, LayoutParams.WRAP_CONTENT, 1.0f);
        et.setHint(hint);
        et.setHintTextColor(Color.LTGRAY);
        et.setTextColor(Color.WHITE);
        et.setLayoutParams(lp);
        et.setId(1);
        et.setTextSize(15.0f);
        
        Button b = new Button(context);
        b.setText(buttonText);
        b.setTextColor(Color.YELLOW);
        b.setBackgroundColor(Color.DKGRAY);
        b.setId(2);
        b.setTag(et);
        b.setTextSize(15.0f);

        ll.addView(et);
        ll.addView(b);
        
		return ll;
	}
}
