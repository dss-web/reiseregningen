/**
  * Value object for travel comment details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelCommentVO")]
	public class TravelCommentVO extends Object implements IValueObject
	{
		
		public var comment : String;
		
	}
}