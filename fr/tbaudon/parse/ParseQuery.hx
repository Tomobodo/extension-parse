package fr.tbaudon.parse;
import haxe.Json;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;

import openfl.events.Event;
import openfl.events.HTTPStatusEvent;
import openfl.events.IOErrorEvent;

/**
 * ...
 * @author Thomas B
 */
class ParseQuery<T:(ParseObject)> {
	
	var mClassName : String;
	
	var mObjectClass : Class<ParseObject>;
	
	var mRequest : URLRequest;
	var mBaseUrl : String;
	
	var mUrlLoader : URLLoader;
	
	var mRequestType : String;
	
	var mGetCallBack : T -> ParseException -> Void;
	
	var mRequestSuccess : Bool;
	
	public static function getQuery<T>(objectClass : Class<ParseObject>, className : String = null) {
		return new ParseQuery<T>(className, objectClass);
	}

	function new(className : String, objectClass : Class<ParseObject>) {
		mClassName = className;
		mObjectClass = objectClass;
		
		mRequest = Parse.prepareRESTRequest(Reflect.field(objectClass, "getTypeName")(), mClassName);
		mBaseUrl = mRequest.url;
		
		mUrlLoader = new URLLoader();
		
		mUrlLoader.addEventListener(Event.COMPLETE, onRequestComplete);
		mUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
		mUrlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
	}
	
	private function onHttpStatus(e:HTTPStatusEvent):Void 
	{
		var status = e.status;
		if (status >= 200 && status <= 205)
			mRequestSuccess = true;
		else
			mRequestSuccess = false;
		trace(e.status);
	}
	
	private function onRequestError(e:IOErrorEvent):Void 
	{
		switch(mRequestType) {
			case "get" :
				mGetCallBack(null, new ParseException("Error while getting object."));
		}
	}
	
	private function onRequestComplete(e:Event):Void 
	{
		var answerData = mUrlLoader.data;
		
		if (mRequestSuccess) {
			try {
				var data = Json.parse(answerData);
				trace(data);
			}catch (e : Dynamic) {
				trace(e);
			}
		}else {
			
		}
		trace("complete");
	}
	
	public function get(id : String, getCallBack : T -> ParseException -> Void) {
		mGetCallBack = getCallBack;
		
		mRequest.url = mBaseUrl + "/" + id;
		
		mRequest.method = URLRequestMethod.GET;
		
		mRequestType = "get";
		mUrlLoader.load(mRequest);
	}
	
}