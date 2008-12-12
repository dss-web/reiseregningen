/**
  * Value object for international rates imported into the application.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class TravelRateInternationalVO extends Object implements IValueObject
	{
		
		public var code : String = "";
		
		public var country : String = "";
		
		public var city : String = "";
		
		public var night : Number = 0;
		
		public var allowance : Number = 0;
		
	}
}