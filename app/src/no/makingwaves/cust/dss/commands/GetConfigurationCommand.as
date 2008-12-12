package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	import no.makingwaves.cust.dss.vo.ResourcesVO;

	public class GetConfigurationCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var configDelegate:ConfigurationDelegate;// = new ConfigurationDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			configDelegate = new ConfigurationDelegate( this as IResponder );
			configDelegate.getConfiguration();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				// collect resources
				var resources:XMLList = e.result.resource;
				for each (var resource:XML in resources) {
					var newResource:ResourcesVO = new ResourcesVO();
					newResource.id = resource.@id;
					newResource.url = resource.@url;
					ModelLocator.getInstance().resourceList.addItem(newResource);
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
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Loading configuration failed!"
			error.error_message += "\nThe application is not able to start.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();			
		}

	}
}