/**
  * Value object for travel advance details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelAdvanceVO")]
	public class TravelAdvanceVO extends Object implements IValueObject
	{
		
		public var date : Date;
		
		public var location : String = "";
		
		public var cost : Number = 0.0;
		
	}
}