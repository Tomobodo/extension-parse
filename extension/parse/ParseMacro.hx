package extension.parse;
import haxe.io.Path;
import haxe.xml.Fast;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;

import sys.FileSystem;
import sys.io.File;

#end

/**
 * ...
 * @author Thomas B
 */
class ParseMacro
{
	
	macro public static function getProjectEnv(name : String) : Dynamic {
		var projectFile : String = "";

		#if ios
			var directoryToRead = "../../../../";
		#else
			var directoryToRead = "./";
		#end

		#if nme
			var fileExtension = "nmml";
		#else
			var fileExtension = "xml";
		#end

		for (file in FileSystem.readDirectory(directoryToRead))
			if (Path.extension(file) == fileExtension){
				var xmlData : Xml = Xml.parse(File.getContent(directoryToRead + file));
				for (elements in xmlData.elements())
					if (elements.nodeName == "project") {
						projectFile = file;
						for (projectNode in elements.elements()) 
							if (projectNode.nodeName == "setenv")
								if (projectNode.get("name") == name){
									var value = projectNode.get("value");
									return Context.makeExpr(value, Context.currentPos());
								}
					}
			}
		
		throw "No " + name + " env var found in " + projectFile + ".";
		
	}
	
}