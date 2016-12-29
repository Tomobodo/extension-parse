package org.haxe.extension.parse;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import com.parse.Parse;

public class ParseApp extends Application{

	private static ParseApp instance = new ParseApp();

    public ParseApp() {
        instance = this;
    }

    public static Context getContext() {
        return instance;
    }

	@Override
	public void onCreate() {
		// TODO Auto-generated method stub
		super.onCreate();

		Log.e("PARSE", "------------------------------Parse APP used!");

		// support for new open source parse server
		Parse.initialize(new Parse.Configuration.Builder(getContext())
		    .applicationId("::Parse_AppId::")
		    .clientKey(null)
		    .server("::Parse_url::") // The trailing slash is important.
		    .build()
		);
	}
	
}
