
package no.makingwaves.cust.dss.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	[Bindable]
	public class GetGovernCodeRatesDelegate
	{

		//attributes =================================

		private var responder : IResponder;
		private var service : HTTPService;
		
		public function GetGovernCodeRatesDelegate( responder : IResponder )
		{
			this.service = ServiceLocator.getInstance().getHTTPService( "coderates" );
			this.responder = responder;
		}
		
		public function getGovernCodeRates():void {
			this.service.url = this.getResourceUrl("rateRules");
			var call:mx.rpc.AsyncToken = this.service.send();
			call.addResponder(this.responder);
		}
		
		public function getGovernCodeRatesAbroad():void {
			this.service.url = this.getResourceUrl("ratesInternational");
			var call:mx.rpc.AsyncToken = this.service.send();
			call.addResponder(this.responder);
		}
		
		private function getResourceUrl(id:String):String {
			var resourceList:ArrayCollection = ModelLocator.getInstance().resourceList;
			for (var i:Number = 0; i < resourceList.length; i++) {
				if (resourceList.getItemAt(i).id == id) {
					return resourceList.getItemAt(i).url;
				}
			}
			return "";
		}

	}
}