/**
  * Value object for travel outlay details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelOutlayVO")]
	public class TravelOutlayVO extends Object implements IValueObject
	{
		
		public const AUTHORIZED : Number = 1;
		
		public const UNAUTHORIZED : Number = 2;
		
		public var date : Date;
		
		public var specification : String = "";
		
		public var type : Number;						// AUTHORIZED or UNAUTHORIZED
		
		public var cost : CostVO = new CostVO();
		
	}
}