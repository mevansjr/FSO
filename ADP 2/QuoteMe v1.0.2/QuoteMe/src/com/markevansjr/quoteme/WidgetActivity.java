package com.markevansjr.quoteme;

import java.util.List;
import java.util.Random;

import com.markevansjr.quoteme.R;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.app.PendingIntent;
import android.app.Service;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.IBinder;
import android.util.Log;
import android.widget.RemoteViews;
import android.widget.Toast;


public class WidgetActivity extends AppWidgetProvider {
	public static WidgetActivity Widget = null;
	public static Context context;
	public static AppWidgetManager appWidgetManager;
	public static int appWidgetIds[];	
	public static String _text;
	public static String _pText;
	static int _random;
	
	@Override
    public void onUpdate( Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds ){		
		if (null == context){
			context = WidgetActivity.context;
		}
		else if (null == appWidgetManager){
			appWidgetManager = WidgetActivity.appWidgetManager;
		}
		else if (null == appWidgetIds){
			appWidgetIds = WidgetActivity.appWidgetIds;
		}
	    
	    WidgetActivity.Widget = this;
	    WidgetActivity.context = context;
	    WidgetActivity.appWidgetManager = appWidgetManager;
	    WidgetActivity.appWidgetIds = appWidgetIds;
	    
		Log.i("TAG", "onUpdate");
		
		final int N = appWidgetIds.length;
        for (int i=0; i<N; i++) {
            int appWidgetId = appWidgetIds[i];  
            updateAppWidget(context,appWidgetManager, appWidgetId);            
        }
        
    }

	
	static void updateAppWidget(Context context, AppWidgetManager appWidgetManager,
            int appWidgetId) {
		ConnectivityManager connec = (ConnectivityManager)context.getSystemService(Context.CONNECTIVITY_SERVICE);
		if (connec != null && (connec.getNetworkInfo(1).isAvailable() == true) ||
				(connec.getNetworkInfo(0).isAvailable() == true)){
			ParseQuery query = new ParseQuery("ListOfQuotes");
			Log.i("WIDGET GET PARSE", "SHOW ALL");
			query.findInBackground(new FindCallback() {
				public void done(List<ParseObject> objects, ParseException e) {
					if (e == null) {
						Random gen = new Random(); 
						int random = gen.nextInt(objects.toArray().length);
						Log.i("WIDGET RANDOM", String.valueOf(random));
						ParseObject s = objects.get(random);
						_text = s.getString("quote");
					}
				}
			});
		} else {
			Toast toast = Toast.makeText(context, "NO CONNECTION", Toast.LENGTH_SHORT);
			toast.show();
		}
        
        //DateFormat format = SimpleDateFormat.getTimeInstance( SimpleDateFormat.MEDIUM, Locale.getDefault() );
        //CharSequence text = format.format( new Date());
                
        Intent intent = new Intent(context, UpdateService.class);
        PendingIntent pendingIntent = PendingIntent.getService(context, 0, intent, 0);
        
        RemoteViews remoteViews = new RemoteViews(context.getPackageName(), R.layout.widget_layout);
        remoteViews.setOnClickPendingIntent(R.id.LinearLayout1, pendingIntent);
        
        //String scheme = "open://quoteme/";
        //Intent btnIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(scheme));
		//PendingIntent pi = PendingIntent.getActivity(context, 0, btnIntent, 0);
		
		//remoteViews.setOnClickPendingIntent(R.id.widget_button, pi);
        
		remoteViews.setTextViewText(R.id.widget_textview, _text);
		
        // Tell the widget manager
        appWidgetManager.updateAppWidget(appWidgetId, remoteViews);
    }
	
	
	
	public static class UpdateService extends Service {
        @Override
        public void onStart(Intent intent, int startId) {
        	WidgetActivity.Widget.onUpdate(context, appWidgetManager, appWidgetIds);
        	Toast.makeText(context, "Update Widget", Toast.LENGTH_SHORT).show();
        }

		@Override
		public IBinder onBind(Intent arg0) {
			return null;
		}
    }
	
}
