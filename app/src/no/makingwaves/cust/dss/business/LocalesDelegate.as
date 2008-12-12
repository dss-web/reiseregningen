
package no.makingwaves.cust.dss.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.model.ModelLocator;

	[Bindable]
	public class LocalesDelegate
	{

		//attributes =================================

		private var responder : IResponder;
		private var service : Object;
		
		public function LocalesDelegate( responder : IResponder )
		{
			this.service = ServiceLocator.getInstance().getHTTPService( "getLocales" );
			this.responder = responder;
		}

		public function getLocales():void {
			this.service.url = ModelLocator.getInstance().resources.localeUrl;
			var call:mx.rpc.AsyncToken = this.service.send();
			call.addResponder(this.responder);
		}

	}
}