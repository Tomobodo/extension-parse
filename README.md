# Parse 

Provide acces to Parse from OpenFL.

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
		
		Parse.initialize("yourAppId", "yourClientKey", "yourRestAPIKey");
		
		ParsePush.subscribe("channelA"); // parameter is useless at the moment, just subscribe your app for general push notification.
		
		var testObj = new ParseObject("User");
		testObj.put("name", "Martin");
		testObj.put("age", 10);
		testObj.put("sexe", "M");
		testObj.save();
		
	}
}
```
