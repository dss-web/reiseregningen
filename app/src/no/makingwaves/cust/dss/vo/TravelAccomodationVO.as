/**
  * Value object for accomodation details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelAccomodationVO")]
	public class TravelAccomodationVO extends Object implements IValueObject
	{

		public const TYPE_HOTEL : Number = 1;
		
		public const TYPE_UNATHORIZED : Number = 2; 

		public const TYPE_UNATHORIZED_HOTEL : Number = 3; 
				
		public var type : Number = 0;
		
		public var name : String = "";
		
		public var adress: String = "";
		
		public var country: String = "";
		
		public var city: String = "";
		
		public var fromdate : Date;
		
		public var todate : Date;
		
		public var breakfast_inluded : Number = 0;
		
		public var cost : CostVO = new CostVO();
		
		public var actual_cost : CostVO = new CostVO();

	}
}