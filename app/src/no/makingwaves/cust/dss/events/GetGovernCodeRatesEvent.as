
package no.makingwaves.cust.dss.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import no.makingwaves.cust.dss.control.Controller;
	
	public class GetGovernCodeRatesEvent extends CairngormEvent
	{		
		public static const GET_RATES : String = "getGovernCodeRatesEvent";
		public static const GET_RATES_ABROAD : String = "getGovernCodeRatesAbroadEvent";
		
		public function GetGovernCodeRatesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}

	}
}