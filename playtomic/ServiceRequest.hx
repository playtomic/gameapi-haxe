package playtomic;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.system.Security;	
import haxe.io.Error;
import haxe.Json;
/**
 * ...
 * @author Ben Lowry
 */
class ServiceRequest
{
	public function new() { }
	private static var URL:String;
	private static var PrivateKey:String;
	private static var PublicKey:String;
	private static var FailResponse:Response;
		
	public static function initialize(publickey:String, privatekey:String, apiurl:String)
	{
		if(apiurl.lastIndexOf("/") != apiurl.length - 1) {
			apiurl += "/";
		}
		
		URL = apiurl + "v1?publickey=" + publickey;
		PrivateKey = privatekey;
		FailResponse = new Response(false, 1);
		
		#if flash
		Security.loadPolicyFile(apiurl + "crossdomain.xml");
		#end
	}
	
	public static function load(section:String, action:String, data:Dynamic, handler:Dynamic->Response->Void)
	{
		var postdata:Dynamic = data == null ? {} : data;
		postdata.section = section;
		postdata.action = action;
		postdata.publickey = PublicKey;
		
		var pds:String = Json.stringify(postdata);
		var ignore = function(e:Event) { };
		var request:URLLoader = new URLLoader();
		
		var postvars:URLVariables = new URLVariables();
		postvars.data = Base64.encode(pds);
		postvars.hash = Md5.encode(pds + PrivateKey);
		
		var complete = function(e:Event)  {
			Debug.log("[Playtomic.ServiceRequest.Complete] Service request completed (" + section + " -> " + action + ")");
			
			try
			{
				var data:Dynamic = Json.parse(request.data);
				handler(data, new Response(data.success, data.errorcode));
			}
			catch ( e:Dynamic )
			{
				Debug.log("[Playtomic.ServiceRequest.Error] JSON failed");
				handler({}, FailResponse);
			}
		}
		
		var fail = function(e:Event) {
			Debug.log("[Playtomic.ServiceRequest.Fail] Service request failed: " + e.toString());
			handler({}, FailResponse);
		}
		
		request.addEventListener("diskError", fail, false, 1, false);
		request.addEventListener("ioError", fail, false, 1, false);
		request.addEventListener("networkError", fail, false, 1, false);
		request.addEventListener("verifyError", fail, false, 1, false);
		request.addEventListener("networkError", fail, false, 1, false);
		request.addEventListener("verifyError", fail, false, 1, false);
		request.addEventListener("securityError", fail, false, 1, false);
		request.addEventListener("uncaughtError", fail, false, 1, false);
		request.addEventListener("httpStatus", ignore, false, 1, false);
		request.addEventListener("complete", complete, false, 1, false);
		
		var urlrequest:URLRequest = new URLRequest();
		urlrequest.url = URL;
		urlrequest.method = "POST";
		urlrequest.data = postvars;
		
		try
		{
			request.load(urlrequest);
		}
		catch(s:String)
		{
			Debug.log("[Playtomic.ServiceRequest.Error] Service request failed: " + s);
			handler({}, FailResponse);
		}
	}
}