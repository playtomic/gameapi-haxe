package playtomic;

/**
 * ...
 * @author Ben Lowry
 */
class Playtomic
{
	/**
	 * Initializes the API
	 * @param	publickey	Your game's public key
	 * @param	privatekey	Your game's private key
	 * @param	apiurl		The URL to your server
	 */
	public static function initialize(publickey:String, privatekey:String, apiurl:String) {
		ServiceRequest.initialize(publickey, privatekey, apiurl);
		Response.initialize();
	}
}