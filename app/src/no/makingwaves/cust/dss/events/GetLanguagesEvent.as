
package no.makingwaves.cust.dss.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import no.makingwaves.cust.dss.control.Controller;
	
	public class GetLanguagesEvent extends CairngormEvent
	{		
		public static const GET_LANGUAGES : String = "getLanguages";
		
		public function GetLanguagesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}

	}
}