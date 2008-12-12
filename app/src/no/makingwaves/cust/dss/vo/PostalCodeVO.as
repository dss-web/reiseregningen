/**
  * Value object for postal codes imported into the application.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class PostalCodeVO extends Object implements IValueObject
	{

		public var code : String = "";

		public var office : String = "";

	}
}