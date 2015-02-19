package fr.tbaudon.parse;

import java.util.List;

import org.haxe.lime.HaxeObject;

import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseQuery;

public class QueryWrapper {

	public static void findInBackground(ParseQuery<?> query, HaxeObject object){
		query.findInBackground(new FindCallback<?>() {

			@Override
			public void done(List arg0, ParseException arg1) {
				// TODO Auto-generated method stub
				
			}

			
		});
	}
	
}
