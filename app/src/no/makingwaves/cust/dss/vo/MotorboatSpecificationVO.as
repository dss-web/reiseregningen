/**
  * Value object for specifications for motorboat as transportation.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import no.makingwaves.cust.dss.vo.CommonSpecificationVO;

	[Bindable]
	[RemoteClass(alias="MotorboatSpecificationVO")]
	public class MotorboatSpecificationVO extends CommonSpecificationVO
	{
		
		override public var type : String = "motorboat";
		
		public var motorboat_type : Number;
		
		public const TYPE_BELOW_50HK : Number = 1;
		
		public const TYPE_ABOVE_50HK : Number = 2;

	}
}