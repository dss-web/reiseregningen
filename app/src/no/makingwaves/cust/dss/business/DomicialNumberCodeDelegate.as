
package no.makingwaves.cust.dss.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.model.ModelLocator;

	[Bindable]
	public class DomicialNumberCodeDelegate
	{

		//attributes =================================

		private var responder : IResponder;
		private var service : Object;
		
		public function DomicialNumberCodeDelegate( responder : IResponder )
		{
			this.service = ServiceLocator.getInstance().getHTTPService( "general" );
			this.responder = responder;
		}

		public function getCodes():void {
			this.service.url = this.getResourceUrl("domicialNumberCodes");
			var call:AsyncToken = this.service.send();
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