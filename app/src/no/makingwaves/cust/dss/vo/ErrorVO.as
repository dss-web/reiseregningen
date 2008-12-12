/**
  * Value object for errors.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import no.makingwaves.cust.dss.model.ErrorLocator;

	[Bindable]
	public class ErrorVO extends Object implements IValueObject
	{
		public var error_code : Number;

		public var error_message : String = "";

	}
}