package fr.tbaudon.parse ;

import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;
import openfl.utils.JNI;

#if cpp
import cpp.Lib;
#end

class Parse {
	
	public static var applicationId(get, null) : String = "";
	public static var RESTApiKey(get, null) : String = "";
	public static var clientKey(get, null) : String = "";
	
	static inline var API_VERSION : Int = 1;
	static inline var PARSE_REST_API : String = "https://api.parse.com";
	
	public static function initialize(applicationId : String, clientKey : String, RESTApiKey : String) {
		Parse.applicationId = applicationId;
		Parse.clientKey = clientKey;
		Parse.RESTApiKey = RESTApiKey;

		#if ios
		objC_initialize(applicationId, clientKey);
		#end
	}
	
	public static function getApiUrl() : String {
		return PARSE_REST_API + "/" + API_VERSION ;
	}
	
	public static function prepareRESTRequest(type : String, otherParameter : String = null) : URLRequest {
		
		var url : String = "";
		
		if(otherParameter == null)
			url = getApiUrl() + "/" + type + "/";
		else
			url = getApiUrl() + "/" + type + "/" + otherParameter;
		
		var request = new URLRequest(url);
		var appId = new URLRequestHeader("X-Parse-Application-Id", Parse.applicationId);
		var appApiKey = new URLRequestHeader("X-Parse-REST-API-Key", Parse.RESTApiKey);
		request.requestHeaders = [appId, appApiKey];
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
	
	static function get_RESTApiKey():String 
	{
		return RESTApiKey;
	}
	
	static function get_clientKey() : String
	{
		return clientKey;
	}
	
	#if android
	
	static var jni_extraData = JNI.createStaticField("fr.tbaudon.parse.ParseWrapper", "extraData", "Ljava/lang/String;");
	
	#elseif ios

	static var objC_initialize = Lib.load("parse", "parse_initialize", 2);

	#end
	
}