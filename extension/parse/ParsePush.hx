package extension.parse;

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

	/**
	* Register for notification on iOs and Android
	**/
	public static function init() {
		#if android
		jni_subscribe("global");
		#elseif ios
		objC_subscribe("global");
		#end
	}

	/**
	* Subscribe current device to a specified channel
	* @param channel channel to subscribe to
	**/
	public static function subscribe(channel : String) {

	}
	
	#if android
	static var jni_subscribe : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "subscribe", "(Ljava/lang/String;)V");
	#elseif ios
	static var objC_subscribe : Dynamic = Lib.load("parse", "subscribe", 1);
	#end
	
}