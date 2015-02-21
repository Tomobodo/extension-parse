package fr.tbaudon.parse ;

class Parse {
	
	public static var applicationId(get, null) : String = "";
	public static var RESTApiKey(get, null) : String = "";
	
	static inline var API_VERSION : Int = 1;
	static inline var PARSE_REST_API : String = "https://api.parse.com";
	
	public static function init(applicationId : String) {
		Parse.applicationId = applicationId;
	}
	
	public static function initDataApi(RESTApiKey : String) {
		Parse.RESTApiKey = RESTApiKey;
	}
	
	public static function getApiUrl() : String {
		return PARSE_REST_API + "/" + API_VERSION ;
	}
	
	static function get_applicationId():String 
	{
		return applicationId;
	}
	
	static function get_RESTApiKey():String 
	{
		return RESTApiKey;
	}
	
}