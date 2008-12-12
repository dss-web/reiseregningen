/**
  * Value object for specifications for other types of transportation.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import no.makingwaves.cust.dss.vo.CommonSpecificationVO;

	[Bindable]
	[RemoteClass(alias="OtherSpecificationVO")]
	public class OtherSpecificationVO extends CommonSpecificationVO
	{
		
		override public var type : String = "other";
		
		public var other_type : Number;
		
		public const TYPE_SNOWMOBILE : Number = 1;
		
		public const TYPE_EL_CAR : Number = 2;
		
		public const TYPE_OTHER : Number = 3;

	}
}