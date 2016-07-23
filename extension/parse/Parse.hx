package extension.parse ;

import haxe.macro.Context;
import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;
import openfl.utils.JNI;

#if cpp
import cpp.Lib;
#end

class Parse {
	
	public static var applicationId(get, null) : String = "";
	public static var serverURL(get,null) :String = "";
		
	public static function initialize() {
		Parse.applicationId = ParseMacro.getProjectEnv("Parse_AppId");
		Parse.serverURL = ParseMacro.getProjectEnv("Parse_url");

		#if android
		jni_initialize(ParsePush);
		#elseif ios
		objC_initialize(applicationId);
		#end
	}
	
	public static function getApiUrl() : String {
		return Parse.serverURL;
	}
	
	public static function prepareRESTRequest(type : String, otherParameter : String = null) : URLRequest {
		
		var url : String = "";
		
		if(otherParameter == null)
			url = getApiUrl() + "/" + type + "/";
		else
			url = getApiUrl() + "/" + type + "/" + otherParameter;
		
		var request = new URLRequest(url);
		var appId = new URLRequestHeader("X-Parse-Application-Id", Parse.applicationId);
		
		request.requestHeaders = [appId];
		request.contentType = "application/json";
		
		return request;
	}
	
	public static function getExtraData() : String {
		
		var data : String = null;
		
		#if android
		
		data = jni_extraData.get();
		
		#end
		
		return data;
	}
	
	static function get_applicationId():String 
	{
		return applicationId;
	}
	
	static function get_serverURL():String
	{
		return serverURL;
	}

	#if android
	
	static var jni_initialize = JNI.createStaticMethod("org.haxe.extension.parse.ParseWrapper", "initialize", "(Lorg/haxe/lime/HaxeObject;)V");
	static var jni_extraData = JNI.createStaticField("org.haxe.extension.parse.ParseWrapper", "extraData", "Ljava/lang/String;");
	
	#elseif ios

	static var objC_initialize = Lib.load("parse", "initialize", 2);

	#end
	
}