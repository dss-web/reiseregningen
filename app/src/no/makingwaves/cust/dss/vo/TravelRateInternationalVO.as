/**
  * Value object for international rates imported into the application.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class TravelRateInternationalVO extends Object implements IValueObject
	{
		
		public var code : String = "";
		
		public var country : String = "";
		
		public var city : String = "";
		
		public var night : Number = 0;
		
		public var allowance : Number = 0;
		
		public var timezone : int = 0;
		
		public var daylightsaving : Boolean = false;
		
	}
}