/**
  * Value object for a rates imported into the application	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class RateVO extends Object implements IValueObject
	{
		
		public var num : Number = 0;
		
		public var rate : Number = 0.0;
		
		public var amount : Number = 0.0;
		
		public function init():void {
			num = 0;
			rate = 0.0;
			amount = 0.0;
		}
		
	}
}