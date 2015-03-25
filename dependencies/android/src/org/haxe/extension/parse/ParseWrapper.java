package org.haxe.extension.parse;


import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.parse.ParseAnalytics;
import com.parse.ParseException;
import com.parse.ParseInstallation;
import com.parse.ParsePush;
import com.parse.SaveCallback;


/* 
	You can use the Android Extension class in order to hook
	into the Android activity lifecycle. This is not required
	for standard Java code, this is designed for when you need
	deeper integration.
	
	You can access additional references from the Extension class,
	depending on your needs:
	
	- Extension.assetManager (android.content.res.AssetManager)
	- Extension.callbackHandler (android.os.Handler)
	- Extension.mainActivity (android.app.Activity)
	- Extension.mainContext (android.content.Context)
	- Extension.mainView (android.view.View)
	
	You can also make references to static or instance methods
	and properties on Java classes. These classes can be included 
	as single files using <java path="to/File.java" /> within your
	project, or use the full Android Library Project format (such
	as this example) in order to include your own AndroidManifest
	data, additional dependencies, etc.
	
	These are also optional, though this example shows a static
	function for performing a single task, like returning a value
	back to Haxe from Java.
*/
public class ParseWrapper extends Extension {
	
	public static String extraData;
	
	private static HaxeObject mHaxeParse;
	
	public static void initialize(HaxeObject HaxeParse){
		mHaxeParse = HaxeParse;
	}
	
	public static void subscribe() {
		ParsePush.subscribeInBackground("global", new SaveCallback() {
			
			@Override
			public void done(ParseException e) {
				if(e == null){
					Log.i("trace", "successfully suscribed");
					
					ParseInstallation install = ParseInstallation.getCurrentInstallation();
					String installId = install.getObjectId();
					
					mHaxeParse.call1("onInstallationIdObtained", installId);
				}
				else{
					Log.i("trace", "failed to subscribe", e);
					
					mHaxeParse.call0("onCanNotObtainInstallationId");
				}
			}
		});
	}
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		Intent intent = mainActivity.getIntent();
		Bundle bundle = intent.getExtras();
		
		if(bundle != null) {
			if(bundle.containsKey("com.parse.Data"))
				extraData = bundle.getString("com.parse.Data");
		}
		
		ParseAnalytics.trackAppOpenedInBackground(intent);
	}
	
}