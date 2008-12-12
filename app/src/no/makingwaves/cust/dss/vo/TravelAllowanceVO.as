/**
  * Value object for travel allowance details.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="TravelAllowanceVO")]
	public class TravelAllowanceVO extends Object implements IValueObject
	{
		
		public var adm_allowance : RateVO = new RateVO();
		
		public var accomodation : Boolean;
		
		public var domestic : Boolean;
		
		public var allowance : RateVO = new RateVO();
		
		public var allowance_international : ArrayCollection = new ArrayCollection();
		
		public var nighttariff_domestic : RateVO = new RateVO();
		
		public var nighttariff_domestic_hotel : RateVO = new RateVO();
		
		public var nighttariff_international : ArrayCollection = new ArrayCollection();//: RateVO = new RateVO();
		
		public var allowance_28days : RateVO = new RateVO();
		
		public var nighttariff_28days : RateVO = new RateVO();
		
		public var car_distance1 : RateVO = new RateVO();
		
		public var car_distance2 : RateVO = new RateVO();
		
		public var car_passengers : RateVO = new RateVO();
		
		public var car_otherrates : RateVO = new RateVO();
		
		public var netamount : Number;

	}
}