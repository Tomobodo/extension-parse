package fr.tbaudon.parse;

import android.app.Application;

import com.parse.Parse;

public class ParseApp extends Application{

	@Override
	public void onCreate() {
		// TODO Auto-generated method stub
		super.onCreate();
		
		Parse.initialize(this.getApplicationContext(), "::ENV_Parse_AppId::", "::Parse_clientKey::");
	}
	
}
