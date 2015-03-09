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
class ParseObject {
	
	var mClassName : String;
	var mUrl : String;
	
	var mRequest : URLRequest;
	var mUrlLoader : URLLoader;
	
	var mData : Map<String, Dynamic>;
	var mUpdatedFields : Array<String>;
	var mId : String;
	
	var mRequestSuccess : Bool = false;
	
	var mSaveSuccesCallback : Void->Void;
	var mSaveFailCallback : Void->Void;
	
	var mOnFetchCallback : Void -> Void;
	var mOnFetchFailCallback : Void -> Void;
	
	public function new(className : String = null) 
	{
		mClassName = className;
		
		mData = new Map<String, Dynamic>();
		mUpdatedFields = new Array<String>();		
		
		mRequest = Parse.prepareRESTRequest(getTypeName(), mClassName);
		mUrl = mRequest.url;
		
		mUrlLoader = new URLLoader();
		
		mUrlLoader.addEventListener(Event.COMPLETE, onRequestComplete);
		mUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
		mUrlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
	}
	
	function onHttpStatus(e:HTTPStatusEvent):Void 
	{
		var status = e.status;
		if (status >= 200 && status <= 205)
			mRequestSuccess = true;
		else
			mRequestSuccess = false;
		trace(e.status);
	}
	
	function onRequestError(e:ErrorEvent):Void 
	{
		trace("error");
		if (mSaveFailCallback != null)
			mSaveFailCallback();
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
			
			if (mSaveSuccesCallback != null)
				mSaveSuccesCallback();
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
		mSaveSuccesCallback = onSuccessCallback;
		mSaveFailCallback = onFailCallback;
	}
	
	public function fetch(onFetchSucess : Void -> Void, onFetchFail : Void -> Void) {
		mOnFetchCallback = onFetchSucess;
		mOnFetchFailCallback = onFetchFail;
		
		var query = new ParseQuery(Type.getClass(this), mClassName);
		query.get(mId, onFetchComplete); 
	}
	
	function onFetchComplete(object : ParseObject, exception : ParseException) {
		if (object == null && mOnFetchFailCallback != null)
			mOnFetchFailCallback();
		else {
			for (key in object.mData.keys())
				mData[key] = object.mData[key];
				
			if (mOnFetchCallback != null)
				mOnFetchCallback();
		}
	}
	
	function copy(obj : ParseObject) {
		
	}
	
	public function getObjectId() : String {
		return mId;
	}
	
	public function setObjectId(obejctId : String) {
		mId = obejctId;
	}
	
	static public function getTypeName() : String {
		return "classes";
	}
	
	static public function fromJSON(className : String, json : Dynamic) : ParseObject {
		var rep = new ParseObject(className);
		
		for (field in Reflect.fields(json)) 
			if (field == "objectId")
				rep.setObjectId(Reflect.field(json, field));
			else if (field == "createdAt" || field == "updatedAt")
				continue;
			else
				rep.put(field, Reflect.field(json, field));
		
		return rep;
	}
	
}