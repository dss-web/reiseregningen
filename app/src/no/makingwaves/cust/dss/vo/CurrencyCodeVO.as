/**
  * Value object for currency codes imported into the application	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class CurrencyCodeVO extends Object implements IValueObject
	{

		public var code : String = "";

		public var desc : String = "";
		
		public var factor : Number = 1;

	}
}