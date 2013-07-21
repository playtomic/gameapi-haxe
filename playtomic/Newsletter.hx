package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class Newsletter
{
	public function new() { }
	private static inline var SECTION:String = "newsletter";
	private static inline var SUBSCRIBE:String = "subscribe";
	
	/**
	 * Subscribes a user to your newsletter
	 * @param options	The options:  { email: , fields: { } }
	 * @param callback	Your callback function(response:Response)
	 */
	public static function subscribe(options:Dynamic, callback:Response->Void) {
		ServiceRequest.load(SECTION, SUBSCRIBE, options, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
			
			callback(response);
		});	
	}
}