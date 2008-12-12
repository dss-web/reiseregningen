/**
  * Value object for basic travel info.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelVO")]
	public class TravelVO extends Object implements IValueObject
	{
		// travel_types
		public const DOMESTIC : Number = 1;
		public const ABROAD : Number = 2;
		public const DAY : Number = 3;
		
		// travel_causes
		public const BUSINESS : Number = 1;
		public const COURSE : Number = 2;
		public const OTHER : Number = 3;

		public var location : String = "";

		public var travel_type : Number = 0;

		public var travel_cause : Number = 0;
		
		public var travel_cause_other : String = "";

		public var travel_date_out : Date;

		public var travel_time_out : String;

		public var travel_date_in : Date;

		public var travel_time_in : String;
		
		public var valid:Boolean;
		
		public var travel_number : String;

	}
}