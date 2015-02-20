# OpenFL Parse 
Only available on Android at the moment.

## Usage

```
package;


import fr.tbaudon.parse.Parse;
import fr.tbaudon.parse.ParseException;
import fr.tbaudon.parse.ParseObject;
import fr.tbaudon.parse.ParseQuery;

import openfl.display.Sprite;

class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		Parse.initialize("yourAppId", "yourClientKey");
		
		var testObj = new ParseObject("User");
		testObj.put("name", "Martin");
		testObj.put("age", 10);
		testObj.put("sexe", "M");
		testObj.saveInBackground();
		
		var query : ParseQuery<ParseObject> = ParseQuery.getObjectQuery("User").whereEqualTo("name", "Martin");
		query.findInBackground(cb);
	}
	
	public function cb(rep : List<ParseObject>, e : ParseException) {
		if (e != null)
			trace("A problem occured while loading data.");
		else {
			var a : ParseObject = rep.first();
			trace(a.getInt("age"));
		}
	}
}
```