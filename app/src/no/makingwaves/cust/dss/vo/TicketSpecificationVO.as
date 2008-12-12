/**
  * Value object for all route transportation specifications
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import no.makingwaves.cust.dss.vo.SpecificationVO;

	[Bindable]
	[RemoteClass(alias="TicketSpecificationVO")]
	public class TicketSpecificationVO extends SpecificationVO
	{
		
		override public var type : String = "ticket";
		
		public var cost : CostVO = new CostVO();

	}
}