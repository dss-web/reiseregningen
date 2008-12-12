package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	import no.makingwaves.cust.dss.vo.CurrencyCodeVO;

	public class GetCurrencyCodesCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var configDelegate:CurrencyCodeDelegate;// = new ConfigurationDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			configDelegate = new CurrencyCodeDelegate( this as IResponder );
			configDelegate.getCurrencyCodes();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				// collect resources
				var resources:XMLList = e.result.code;
				for each (var resource:XML in resources) {
					var newResource:CurrencyCodeVO = new CurrencyCodeVO();
					newResource.code = resource.@id;
					newResource.desc = resource.@description;
					newResource.factor = resource.@factor;
					ModelLocator.getInstance().currencyCodes.addItem(newResource);
				}
				
			} catch(e:Error) {
				errorOccoured(e.errorID + ": " + e.message);
				
			} finally {
				ModelLocator.getInstance().initializer.stepComplete();
								
			}	
		}
		
		//----------------------------------------------------------------------------
		public function fault( info : Object ) : void
		{
			errorOccoured();
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().LOW_RISK;
			error.error_message = "Loading codes for currency failed!"
			error.error_message += "\nThe application is still functional but you'll need to enter currency codes manually.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}

	}
}