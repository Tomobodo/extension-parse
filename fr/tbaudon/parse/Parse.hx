package fr.tbaudon.parse ;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end

import haxe.Json;

class Parse {
	
	public static function initialize(applicationId : String, clientKey : String) {
		native_initialize(applicationId, clientKey);
	}
	
	public static function toJavaObject(object : Dynamic) : Dynamic {
		if (Std.is(object, String))
		{
			var input : String = object;
			return input;
		}
		else if (Std.is(object, Int))
		{
			var input : Int = object;
			return fromIntTojavaNumber(input);
		}
		else if (Std.is(object, Float))
		{
			var input : Float = object;
			return fromFloatTojavaNumber(input);
		}
		else{
			var input : String = Json.stringify(object);
			return input;
		}
	}
	
	#if android
	
	private static var native_initialize : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "initialize", "(Ljava/lang/String;Ljava/lang/String;)V");
	
	private static var toJavaString : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "toJavaString", "(Ljava/lang/String;)Ljava/lang/String;");
	private static var fromIntTojavaNumber : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "fromIntTojavaNumber", "(I)Ljava/lang/Number;");
	private static var fromFloatTojavaNumber : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "fromFloatTojavaNumber", "(F)Ljava/lang/Number;");
	
	#end
	
	
}