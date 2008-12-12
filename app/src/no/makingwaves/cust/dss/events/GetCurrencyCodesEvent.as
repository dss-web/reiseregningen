
package no.makingwaves.cust.dss.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import no.makingwaves.cust.dss.control.Controller;
	
	public class GetCurrencyCodesEvent extends CairngormEvent
	{		
		public static const GET_CURRENCYCODES : String = "getCurrencyCodes";
		
		public function GetCurrencyCodesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}

	}
}