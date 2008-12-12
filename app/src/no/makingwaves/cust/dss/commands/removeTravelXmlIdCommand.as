//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.*;
	import flash.net.*;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.events.GetTravelXmlEvent;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;

	public class removeTravelXmlIdCommand implements ICommand, IResponder
	{ 
		// attributes ============================
		private var _travelXmlDelegate:GetTravelXmlDelegate = new GetTravelXmlDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			var delegate:GetTravelXmlDelegate = new GetTravelXmlDelegate( this );
			delegate.removeTravelXmlId();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				// get result from webservice
				var id:String = e.result.toString();
	            
			} catch(e:Error) {
				errorOccoured(e.message);
				
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
			error.error_message = "Connection with webservice to delete xml id failed!"
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);	
			ErrorLocator.getInstance().show();		
		}
		
	}
}