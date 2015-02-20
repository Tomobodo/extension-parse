package fr.tbaudon.parse ;
import openfl.utils.JNI;

/**
 * ...
 * @author Thomas B
 */
class ParseQuery<T>
{
	
	public static function getObjectQuery(className : String) : ParseQuery<ParseObject> {
		return new ParseQuery<ParseObject>(native_getObjectQuery(className), "ParseObject" );
	}
	
	var mQuery : Dynamic;
	var mWrapper : Dynamic;
	var mTypeParam : String;
	
	var mParseAnswerList : List<T>;
	var mParseAnswerException : ParseException;
	
	var mFindCallback : List<T> -> ParseException -> Void ;

	function new(query : Dynamic, typeParam : String) 
	{
		mTypeParam = typeParam;
		
		mQuery = query;
		mWrapper = getWrapper(mQuery, mTypeParam, this);
	}
	
	public function whereEqualTo(key : String, value : Dynamic) : ParseQuery<T> {
		mQuery = JNI.callMember(native_whereEqualTo, mQuery, [key, value]);
		return this;
	}
	
	public function findInBackground(findCallBack : List<T> -> ParseException -> Void ) {
		mFindCallback = findCallBack;
		mParseAnswerList = new List<T>();
		var javaCB = JNI.callMember(getFindCallback, mWrapper, []);
		JNI.callMember(native_findInBackground, mQuery, [javaCB]);
	}
	
	public function callFindCallback() {
		mFindCallback(mParseAnswerList, mParseAnswerException);
	}
	
	public function addParseObject(name : String, javaInstance : Dynamic) {
		mParseAnswerList.add(cast new ParseObject(name, javaInstance));
	}
	
	public function initParseException(e : Dynamic) {
		if (e == null) mParseAnswerException = null;
		else mParseAnswerException = new ParseException(e);
	}
	
	#if android
	
	private static var native_getObjectQuery : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.QueryWrapper", "getObjectQuery", "(Ljava/lang/String;)Lcom/parse/ParseQuery;");
	private static var getWrapper : Dynamic = JNI.createStaticMethod("fr.tbaudon.parse.QueryWrapper", "getWrapper", "(Lcom/parse/ParseQuery;Ljava/lang/String;Lorg/haxe/lime/HaxeObject;)Lfr/tbaudon/parse/QueryWrapper;");
	
	private static var getFindCallback : Dynamic = JNI.createMemberMethod("fr.tbaudon.parse.QueryWrapper", "getFindCallback", "()Lcom/parse/FindCallback;");

	private static var native_whereEqualTo : Dynamic = JNI.createMemberMethod("com.parse.ParseQuery", "whereEqualTo", "(Ljava/lang/String;Ljava/lang/Object;)Lcom/parse/ParseQuery;");
	private static var native_findInBackground : Dynamic = JNI.createMemberMethod("com.parse.ParseQuery", "findInBackground", "(Lcom/parse/FindCallback;)V");
	
	#end
	
}