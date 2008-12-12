/**
  * Value object for specifications for car as transportation.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import no.makingwaves.cust.dss.vo.CommonSpecificationVO;

	[Bindable]
	[RemoteClass(alias="CarSpecificationVO")]
	public class CarSpecificationVO extends CommonSpecificationVO
	{
		
		override public var type : String = "car";
		
		public var distance_calender : Number = TYPE_BELOW_9000KM;
		
		public var distance_forestroad : Number = 0;
		
		public var additional_trailer : Boolean = false;
		
		public var additional_workplace : Boolean = false;
		
		public const TYPE_BELOW_9000KM : Number = 1;
		
		public const TYPE_ABOVE_9000KM : Number = 2;

	}
}