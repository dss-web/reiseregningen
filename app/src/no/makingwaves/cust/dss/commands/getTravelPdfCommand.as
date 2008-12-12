package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.events.GetTravelPdfEvent;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;


	public class getTravelPdfCommand extends getTravelInfoBaseCommand
	{
		// attributes ============================
		private var _travelPdfDelegate:GetTravelPdfDelegate = new GetTravelPdfDelegate(this as IResponder);


		// functions ============================
		override public function execute( event:CairngormEvent ) : void
		{
			var delegate:GetTravelPdfDelegate = new GetTravelPdfDelegate( this );
			delegate.getTravelPdf(this.getTravelExpenseData("pdf"));			
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
				this.errorOccoured(e.message);
				
			} finally { 
				var minuteTimer:Timer = new Timer(5000,1);
            	minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removePdfServerId);
                // starts the timer ticking
	            minuteTimer.start();
	        }				
		}
		
		//----------------------------------------------------------------------------
		override public function fault( info : Object ) : void
		{
			this.errorOccoured();
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Loading PDF failed!"
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);	
			ErrorLocator.getInstance().show();	
		}
		
		private function removePdfServerId(e:TimerEvent):void {
			// remove id from server
			var event:CairngormEvent = new CairngormEvent( GetTravelPdfEvent.REMOVE_TRAVEL_PDF_ID );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}	
		
	}
}