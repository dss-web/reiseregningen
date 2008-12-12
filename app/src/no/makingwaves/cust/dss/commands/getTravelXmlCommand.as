//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.events.GetTravelXmlEvent;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	
	public class getTravelXmlCommand extends getTravelInfoBaseCommand
	{
		// attributes ============================
		private var _travelXmlDelegate:GetTravelXmlDelegate = new GetTravelXmlDelegate(this as IResponder);


		// functions ============================
		override public function execute( event:CairngormEvent ) : void
		{
			var delegate:GetTravelXmlDelegate = new GetTravelXmlDelegate( this );
			delegate.getTravelXml(this.getTravelExpenseData());			
		}
		
		//----------------------------------------------------------------------------
		override public function result( e:Object ) : void
		{
			try {
				// get result from webservice
				var id:String = e.result.toString();
				ModelLocator.getInstance().travelexpense_pdf_id = id;
				// collect webservice url
				var tempUrl:String = this.getResourceUrl("ws_connection");
				
				// set url parameters
				var params:URLVariables = new URLVariables();
				params.id = id;
				
				// create url request
				var request:URLRequest = new URLRequest(tempUrl);
				request.data = params;
				
				// start navigation
	            try {
	                navigateToURL(request, "_new");
	                
	            } catch (error:Error) {
	                trace("Unable to load requested document.");
	                
	            }
	            
			} catch(e:Error) {
				errorOccoured(e.message);
				
			} finally { 
				var minuteTimer:Timer = new Timer(5000,1);
            	minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeXmlServerId);
                // starts the timer ticking
	            minuteTimer.start();
	        }				
		}
		
		//----------------------------------------------------------------------------
		override public function fault( info : Object ) : void
		{
			errorOccoured();		
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Saving XML failed!"
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);	
			ErrorLocator.getInstance().show();		
		}
		
		private function removeXmlServerId(e:TimerEvent):void {
			// remove id from server
			var event:CairngormEvent = new CairngormEvent( GetTravelXmlEvent.REMOVE_TRAVEL_XML_ID );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
	}
}