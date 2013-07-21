package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class GameVars
{
	private function new() { }
	private static inline var SECTION:String = "gamevars";
	private static inline var LOAD:String = "load";
	private static inline var SINGLE:String = "single";
	
	/**
	 * Loads your GameVars 
	 * @param	callback	Your function to receive the data:  callback(gamevars:Object, response:Response)
	 */
	public static function load(callback:Dynamic->Response->Void) {
		ServiceRequest.load(SECTION, LOAD, null, function(data:Dynamic, response:Response) {
			if(callback == null)
				return;
				
			callback(data, response);
		});
	}
	
	/**
	 * Loads a single GameVar
	 * @param	name	The name of the var you want to laod
	 * @param	callback	Your function recieve the data:  callback(gamevar:Object, response:Response)
	 */
	public static function loadSingle(name:String, callback:Dynamic->Response->Void) {
		var postdata:Object = {
			name: name
		}
		
		ServiceRequest.load(SECTION, SINGLE, postdata, function() {
			if(callback == null)
				return;
				
			callback(data, response);
		});
	}
}