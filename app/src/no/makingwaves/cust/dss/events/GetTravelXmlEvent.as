
package no.makingwaves.cust.dss.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import no.makingwaves.cust.dss.control.Controller;
	
	public class GetTravelXmlEvent extends CairngormEvent
	{		
		public static const GET_TRAVEL_XML : String = "getTravelXml";
		public static const REMOVE_TRAVEL_XML_ID : String = "removeTravelXmlStoredId";
		
		public function GetTravelXmlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}

	}
}