package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.DomicialNumberCodeVO;
	import no.makingwaves.cust.dss.vo.ErrorVO;

	public class GetDomicialNumberCodesCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var configDelegate:DomicialNumberCodeDelegate;// = new ConfigurationDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			configDelegate = new DomicialNumberCodeDelegate( this as IResponder );
			configDelegate.getCodes();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				// collect resources
				var resources:XMLList = e.result.domicial;
				for each (var resource:XML in resources) {
					var newResource:DomicialNumberCodeVO = new DomicialNumberCodeVO();
					newResource.code = resource.@code;
					newResource.domicial = resource.@domicialname;
					ModelLocator.getInstance().domicialNumberCodes.addItem(newResource);
				}
				// add default item
				var defaultResource:DomicialNumberCodeVO = new DomicialNumberCodeVO();
				defaultResource.code = "";
				defaultResource.domicial = ResourceManager.getInstance().getString(ModelLocator.getInstance().resources.bundleName, "domicial_cmb_initvalue");
				ModelLocator.getInstance().domicialNumberCodes.addItem(defaultResource);
				
				var sort:Sort = new Sort();
				sort.fields = [new SortField("domicial")];
				ModelLocator.getInstance().domicialNumberCodes.sort = sort;
				ModelLocator.getInstance().domicialNumberCodes.refresh();
				
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
			error.error_message = "Loading domicial codes failed!"
			error.error_message += "\nThe application is still functional but you'll not be able to choose domicial codes.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}

	}
}