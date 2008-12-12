/**
  * Value object for domicial numbers imported into the application.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class DomicialNumberCodeVO extends Object implements IValueObject
	{

		public var code : String = "";

		public var domicial : String = "";

	}
}