# Parse 

Provide acces to Parse from OpenFL.

## Usage

### Install

Clone this repo, then open a terminal and move to the root of the clone.
Then, use :
```
haxelib dev parse .
```

### Project.xml

Add the lib :
```
<haxelib name="parse" />
```

Add your Parse keys :
```
<setenv name="Parse_clientKey"	value="YOUR_CLIENT_KEY" />
<setenv name="Parse_AppId"	value="YOUR_APP_ID" />
<setenv name="Parse_RESTApiKey" value="YOUR_REST_API_KEY" />
```
If you don't add them, your app will not compile and tell you wich key is missing.

### Sample

```
package;


import extension.parse.Parse;
import extension.parse.ParsePush;
import extension.parse.ParseInstallation;

import openfl.display.Sprite;

class Main extends Sprite {
	
	public function new () {
		
		super ();
		
		Parse.initialize(); // Always use this before any use of Parse
		
		ParsePush.init(initSuccess, initFail); // Register your phone to push notification with Parse
	}
	
	function initSuccess() {
		var currentInstall = ParseInstallation.currentInstallation;
		
		currentInstall.put("lastUsed", Date.now());
		currentInstall.save();
	}
	
	function initFail(){
		trace("Could not init parsePush");
	}
}
```
