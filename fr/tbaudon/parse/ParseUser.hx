package fr.tbaudon.parse;

/**
 * ...
 * @author Thomas B
 */
class ParseUser extends ParseObject
{
	
	public var username(get, set) : String;
	public var password(get, set) : String;
	public var email(get, set) : String;

	public function new() 
	{
		super();
	}
	
	function set_username(name : String) : String {
		put("username", name);
		return name;
	}
	
	function get_username() : String {
		return get("username");
	}
	
	function set_password(password : String) : String {
		put("password", password);
		return password;
	}
	
	function get_password() : String {
		return get("password");
	}
	
	function set_email(mail : String) : String{
		put("email", mail);
		return mail;
	}
	
	function get_email() : String {
		return get("email");
	}
	
	public function signUp(successCB : Void -> Void, failCB : Void -> Void) {
		save(successCB, failCB);
	}
	
	static public function getTypeName() : String {
		return "users";
	}
	
}