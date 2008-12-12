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
	import no.makingwaves.cust.dss.vo.PostalCodeVO;

	public class GetPostalCodesCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var configDelegate:PostalCodeDelegate;// = new ConfigurationDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			configDelegate = new PostalCodeDelegate( this as IResponder );
			configDelegate.getPostalCodes();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				// collect resources
				var resources:XMLList = e.result.postoffice;
				for each (var resource:XML in resources) {
					var newResource:PostalCodeVO = new PostalCodeVO();
					newResource.code = resource.@code;
					newResource.office = resource.@office;
					ModelLocator.getInstance().postOfficeCodes.addItem(newResource);
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
			error.error_message = "Loading postoffice codes failed!"
			error.error_message += "\nThe application is still functional but you'll need to enter postal codes manually.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}

	}
}