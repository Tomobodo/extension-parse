package fr.tbaudon.parse ;

import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;

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
	
	
	
}