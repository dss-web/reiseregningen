/**
  * Value object for specifications for motorcycle as transportation.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import no.makingwaves.cust.dss.vo.CommonSpecificationVO;

	[Bindable]
	[RemoteClass(alias="MotorcycleSpecificationVO")]
	public class MotorcycleSpecificationVO extends CommonSpecificationVO
	{
		
		override public var type : String = "motorcycle";
		
		public var motorcycle_type : Number;
		
		public const TYPE_BELOW_125CC : Number = 1;
		
		public const TYPE_ABOVE_125CC : Number = 2;

	}
}