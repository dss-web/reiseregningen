/**
  * Value object for travel specifications	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="SpecificationVO")]
	public class SpecificationVO extends Object implements IValueObject
	{
		
		public var type : String = "";
		
	}
}