package extension.parse;

/**
 * ...
 * @author Thomas B
 */
class ParseInstallation extends ParseObject
{

	public function new() 
	{
		super();
	}
	
	public static function getTypeName() : String {
		return "installations";
	}
	
}