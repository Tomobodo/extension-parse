package fr.tbaudon.parse;

import openfl.utils.JNI;

#if cpp
import cpp.Lib;
#end

/**
 * ...
 * @author Thomas B
 */
class ParsePush
{

	public function new() 
	{
		
	}
	
	public static function subscribe(channel : String) {
		#if android
		jni_subscribe(channel);
		#elseif ios
		objC_subscribe(channel);
		#end
	}
	
	#if android
	static var jni_subscribe : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "subscribe", "(Ljava/lang/String;)V");
	#elseif ios
	static var objC_subscribe : Dynamic = Lib.load("parse", "subscribe", 1);
	#end
	
}