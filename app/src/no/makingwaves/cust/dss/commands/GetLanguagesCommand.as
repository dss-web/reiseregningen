package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	import no.makingwaves.cust.dss.vo.LanguageVO;

	public class GetLanguagesCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var languageDelegate:GetLanguagesDelegate;// = new ConfigurationDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			languageDelegate = new GetLanguagesDelegate( this as IResponder );
			languageDelegate.getLanguages();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				// collect resources
				var resources:XMLList = e.result.language;
				for each (var resource:XML in resources) {
					var newResource:LanguageVO = new LanguageVO();
					newResource.id = resource.@id;
					newResource.desc = resource.@desc;
					newResource.filename = resource.@filename;
					newResource.name = resource.@name;
					ModelLocator.getInstance().languages.addItem(newResource);
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
			error.error_message = "Loading languages failed!"
			error.error_message += "\nThe application is still functional but only standard language is availible.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}

	}
}