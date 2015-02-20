package fr.tbaudon.parse;

import java.util.List;

import org.haxe.lime.HaxeObject;

import android.util.Log;

import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;


public class QueryWrapper{
	
	public static ParseQuery<ParseObject> getObjectQuery(String className){
		return ParseQuery.getQuery(className);
	}
	
	public static QueryWrapper getWrapper(ParseQuery<?> query, String typeParam, HaxeObject haxeObject){
		QueryWrapper wrapper = new QueryWrapper(query);
		wrapper.sethaxeObject(haxeObject);
		wrapper.initFindCallback(typeParam);
		return wrapper;
	}
	
	private ParseQuery<?> mQuery;
	private FindCallback<?> mFindCallback;
	private HaxeObject mHaxeObject;
	
	public QueryWrapper(ParseQuery<?> query){
		mQuery = query;
	}
	
	public void sethaxeObject(HaxeObject object){
		mHaxeObject = object;
	}
	
	public void initFindCallback(String typeParam){
		if(typeParam.equals("ParseObject")){
			mFindCallback = new FindCallback<ParseObject>() {
				public void done(List<ParseObject> rep, ParseException e) {
					
					if(rep != null)
						for(ParseObject temp : rep)
							mHaxeObject.call2("addParseObject", temp.getClassName(), temp);
						
					mHaxeObject.call1("initParseException", e);
					mHaxeObject.call0("callFindCallback");
				}
			};
		}
	}
	
	public FindCallback<?> getFindCallback(){
		return mFindCallback;
	}
	
}
