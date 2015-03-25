package extension.parse;

import haxe.macro.Compiler;
import haxe.macro.Context;

/**
 * ...
 * @author Thomas B
 */
class ParseMacro
{

	macro public static function getRESTKey():Dynamic {
        return Context.makeExpr(Compiler.getDefine("Parse_AppId"), Context.currentPos());
    }
	
	macro public static function getClientKey():Dynamic {
        return Context.makeExpr(Compiler.getDefine("Parse_clientKey"), Context.currentPos());
    }
	
	macro public static function getAppId():Dynamic {
		return Context.makeExpr(Compiler.getDefine("Parse_AppId"), Context.currentPos());
    }
	
}