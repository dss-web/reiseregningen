
/**
 * TravelExpenseService.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
 /**
  * Usage example: to use this service from within your Flex application you have two choices:
  * Use it via Actionscript only
  * Use it via MXML tags
  * Actionscript sample code:
  * Step 1: create an instance of the service; pass it the LCDS destination string if any
  * var myService:TravelExpense= new TravelExpense();
  * Step 2: for the desired operation add a result handler (a function that you have already defined previously)  
  * myService.addGetVersionEventListener(myResultHandlingFunction);
  * Step 3: Call the operation as a method on the service. Pass the right values as arguments:
  * myService.GetVersion();
  *
  * MXML sample code:
  * First you need to map the package where the files were generated to a namespace, usually on the <mx:Application> tag, 
  * like this: xmlns:srv="webservices.travelexpense.pdf.*"
  * Define the service and within its tags set the request wrapper for the desired operation
  * <srv:TravelExpense id="myService">
  *   <srv:GetVersion_request_var>
  *		<srv:GetVersion_request />
  *   </srv:GetVersion_request_var>
  * </srv:TravelExpense>
  * Then call the operation for which you have set the request wrapper value above, like this:
  * <mx:Button id="myButton" label="Call operation" click="myService.GetVersion_send()" />
  */
 package webservices.travelexpense.pdf{
	import mx.rpc.AsyncToken;
	import flash.events.EventDispatcher;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;

    /**
     * Dispatches when a call to the operation GetVersion completes with success
     * and returns some data
     * @eventType GetVersionResultEvent
     */
    [Event(name="GetVersion_result", type="webservices.travelexpense.pdf.GetVersionResultEvent")]
    
    /**
     * Dispatches when a call to the operation getTravelPdf completes with success
     * and returns some data
     * @eventType GetTravelPdfResultEvent
     */
    [Event(name="GetTravelPdf_result", type="webservices.travelexpense.pdf.GetTravelPdfResultEvent")]
    
    /**
     * Dispatches when a call to the operation getTravelPdfAsStoredId completes with success
     * and returns some data
     * @eventType GetTravelPdfAsStoredIdResultEvent
     */
    [Event(name="GetTravelPdfAsStoredId_result", type="webservices.travelexpense.pdf.GetTravelPdfAsStoredIdResultEvent")]
    
    /**
     * Dispatches when a call to the operation getTravelXmlAsStoredId completes with success
     * and returns some data
     * @eventType GetTravelXmlAsStoredIdResultEvent
     */
    [Event(name="GetTravelXmlAsStoredId_result", type="webservices.travelexpense.pdf.GetTravelXmlAsStoredIdResultEvent")]
    
    /**
     * Dispatches when a call to the operation removeDataStoredId completes with success
     * and returns some data
     * @eventType RemoveDataStoredIdResultEvent
     */
    [Event(name="RemoveDataStoredId_result", type="webservices.travelexpense.pdf.RemoveDataStoredIdResultEvent")]
    
    /**
     * Dispatches when a call to the operation getTravelObjectFromXml completes with success
     * and returns some data
     * @eventType GetTravelObjectFromXmlResultEvent
     */
    [Event(name="GetTravelObjectFromXml_result", type="webservices.travelexpense.pdf.GetTravelObjectFromXmlResultEvent")]
    
    /**
     * Dispatches when a call to the operation getTravelObjectFromXmlAsStoredId completes with success
     * and returns some data
     * @eventType GetTravelObjectFromXmlAsStoredIdResultEvent
     */
    [Event(name="GetTravelObjectFromXmlAsStoredId_result", type="webservices.travelexpense.pdf.GetTravelObjectFromXmlAsStoredIdResultEvent")]
    
    /**
     * Dispatches when a call to the operation RunTestAndGetId completes with success
     * and returns some data
     * @eventType RunTestAndGetIdResultEvent
     */
    [Event(name="RunTestAndGetId_result", type="webservices.travelexpense.pdf.RunTestAndGetIdResultEvent")]
    
	/**
	 * Dispatches when the operation that has been called fails. The fault event is common for all operations
	 * of the WSDL
	 * @eventType mx.rpc.events.FaultEvent
	 */
    [Event(name="fault", type="mx.rpc.events.FaultEvent")]

	public class TravelExpense extends EventDispatcher implements ITravelExpense
	{
    	private var _baseService:BaseTravelExpense;
        
        /**
         * Constructor for the facade; sets the destination and create a baseService instance
         * @param The LCDS destination (if any) associated with the imported WSDL
         */  
        public function TravelExpense(destination:String=null,rootURL:String=null)
        {
        	_baseService = new BaseTravelExpense(destination,rootURL);
        }
        
		//stub functions for the GetVersion operation
          

        /**
         * @see ITravelExpense#GetVersion()
         */
        public function getVersion():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getVersion();
            _internal_token.addEventListener("result",_GetVersion_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#GetVersion_send()
		 */    
        public function getVersion_send():AsyncToken
        {
        	return getVersion();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _GetVersion_lastResult:String;
		[Bindable]
		/**
		 * @see ITravelExpense#GetVersion_lastResult
		 */	  
		public function get getVersion_lastResult():String
		{
			return _GetVersion_lastResult;
		}
		/**
		 * @private
		 */
		public function set getVersion_lastResult(lastResult:String):void
		{
			_GetVersion_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addGetVersion()
		 */
		public function addgetVersionEventListener(listener:Function):void
		{
			addEventListener(GetVersionResultEvent.GetVersion_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _GetVersion_populate_results(event:ResultEvent):void
        {
        var e:GetVersionResultEvent = new GetVersionResultEvent();
		            e.result = event.result as String;
		                       e.headers = event.headers;
		             getVersion_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the getTravelPdf operation
          

        /**
         * @see ITravelExpense#getTravelPdf()
         */
        public function getTravelPdf(travel:TravelExpenseVO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getTravelPdf(travel);
            _internal_token.addEventListener("result",_getTravelPdf_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#getTravelPdf_send()
		 */    
        public function getTravelPdf_send():AsyncToken
        {
        	return getTravelPdf(_getTravelPdf_request.travel);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getTravelPdf_request:GetTravelPdf_request;
		/**
		 * @see ITravelExpense#getTravelPdf_request_var
		 */
		[Bindable]
		public function get getTravelPdf_request_var():GetTravelPdf_request
		{
			return _getTravelPdf_request;
		}
		
		/**
		 * @private
		 */
		public function set getTravelPdf_request_var(request:GetTravelPdf_request):void
		{
			_getTravelPdf_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getTravelPdf_lastResult:TravelReportDocumentVO;
		[Bindable]
		/**
		 * @see ITravelExpense#getTravelPdf_lastResult
		 */	  
		public function get getTravelPdf_lastResult():TravelReportDocumentVO
		{
			return _getTravelPdf_lastResult;
		}
		/**
		 * @private
		 */
		public function set getTravelPdf_lastResult(lastResult:TravelReportDocumentVO):void
		{
			_getTravelPdf_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addgetTravelPdf()
		 */
		public function addgetTravelPdfEventListener(listener:Function):void
		{
			addEventListener(GetTravelPdfResultEvent.GetTravelPdf_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getTravelPdf_populate_results(event:ResultEvent):void
        {
        var e:GetTravelPdfResultEvent = new GetTravelPdfResultEvent();
		            e.result = event.result as TravelReportDocumentVO;
		                       e.headers = event.headers;
		             getTravelPdf_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the getTravelPdfAsStoredId operation
          

        /**
         * @see ITravelExpense#getTravelPdfAsStoredId()
         */
        public function getTravelPdfAsStoredId(travel:TravelExpenseVO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getTravelPdfAsStoredId(travel);
            _internal_token.addEventListener("result",_getTravelPdfAsStoredId_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#getTravelPdfAsStoredId_send()
		 */    
        public function getTravelPdfAsStoredId_send():AsyncToken
        {
        	return getTravelPdfAsStoredId(_getTravelPdfAsStoredId_request.travel);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getTravelPdfAsStoredId_request:GetTravelPdfAsStoredId_request;
		/**
		 * @see ITravelExpense#getTravelPdfAsStoredId_request_var
		 */
		[Bindable]
		public function get getTravelPdfAsStoredId_request_var():GetTravelPdfAsStoredId_request
		{
			return _getTravelPdfAsStoredId_request;
		}
		
		/**
		 * @private
		 */
		public function set getTravelPdfAsStoredId_request_var(request:GetTravelPdfAsStoredId_request):void
		{
			_getTravelPdfAsStoredId_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getTravelPdfAsStoredId_lastResult:String;
		[Bindable]
		/**
		 * @see ITravelExpense#getTravelPdfAsStoredId_lastResult
		 */	  
		public function get getTravelPdfAsStoredId_lastResult():String
		{
			return _getTravelPdfAsStoredId_lastResult;
		}
		/**
		 * @private
		 */
		public function set getTravelPdfAsStoredId_lastResult(lastResult:String):void
		{
			_getTravelPdfAsStoredId_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addgetTravelPdfAsStoredId()
		 */
		public function addgetTravelPdfAsStoredIdEventListener(listener:Function):void
		{
			addEventListener(GetTravelPdfAsStoredIdResultEvent.GetTravelPdfAsStoredId_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getTravelPdfAsStoredId_populate_results(event:ResultEvent):void
        {
        var e:GetTravelPdfAsStoredIdResultEvent = new GetTravelPdfAsStoredIdResultEvent();
		            e.result = event.result as String;
		                       e.headers = event.headers;
		             getTravelPdfAsStoredId_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the getTravelXmlAsStoredId operation
          

        /**
         * @see ITravelExpense#getTravelXmlAsStoredId()
         */
        public function getTravelXmlAsStoredId(travel:TravelExpenseVO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getTravelXmlAsStoredId(travel);
            _internal_token.addEventListener("result",_getTravelXmlAsStoredId_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#getTravelXmlAsStoredId_send()
		 */    
        public function getTravelXmlAsStoredId_send():AsyncToken
        {
        	return getTravelXmlAsStoredId(_getTravelXmlAsStoredId_request.travel);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getTravelXmlAsStoredId_request:GetTravelXmlAsStoredId_request;
		/**
		 * @see ITravelExpense#getTravelXmlAsStoredId_request_var
		 */
		[Bindable]
		public function get getTravelXmlAsStoredId_request_var():GetTravelXmlAsStoredId_request
		{
			return _getTravelXmlAsStoredId_request;
		}
		
		/**
		 * @private
		 */
		public function set getTravelXmlAsStoredId_request_var(request:GetTravelXmlAsStoredId_request):void
		{
			_getTravelXmlAsStoredId_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getTravelXmlAsStoredId_lastResult:String;
		[Bindable]
		/**
		 * @see ITravelExpense#getTravelXmlAsStoredId_lastResult
		 */	  
		public function get getTravelXmlAsStoredId_lastResult():String
		{
			return _getTravelXmlAsStoredId_lastResult;
		}
		/**
		 * @private
		 */
		public function set getTravelXmlAsStoredId_lastResult(lastResult:String):void
		{
			_getTravelXmlAsStoredId_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addgetTravelXmlAsStoredId()
		 */
		public function addgetTravelXmlAsStoredIdEventListener(listener:Function):void
		{
			addEventListener(GetTravelXmlAsStoredIdResultEvent.GetTravelXmlAsStoredId_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getTravelXmlAsStoredId_populate_results(event:ResultEvent):void
        {
        var e:GetTravelXmlAsStoredIdResultEvent = new GetTravelXmlAsStoredIdResultEvent();
		            e.result = event.result as String;
		                       e.headers = event.headers;
		             getTravelXmlAsStoredId_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the removeDataStoredId operation
          

        /**
         * @see ITravelExpense#removeDataStoredId()
         */
        public function removeDataStoredId(id:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.removeDataStoredId(id);
            _internal_token.addEventListener("result",_removeDataStoredId_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#removeDataStoredId_send()
		 */    
        public function removeDataStoredId_send():AsyncToken
        {
        	return removeDataStoredId(_removeDataStoredId_request.id);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _removeDataStoredId_request:RemoveDataStoredId_request;
		/**
		 * @see ITravelExpense#removeDataStoredId_request_var
		 */
		[Bindable]
		public function get removeDataStoredId_request_var():RemoveDataStoredId_request
		{
			return _removeDataStoredId_request;
		}
		
		/**
		 * @private
		 */
		public function set removeDataStoredId_request_var(request:RemoveDataStoredId_request):void
		{
			_removeDataStoredId_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _removeDataStoredId_lastResult:Boolean;
		[Bindable]
		/**
		 * @see ITravelExpense#removeDataStoredId_lastResult
		 */	  
		public function get removeDataStoredId_lastResult():Boolean
		{
			return _removeDataStoredId_lastResult;
		}
		/**
		 * @private
		 */
		public function set removeDataStoredId_lastResult(lastResult:Boolean):void
		{
			_removeDataStoredId_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addremoveDataStoredId()
		 */
		public function addremoveDataStoredIdEventListener(listener:Function):void
		{
			addEventListener(RemoveDataStoredIdResultEvent.RemoveDataStoredId_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _removeDataStoredId_populate_results(event:ResultEvent):void
        {
        var e:RemoveDataStoredIdResultEvent = new RemoveDataStoredIdResultEvent();
		            e.result = event.result as Boolean;
		                       e.headers = event.headers;
		             removeDataStoredId_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the getTravelObjectFromXml operation
          

        /**
         * @see ITravelExpense#getTravelObjectFromXml()
         */
        public function getTravelObjectFromXml(xmlFileBytes:flash.utils.ByteArray):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getTravelObjectFromXml(xmlFileBytes);
            _internal_token.addEventListener("result",_getTravelObjectFromXml_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#getTravelObjectFromXml_send()
		 */    
        public function getTravelObjectFromXml_send():AsyncToken
        {
        	return getTravelObjectFromXml(_getTravelObjectFromXml_request.xmlFileBytes);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getTravelObjectFromXml_request:GetTravelObjectFromXml_request;
		/**
		 * @see ITravelExpense#getTravelObjectFromXml_request_var
		 */
		[Bindable]
		public function get getTravelObjectFromXml_request_var():GetTravelObjectFromXml_request
		{
			return _getTravelObjectFromXml_request;
		}
		
		/**
		 * @private
		 */
		public function set getTravelObjectFromXml_request_var(request:GetTravelObjectFromXml_request):void
		{
			_getTravelObjectFromXml_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getTravelObjectFromXml_lastResult:TravelExpenseVO;
		[Bindable]
		/**
		 * @see ITravelExpense#getTravelObjectFromXml_lastResult
		 */	  
		public function get getTravelObjectFromXml_lastResult():TravelExpenseVO
		{
			return _getTravelObjectFromXml_lastResult;
		}
		/**
		 * @private
		 */
		public function set getTravelObjectFromXml_lastResult(lastResult:TravelExpenseVO):void
		{
			_getTravelObjectFromXml_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addgetTravelObjectFromXml()
		 */
		public function addgetTravelObjectFromXmlEventListener(listener:Function):void
		{
			addEventListener(GetTravelObjectFromXmlResultEvent.GetTravelObjectFromXml_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getTravelObjectFromXml_populate_results(event:ResultEvent):void
        {
        var e:GetTravelObjectFromXmlResultEvent = new GetTravelObjectFromXmlResultEvent();
		            e.result = event.result as TravelExpenseVO;
		                       e.headers = event.headers;
		             getTravelObjectFromXml_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the getTravelObjectFromXmlAsStoredId operation
          

        /**
         * @see ITravelExpense#getTravelObjectFromXmlAsStoredId()
         */
        public function getTravelObjectFromXmlAsStoredId(id:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getTravelObjectFromXmlAsStoredId(id);
            _internal_token.addEventListener("result",_getTravelObjectFromXmlAsStoredId_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#getTravelObjectFromXmlAsStoredId_send()
		 */    
        public function getTravelObjectFromXmlAsStoredId_send():AsyncToken
        {
        	return getTravelObjectFromXmlAsStoredId(_getTravelObjectFromXmlAsStoredId_request.id);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getTravelObjectFromXmlAsStoredId_request:GetTravelObjectFromXmlAsStoredId_request;
		/**
		 * @see ITravelExpense#getTravelObjectFromXmlAsStoredId_request_var
		 */
		[Bindable]
		public function get getTravelObjectFromXmlAsStoredId_request_var():GetTravelObjectFromXmlAsStoredId_request
		{
			return _getTravelObjectFromXmlAsStoredId_request;
		}
		
		/**
		 * @private
		 */
		public function set getTravelObjectFromXmlAsStoredId_request_var(request:GetTravelObjectFromXmlAsStoredId_request):void
		{
			_getTravelObjectFromXmlAsStoredId_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getTravelObjectFromXmlAsStoredId_lastResult:TravelExpenseVO;
		[Bindable]
		/**
		 * @see ITravelExpense#getTravelObjectFromXmlAsStoredId_lastResult
		 */	  
		public function get getTravelObjectFromXmlAsStoredId_lastResult():TravelExpenseVO
		{
			return _getTravelObjectFromXmlAsStoredId_lastResult;
		}
		/**
		 * @private
		 */
		public function set getTravelObjectFromXmlAsStoredId_lastResult(lastResult:TravelExpenseVO):void
		{
			_getTravelObjectFromXmlAsStoredId_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addgetTravelObjectFromXmlAsStoredId()
		 */
		public function addgetTravelObjectFromXmlAsStoredIdEventListener(listener:Function):void
		{
			addEventListener(GetTravelObjectFromXmlAsStoredIdResultEvent.GetTravelObjectFromXmlAsStoredId_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getTravelObjectFromXmlAsStoredId_populate_results(event:ResultEvent):void
        {
        var e:GetTravelObjectFromXmlAsStoredIdResultEvent = new GetTravelObjectFromXmlAsStoredIdResultEvent();
		            e.result = event.result as TravelExpenseVO;
		                       e.headers = event.headers;
		             getTravelObjectFromXmlAsStoredId_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//stub functions for the RunTestAndGetId operation
          

        /**
         * @see ITravelExpense#RunTestAndGetId()
         */
        public function runTestAndGetId():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.runTestAndGetId();
            _internal_token.addEventListener("result",_RunTestAndGetId_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ITravelExpense#RunTestAndGetId_send()
		 */    
        public function runTestAndGetId_send():AsyncToken
        {
        	return runTestAndGetId();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _RunTestAndGetId_lastResult:String;
		[Bindable]
		/**
		 * @see ITravelExpense#RunTestAndGetId_lastResult
		 */	  
		public function get runTestAndGetId_lastResult():String
		{
			return _RunTestAndGetId_lastResult;
		}
		/**
		 * @private
		 */
		public function set runTestAndGetId_lastResult(lastResult:String):void
		{
			_RunTestAndGetId_lastResult = lastResult;
		}
		
		/**
		 * @see ITravelExpense#addRunTestAndGetId()
		 */
		public function addrunTestAndGetIdEventListener(listener:Function):void
		{
			addEventListener(RunTestAndGetIdResultEvent.RunTestAndGetId_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _RunTestAndGetId_populate_results(event:ResultEvent):void
        {
        var e:RunTestAndGetIdResultEvent = new RunTestAndGetIdResultEvent();
		            e.result = event.result as String;
		                       e.headers = event.headers;
		             runTestAndGetId_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//service-wide functions
		/**
		 * @see ITravelExpense#getWebService()
		 */
		public function getWebService():BaseTravelExpense
		{
			return _baseService;
		}
		
		/**
		 * Set the event listener for the fault event which can be triggered by each of the operations defined by the facade
		 */
		public function addTravelExpenseFaultEventListener(listener:Function):void
		{
			addEventListener("fault",listener);
		}
		
		/**
		 * Internal function to re-dispatch the fault event passed on by the base service implementation
		 * @private
		 */
		 
		 private function throwFault(event:FaultEvent):void
		 {
		 	dispatchEvent(event);
		 }
    }
}
