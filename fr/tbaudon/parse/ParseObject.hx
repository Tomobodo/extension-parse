package fr.tbaudon.parse;
import cpp.vm.Thread;
import haxe.Http;
import haxe.io.BytesOutput;
import haxe.io.Output;
import haxe.Json;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;

/**
 * ...
 * @author TBaudon
 */
class ParseObject
{
	
	var mClassName : String;
	var mUrl : String;
	
	var mHttp : Http;
	
	var mData : Map<String, Dynamic>;
	var mUpdatedFields : Array<String>;
	var mId : String;
	
	var mSaveCallback : Void -> Void;
	
	public function new(className : String) 
	{
		mClassName = className;
		
		mUrl = Parse.getApiUrl() + "/classes/" + mClassName;
		
		mData = new Map<String, Dynamic>();
		mUpdatedFields = new Array<String>();		
		
		mHttp = new Http(mUrl);
		mHttp.setHeader("X-Parse-Application-Id", Parse.applicationId);
		mHttp.setHeader("X-Parse-REST-API-Key", Parse.RESTApiKey);
		mHttp.setHeader("Content-Type", "application/json");
	}
	
	public function put(key : String, value : Dynamic) {
		mData.set(key, value);
		mUpdatedFields.push(key);
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
	
	public function save() {
		mHttp.url = mUrl;
		mHttp.setPostData(getJson());
		
		if (mId != null) {
			var output = new BytesOutput();
			mHttp.url = mUrl + "/" + mId;
			try {
				mHttp.customRequest(true, output, "PUT");
			}catch (e : Dynamic) {
				trace(e);
			}
		}
		else
			mHttp.request(true);
		
		var answerData : String = mHttp.responseData;
		if (mHttp.responseHeaders.get("Status") != null) 
			throw new ParseException("Error : " + mHttp.responseHeaders.get("Status"));
		else {
			var parsedAnswer = Json.parse(answerData);
			
			if (Reflect.hasField(parsedAnswer, "error"))
				throw new ParseException(Reflect.field(parsedAnswer, "error"));
			else {
				mId = Reflect.field(parsedAnswer, "objectId");
				emptyUpdate();
			}
		}
	}
	
	function saveThread() {
		save();
		if (mSaveCallback != null)
			mSaveCallback ();
	}
	
	public function saveInBackground(saveCallback : Void -> Void = null) {
		mSaveCallback = saveCallback;
		Thread.create(saveThread);
	}
	
	public function getObjectId() : String {
		return mId;
	}
	
	public function setObjectId(obejctId : String) {
		mId = obejctId;
	}
	
}