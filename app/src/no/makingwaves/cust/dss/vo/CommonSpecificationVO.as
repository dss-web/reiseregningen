/**
  * Value object for general specifications fortransportation.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import no.makingwaves.cust.dss.vo.SpecificationVO;

	[Bindable]
	[RemoteClass(alias="CommonSpecificationVO")]
	public class CommonSpecificationVO extends SpecificationVO
	{
		
		public var distance : Number = 0;
		
		public var passengers : Number = 0;
		
		public var rate : Number = 0.0;
		
		public var cost : CostVO = new CostVO();

	}
}