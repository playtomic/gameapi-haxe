package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class GeoIP
{
	public function new() { }
	private static inline var SECTION:String = "geoip";
	private static inline var LOAD:String = "lookup";
	
	/**
	 * Performs a country lookup on the player IP address
	 * @param	callback	Your function to receive the data:  callback(data:Object, response:Response);
	 * @param	view	If it's a view or not
	 */
	public static function lookup(callback:Dynamic->Response->Void) {
		ServiceRequest.load(SECTION, LOAD, function(data:Dynamic, response:Response) {	
			if(callback == null)
				return;
			
			callback(data, response);
		});
	}
}