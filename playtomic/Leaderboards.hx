package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class Leaderboards
{
	public function new() { }
	public static inline var TODAY:String = "today";
	public static inline var LAST7DAYS:String = "last7days";
	public static inline var LAST30DAYS:String = "last30days";
	public static inline var ALLTIME:String = "alltime";
	public static inline var NEWEST:String = "newest";
	
	private static inline var SECTION:String = "leaderboards";
	private static inline var SAVEANDLIST:String = "saveandlist";
	private static inline var SAVE:String = "save";
	private static inline var LIST:String = "list"
	
	/**
	 * Performs a save and a list in a single request that returns the player's score and page of scores it occured on
	 * @param	score		The player's score and table properties
	 * @param	callback	Callback function to receive the data:  function(scores:Array, numscores:int, response:Response)
	 */
	public static function saveAndList(score:Dynamic, callback:Array<Dynamic>->Int->Response->Void) {
		ServiceRequest.load(SECTION, SAVEANDLIST, score, function(data:Dynamic, response:Response) {
			if(callback == null)
				return;
				
			callback(data.scores, data.numscores, response);
		});
	}
	
	/**
	 * Saves a user's score
	 * @param	score		The player's score as a Score (extends Object)
	 * @param	callback	Callback function to receive the data:  function(score:PlayerScore, response:Response)
	 */
	public static function save(score:Object, callback:Response->Void = null) {
		ServiceRequest.load(SECTION, SAVE, score, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
				
			callback(response);
		});
	}
	
	/**
	 * Lists scores from a table
	 * @param	options		The leaderboard options, check the documentation at http://playtomic.com/api/as3#Leaderboards
	 * @param	callback	Callback function to receive the data:  function(scores:Array, numscores:int, response:Response)
	 */
	public static function list(options:Object, callback:Array<Dynamic>->Int->Response->Void) {
		ServiceRequest.load(SECTION, LIST, options, function(data:Dynamic, response:Response) { 
			if(callback == null)
				return;
				
			callback(data.scores, data.numscores, response);
		});
	}
}