package fr.tbaudon.parse ;
import openfl.utils.JNI;

/**
 * ...
 * @author Thomas B
 */
class ParseQuery<T>
{
	
	public static function getObjectQuery(className : String) : ParseQuery<ParseObject> {
		return new ParseQuery<ParseObject>(native_getObjectQuery(className));
	}
	
	var mQuery : Dynamic;

	function new(query : Dynamic) 
	{
		mQuery = query;
	}
	
	public function whereEqualTo(key : String, value : Dynamic) : ParseQuery<T> {
		mQuery = native_whereEqualTo(key, Parse.toJavaObject(value));
		return mQuery;
	}
	
	public function findInBackground(findCallBack : List<T> -> ParseException -> Void ) {
		
	}
	
	#if android
	
	private static var native_getObjectQuery : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.ParseWrapper", "getObjectQuery", "(Ljava/lang/String;)Lcom/parse/ParseQuery;");
	
	private static var native_whereEqualTo : Dynamic = JNI.createMemberMethod("com.parse.ParseQuery", "whereEqualTo", "(Ljava/lang/String;Ljava/lang/Object;)Lcom/parse/ParseQuery;");
	
	#end
	
}