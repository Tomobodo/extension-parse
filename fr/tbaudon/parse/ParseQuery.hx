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
class ParseQuery {
	
	var mClassName : String;
	
	var mObjectClass : Class<ParseObject>;
	
	var mRequest : URLRequest;
	var mBaseUrl : String;
	
	var mUrlLoader : URLLoader;
	
	var mRequestType : String;
	
	var mGetCallBack : ParseObject -> ParseException -> Void;
	
	var mRequestSuccess : Bool;

	public function new(objectClass : Class<ParseObject>, className : String) {
		mClassName = className;
		mObjectClass = objectClass;
		
		mRequest = Parse.prepareRESTRequest(ParseObject.getTypeName(), mClassName);
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
		
		var data : Dynamic = null;
		
		if (mRequestSuccess) {
			try {
				data = Json.parse(answerData);
			}catch (e : Dynamic) {
				trace(e);
			}
		} 
		
		trace("complete");
		
		switch(mRequestType) {
			case "get" :
				if (data != null)
					mGetCallBack(ParseObject.fromJSON(mClassName, data), null);
				else
					mGetCallBack(null, new ParseException("No data found"));
		}
		
	}
	
	public function get(id : String, getCallBack : ParseObject -> ParseException -> Void) {
		mGetCallBack = getCallBack;
		
		mRequest.url = mBaseUrl + "/" + id;
		
		mRequest.method = URLRequestMethod.GET;
		
		mRequestType = "get";
		mUrlLoader.load(mRequest);
	}
	
}