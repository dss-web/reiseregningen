/**
  * Value object for travel rate rules imported into the application.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class TravelRateRuleVO extends Object implements IValueObject
	{
		
		public const DOMESTIC : String = "domestic";
		
		public const INTERNATIONAL : String = "international";
		
		
		public var id : String = "";
		
		public var description : String = "";
		
		public var cost : Number = 0;
		
		public var percent : Number = 0;
		
		public var percent_of_rule : String = "";		// id* of rules to apply
		
		public var rule_min_hours : Number = 0;
		
		public var rule_max_hours : Number = 0;
		
		public var rule_min_value : Number = 0;
		
		public var rule_max_value : Number = 0;
		
		public var rule_travel_type : String;				// DOMESTIC or INTERNATIONAL
		
		
	}
}