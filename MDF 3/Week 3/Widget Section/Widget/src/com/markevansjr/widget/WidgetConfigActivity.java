package com.markevansjr.widget;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import android.app.PendingIntent;
import android.app.Service;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;
import android.widget.RemoteViews;
import android.widget.Toast;

//Mark Evans

public class WidgetConfigActivity extends AppWidgetProvider {
	public static WidgetConfigActivity Widget = null;
	public static Context context;
	public static AppWidgetManager appWidgetManager;
	public static int appWidgetIds[];	
	
	@Override
    public void onUpdate( Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds )    {		
		if (null == context) context = WidgetConfigActivity.context;
	    if (null == appWidgetManager) appWidgetManager = WidgetConfigActivity.appWidgetManager;
	    if (null == appWidgetIds) appWidgetIds = WidgetConfigActivity.appWidgetIds;
	    
	    WidgetConfigActivity.Widget = this;
	    WidgetConfigActivity.context = context;
	    WidgetConfigActivity.appWidgetManager = appWidgetManager;
	    WidgetConfigActivity.appWidgetIds = appWidgetIds;
	    
		Log.i("TAG", "onUpdate");
		
		final int N = appWidgetIds.length;
        for (int i=0; i<N; i++) {
            int appWidgetId = appWidgetIds[i];  
            updateAppWidget(context,appWidgetManager, appWidgetId);            
        }
        
    }

	
	static void updateAppWidget(Context context, AppWidgetManager appWidgetManager,
            int appWidgetId) {
        
        DateFormat format = SimpleDateFormat.getTimeInstance( SimpleDateFormat.MEDIUM, Locale.getDefault() );
        CharSequence text = "Time: " + format.format( new Date());
                
        Intent intent = new Intent(context, UpdateService.class);
        PendingIntent pendingIntent = PendingIntent.getService(context, 0, intent, 0);
        
        RemoteViews remoteViews = new RemoteViews(context.getPackageName(), R.layout.widget_layout);
        remoteViews.setOnClickPendingIntent(R.id.LinearLayout01, pendingIntent);
        
        remoteViews.setTextViewText(R.id.widget_textview, text);
 
        // Tell the widget manager
        appWidgetManager.updateAppWidget(appWidgetId, remoteViews);
    }
	
	
	
	public static class UpdateService extends Service {
        @Override
        public void onStart(Intent intent, int startId) {
        	WidgetConfigActivity.Widget.onUpdate(context, appWidgetManager, appWidgetIds);
        	Toast.makeText(context, "Update Widget", Toast.LENGTH_SHORT).show();
        }

		@Override
		public IBinder onBind(Intent arg0) {
			return null;
		}
    }
	
}
