/**
  * Value object for resources imported into the application.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class ResourcesVO extends Object implements IValueObject
	{

		public var id : String = "";

		public var url : String = "";

	}
}