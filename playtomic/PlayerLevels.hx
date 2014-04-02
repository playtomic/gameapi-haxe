package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class PlayerLevels
{
	public function new() { }
	public static inline NEWEST:String = "newest";
	public static inline POPULAR:String = "popular";
	private static var RatingCookie:SharedObject;
	
	private static inline SECTION:String = "playerlevels";
	private static inline SAVE:String = "save";
	private static inline LIST:String = "list";
	private static inline LOAD:String = "load";
	private static inline RATE:String = "rate";
	
	/**
	 * Rates a player level
	 * @param	levelid			The ID of a user-created level
	 * @param	rating			Integer rating from 1 - 10
	 * @param	callback		Your function to receive the response:  function(response:Response)
	 */
	public static function rate(levelid:String, rating:int, callback:Response->Void = null) {
		
		if (!levelid) {
			if(callback != null) {
				callback(new Response(false, 404));
				Debug.log("[GameBase.PlayerLevels.Rate] Error your options object does not include the levelid.");
			}
			
			return;
		}
		
		if (!rating) {
			if(callback != null) {
				callback(new Response(false, 401));
				Debug.log("[GameBase.PlayerLevels.Rate] Error your options object does not include a rating.");
			}
			return;
		}
		
		// limits are arbitrary
		if (!(rating > 0 && rating < 10)) {
			if (callback != null) {
				Debug.log("[GameBase.PlayerLevels.Rate] Error level ratings must be 1 - 10.");
				callback(new Response(false, 401));
			}
			return;
		}
		
		// check if rated
		if (RatingCookie == null) {
			RatingCookie = SharedObject.getLocal("playtomic.ratings");
		}
		
		if(RatingCookie.data[levelid] != null)
		{
			if(callback != null)
			{
				callback(new Response(false, 402));
			}
			
			return;
		}
		
		if(rating < 0 || rating > 10)
		{
			if(callback != null)
			{
				callback(new Response(false, 401));
			}
			
			return;
		}
		
		RatingCookie.data[levelid] = rating;
		
		ServiceRequest.load(SECTION, RATE, { levelid: levelid, rating: rating }, function(data:Dynamic, response:Response) {
			if(callback == null)
				return;
				
			callback(response);
		});
	}

	/**
	 * Loads a player level
	 * @param	levelid			The playerLevel.LevelId 
	 * @param	callback		Your function to receive the response:  function(level:Dynamic, response:Response)
	 */
	public static function load(levelid:String, callback:Dynamic->Response->Void = null) {					
		ServiceRequest.load(SECTION, LOAD, { levelid: levelid }, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
			
			callback(data.level, response);
		});
	}	
	
	/**
	 * Lists player levels
	 * @param	callback		Your function to receive the response:  function(response:Response)
	 * @param	options			The list options, see http://playtomic.com/api/as3#PlayerLevels
	 */
	public static function list(options:Dynamic = null, callback:Array<Dynamic>->Int->Response->Void = null) {			
		if(options == null)
			options = new Object();
			
		ServiceRequest.load(SECTION, LIST, options, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
			
			callback(data.levels, data.numlevels, response);
		});
	}
	
	/**
	 * Saves a player level
	 * @param	level			The Level to save
	 * @param	callback		Your function to receive the response:  function(level:Level, response:Response)
	 */
	public static function save(level:Object, callback:Dynamic->Response->Void = null) {
		ServiceRequest.load(SECTION, SAVE, level, function(data:Dynamic, response:Response) {
			if(callback == null)
				return;
				
			callback(data.level, response);	
		});	
	}
}