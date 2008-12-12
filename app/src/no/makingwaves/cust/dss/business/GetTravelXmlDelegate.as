
package no.makingwaves.cust.dss.business
{
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	import webservices.travelexpense.pdf.TravelExpense;
	import webservices.travelexpense.pdf.TravelExpenseVO;

	[Bindable]
	public class GetTravelXmlDelegate
	{

		//attributes =================================

		private var responder : IResponder;
		//private var service : Object;
		private var service : webservices.travelexpense.pdf.TravelExpense; 
		
		public function GetTravelXmlDelegate( responder : IResponder )
		{
			this.service = new TravelExpense();
			this.responder = responder;
		}

		public function getTravelXml(travelExpense:TravelExpenseVO):void {
			this.service.addTravelExpenseFaultEventListener(handleResult);
			this.service.addgetTravelXmlAsStoredIdEventListener(handleResult);
			this.service.getTravelXmlAsStoredId(travelExpense);
		}
		
		public function removeTravelXmlId():void {
			var serverid:String = ModelLocator.getInstance().travelexpense_pdf_id;
			this.service.addremoveDataStoredIdEventListener(handleResult);
			this.service.removeDataStoredId(serverid);
		}
		
		private function handleResult(info:Object):void {
			this.responder.result(info);
		}

	}
}