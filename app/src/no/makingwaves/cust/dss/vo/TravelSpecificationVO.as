/**
  * Value object for travel specification details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelSpecificationVO")]
	public class TravelSpecificationVO extends Object implements IValueObject
	{
		
		public var transportation_type : String = "";

		public var from_destination : String = "";
		
		public var from_date : Date;

		public var from_time : String = "";
		
		public var from_timezone : Number = -(new Date().timezoneOffset / 60);
		
		public var from_country : String = "";
		
		public var from_city : String = "";
		
		public var to_destination : String = "";
		
		public var to_date : Date;

		public var to_time : String = "";
		
		public var to_timezone : Number = -(new Date().timezoneOffset / 60);
		
		public var to_country : String = "";
		
		public var to_city : String = "";

		public var is_travel_start : Boolean = false;
		
		public var is_travel_continious : Boolean = false;
		
		public var is_travel_end : Boolean = false;
		
		public var specification : *;
		
		public var cost : CostVO = new CostVO();

	}
}