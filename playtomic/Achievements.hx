package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class Achievements
{
	private function new() { }

	private static inline SECTION:String = "achievements";
	private static inline LIST:String = "list";
	private static inline STREAM:String = "stream";
	private static inline SAVE:String = "save";
	
	/**
	 * Lists all achievements
	 * @param	options		The list options
	 * @param	callback	Your function to receive the response: function(achievements, response)
	 */
	public static function list(options:Dynamic, callback:Array<Dynamic>->Response->Void) {
		ServiceRequest.load(SECTION, LIST, options, function(data:Dynamic, response:Response) { 
			
			if(callback == null) {
				return;
			}
			
			if(!response.success) {
				callback([], response);
				return;
			}
			
			callback(data.achievements, response);
		});
	}
	
	/**
	 * Shows a chronological stream of achievements 
	 * @param	options		The stream options
	 * @param	callback	Your function to receive the response: function(achievements, response)
	 */ 
	public static function stream(options:Dynamic, callback:Function) {
		ServiceRequest.load(SECTION, STREAM, options, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
			
			if(!response.success) {
				callback([], response);
				return;
			}
			
			callback(data.achievements, data.numachievements, response);
		});
	}
	
	/**
	 * Award an achievement to a player
	 * @param	achievement	The achievement
	 * @param	callback	Your function to receive the response: function(response)
	 */
	public static function save(achievement:Dynamic, callback:Response->Void) {
		ServiceRequest.load(SECTION, SAVE, achievement, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
		
			callback(response);
		});
	}
}