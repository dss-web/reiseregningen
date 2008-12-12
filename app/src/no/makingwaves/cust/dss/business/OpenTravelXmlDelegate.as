
package no.makingwaves.cust.dss.business
{
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	import webservices.travelexpense.pdf.TravelExpense;
	import webservices.travelexpense.pdf.TravelExpenseVO;

	[Bindable]
	public class OpenTravelXmlDelegate
	{

		//attributes =================================

		private var responder : IResponder;
		//private var service : Object;
		private var service : webservices.travelexpense.pdf.TravelExpense; 
		
		public function OpenTravelXmlDelegate( responder : IResponder )
		{
			this.service = new TravelExpense();
			this.responder = responder;
		}

		public function openTravelXml():void {
			this.service.addTravelExpenseFaultEventListener(handleResult);
			this.service.addgetTravelObjectFromXmlAsStoredIdEventListener(handleResult);
			this.service.getTravelObjectFromXmlAsStoredId(ModelLocator.getInstance().xmlImportId);
		}
		
		private function handleResult(info:Object):void {
			this.responder.result(info);
		}

	}
}