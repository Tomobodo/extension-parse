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

	public function new(name : String) 
	{
		mName = name;
		mNativeInstance = native_createParseObject(mName);
	}
	
	public function put(key : String, value : Dynamic) 
	{
		#if android
			
			JNI.callMember(parseObject_put, mNativeInstance, [key, Parse.toJavaObject(value)]);
		
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
	private static var parseObject_saveInBackground = JNI.createMemberMethod("com.parse.ParseObject", "saveInBackground", "()Lbolts/Task;");
	
	#end
}