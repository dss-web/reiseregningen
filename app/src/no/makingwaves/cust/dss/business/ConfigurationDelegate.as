
package no.makingwaves.cust.dss.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	[Bindable]
	public class ConfigurationDelegate
	{

		//attributes =================================

		private var responder : IResponder;
		private var service : Object;
		
		public function ConfigurationDelegate( responder : IResponder )
		{
			this.service = ServiceLocator.getInstance().getHTTPService( "resources" );
			this.responder = responder;
		}

		public function getConfiguration():void {
			var call:AsyncToken = this.service.send();
			call.addResponder(this.responder);
		}

	}
}