package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class Debug
{
	public static var Enabled:Bool = false;
	
	public static function log(message:String) 
	{
		if (Enabled)
		{
			trace(message);
		}
	}
}