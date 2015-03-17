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
		//ios_subscribe();
		#end
	}
	
	#if android
	static var jni_subscribe : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "subscribe", "(Ljava/lang/String;)V");
	#elseif ios
	//static var ios_subscribe : Dynamic = Lib.load("parse", "parse_test", 0);
	#end
	
}