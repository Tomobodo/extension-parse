package org.haxe.extension.parse;

import android.app.Application;

import com.parse.Parse;

public class ParseApp extends Application{

	@Override
	public void onCreate() {
		// TODO Auto-generated method stub
		super.onCreate();

		// support for new open source parse server
		Parse.initialize(new Parse.Configuration.Builder(this.getApplicationContext())
		    .applicationId("::ENV_Parse_AppId::")
		    .clientKey(null)
		    .server("::ENV_Parse_url::") // The trailing slash is important.
		    .build()
		);
	}
	
}
