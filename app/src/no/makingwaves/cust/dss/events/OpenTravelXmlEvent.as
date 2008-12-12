
package no.makingwaves.cust.dss.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import no.makingwaves.cust.dss.control.Controller;
	
	public class OpenTravelXmlEvent extends CairngormEvent
	{		
		public static const OPEN_TRAVEL_PDF : String = "openTravelPdf";
		
		public function OpenTravelXmlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}

	}
}