package fr.tbaudon.parse ;

import openfl.utils.JNI;

/**
 * ...
 * @author Thomas B
 */
class ParseObject
{
	
	var mName : String;
	var mNativeInstance : Dynamic;

	public function new(name : String, instance : Dynamic = null) 
	{
		mName = name;
		if(instance == null)
			mNativeInstance = native_createParseObject(mName);
		else
			mNativeInstance = instance;
	}
	
	public function put(key : String, value : Dynamic) 
	{
		#if android
			
			JNI.callMember(parseObject_put, mNativeInstance, [key, Parse.toJavaObject(value)]);
		
		#end
	}
	
	public function get(key : String) : Dynamic {
		
		#if android
		
			return JNI.callMember(parseObject_get, mNativeInstance, [key]);
			
		#end		
	}
	
	public function getInt(key : String) : Int {
		
		#if android 
		
			return JNI.callMember(parseObject_getInt, mNativeInstance, [key]);
		
		#end
		
	}
	
	public function getFloat(key : String) : Float {
		
		#if android
		
		return JNI.callMember(parseObject_getFloat, mNativeInstance, [key]);
		
		#end
		
	}
	
	public function getString(key : String) : String {
		
		#if android 
		
		return JNI.callMember(parseObject_getString, mNativeInstance, [key]);
		
		#end
		
	}
	
	public function saveInBackground() 
	{
		#if android
			JNI.callMember(parseObject_saveInBackground, mNativeInstance, []);
		#end
	}
	
	#if android
	
	private static var native_createParseObject : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "createParseObject", "(Ljava/lang/String;)Lcom/parse/ParseObject;");
	
	private static var parseObject_put : Dynamic = JNI.createMemberMethod("com.parse.ParseObject", "put", "(Ljava/lang/String;Ljava/lang/Object;)V");
	
	private static var parseObject_get : Dynamic = JNI.createMemberMethod("com.parse.ParseObject", "get", "(Ljava/lang/String;)Ljava/lang/Object;");
	private static var parseObject_getInt : Dynamic = JNI.createMemberMethod("com.parse.ParseObject", "getInt", "(Ljava/lang/String;)I");
	private static var parseObject_getFloat : Dynamic = JNI.createMemberMethod("com.parse.ParseObject", "getDouble", "(Ljava/lang/String;)D");
	private static var parseObject_getString : Dynamic = JNI.createMemberMethod("com.parse.ParseObject", "getString", "(Ljava/lang/String;)Ljava/lang/String;");
	
	private static var parseObject_saveInBackground = JNI.createMemberMethod("com.parse.ParseObject", "saveInBackground", "()Lbolts/Task;");
	
	#end
}