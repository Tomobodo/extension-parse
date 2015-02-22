package fr.tbaudon.parse;

import haxe.Json;
import openfl.events.ErrorEvent;
import openfl.events.Event;
import openfl.events.HTTPStatusEvent;
import openfl.events.IOErrorEvent;

import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;
import openfl.net.URLRequestHeader;
import openfl.net.URLLoader;

/**
 * ...
 * @author TBaudon
 */
class ParseObject
{
	
	var mClassName : String;
	var mUrl : String;
	
	var mRequest : URLRequest;
	var mUrlLoader : URLLoader;
	
	var mData : Map<String, Dynamic>;
	var mUpdatedFields : Array<String>;
	var mId : String;
	
	var mRequestSuccess : Bool = false;
	
	var mOnSuccesCallback : Void->Void;
	var mOnFailCallback : Void->Void;
	
	public function new(className : String) 
	{
		mClassName = className;
		
		mUrl = Parse.getApiUrl() + "/classes/" + mClassName;
		
		mData = new Map<String, Dynamic>();
		mUpdatedFields = new Array<String>();		
		
		mRequest = new URLRequest(mUrl);
		var appId = new URLRequestHeader("X-Parse-Application-Id", Parse.applicationId);
		var appApiKey = new URLRequestHeader("X-Parse-REST-API-Key", Parse.RESTApiKey);
		mRequest.requestHeaders = [appId, appApiKey];
		mRequest.contentType = "application/json";
		
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
		trace(e.status);
	}
	
	function onRequestError(e:ErrorEvent):Void 
	{
		trace("error");
		if (mOnFailCallback != null)
			mOnFailCallback();
	}
	
	function onRequestComplete(e:Event):Void 
	{
		var answerData = mUrlLoader.data;
		if (mRequestSuccess) {
			
			try {
				var data = Json.parse(answerData);
				if(Reflect.hasField(data, "objectId"))
					mId = Reflect.field(data, "objectId");
			}catch (e : Dynamic) {
				trace(e);
			}
			
			if (mOnSuccesCallback != null)
				mOnSuccesCallback();
		}
		trace("complete");
	}
	
	public function put(key : String, value : Dynamic) {
		mData.set(key, value);
		mUpdatedFields.push(key);
	}
	
	public function get(key : String) : Dynamic {
		return mData.get(key);
	}
	
	function getJson() : String {
		var json = { };
		
		for(field in mUpdatedFields) 
			Reflect.setField(json, field, mData.get(field));
		
		return Json.stringify(json);
	}
	
	function emptyUpdate() {
		while (mUpdatedFields.length > 0)
			mUpdatedFields.pop();
	}
	
	public function save(onSuccessCallback : Void -> Void = null, onFailCallback : Void -> Void = null) {
		mRequest.data = getJson();
		
		if(mId == null){
			mRequest.url = mUrl;
			mRequest.method = URLRequestMethod.POST;
		} else {
			mRequest.url = mUrl + "/" + mId;
			mRequest.method = URLRequestMethod.PUT;
		}
		
		mUrlLoader.load(mRequest);
		
		mRequestSuccess = false;
		mOnSuccesCallback = onSuccessCallback;
		mOnFailCallback = onFailCallback;
	}
	
	public function getObjectId() : String {
		return mId;
	}
	
	public function setObjectId(obejctId : String) {
		mId = obejctId;
	}
	
}