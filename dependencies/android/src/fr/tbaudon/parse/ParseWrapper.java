package fr.tbaudon.parse;


import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import android.content.Intent;
import android.os.Bundle;

import com.parse.Parse;
import com.parse.ParseObject;
import com.parse.ParseQuery;


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
	
	public static void initialize(String applicationId, String clientKey){
		Parse.initialize(mainContext, applicationId, clientKey);
	}
	
	public static ParseObject createParseObject(String name){
		return new ParseObject(name);
	}
	
	public static String toJavaString(String object){
		return object;
	}
	
	public static Number fromIntTojavaNumber(int num){
		return num;
	}
	
	public static Number fromFloatTojavaNumber(float num){
		return num;
	}
	
	public static ParseQuery<ParseObject> getObjectQuery(String className){
		ParseQuery<ParseObject> query = ParseQuery.getQuery(className);
		return query;
	}
	
}