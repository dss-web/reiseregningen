/**
  * Value object for travel deduction details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelDeductionVO")]
	public class TravelDeductionVO extends Object implements IValueObject
	{
		
		public var date : Date;
		
		public var breakfast : Boolean = false;
		
		public var lunch : Boolean = false;
		
		public var dinner : Boolean = false;
		
		public var cost : CostVO = new CostVO();

	}
}