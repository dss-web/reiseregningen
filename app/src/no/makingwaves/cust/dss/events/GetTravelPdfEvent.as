
package no.makingwaves.cust.dss.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import no.makingwaves.cust.dss.control.Controller;
	
	public class GetTravelPdfEvent extends CairngormEvent
	{		
		public static const GET_TRAVEL_PDF : String = "getTravelPdf";
		public static const REMOVE_TRAVEL_PDF_ID : String = "removeTravelPdfStoredId";
		
		public function GetTravelPdfEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}

	}
}