package fr.tbaudon.parse;

import android.content.Context;
import android.content.Intent;

import com.parse.ParseAnalytics;
import com.parse.ParsePushBroadcastReceiver;

public class ParseReceiver extends ParsePushBroadcastReceiver{
	
	@Override
	protected void onPushOpen(Context arg0, Intent intent) {
		// TODO Auto-generated method stub
		super.onPushOpen(arg0, intent);
		ParseAnalytics.trackAppOpenedInBackground(intent);
	}
	
}
