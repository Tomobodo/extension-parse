package fr.tbaudon.parse;

import openfl.utils.JNI;

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
		#end
	}
	
	#if android
	static var jni_subscribe : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "subscribe", "(Ljava/lang/String;)V");
	#end
	
}