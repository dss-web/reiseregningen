
/**
 * Service.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package webservices.travelexpense.pdf{
	import mx.rpc.AsyncToken;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;
               
    public interface ITravelExpense
    {
    	//Stub functions for the GetVersion operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function getVersion():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getVersion_send():AsyncToken;
        
        /**
         * The getVersion operation lastResult property
         */
        function get getVersion_lastResult():String;
		/**
		 * @private
		 */
        function set getVersion_lastResult(lastResult:String):void;
       /**
        * Add a listener for the getVersion operation successful result event
        * @param The listener function
        */
       function addgetVersionEventListener(listener:Function):void;
       
       
    	//Stub functions for the getTravelPdf operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param travel
    	 * @return An AsyncToken
    	 */
    	function getTravelPdf(travel:TravelExpenseVO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getTravelPdf_send():AsyncToken;
        
        /**
         * The getTravelPdf operation lastResult property
         */
        function get getTravelPdf_lastResult():TravelReportDocumentVO;
		/**
		 * @private
		 */
        function set getTravelPdf_lastResult(lastResult:TravelReportDocumentVO):void;
       /**
        * Add a listener for the getTravelPdf operation successful result event
        * @param The listener function
        */
       function addgetTravelPdfEventListener(listener:Function):void;
       
       
        /**
         * The getTravelPdf operation request wrapper
         */
        function get getTravelPdf_request_var():GetTravelPdf_request;
        
        /**
         * @private
         */
        function set getTravelPdf_request_var(request:GetTravelPdf_request):void;
                   
    	//Stub functions for the getTravelPdfAsStoredId operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param travel
    	 * @return An AsyncToken
    	 */
    	function getTravelPdfAsStoredId(travel:TravelExpenseVO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getTravelPdfAsStoredId_send():AsyncToken;
        
        /**
         * The getTravelPdfAsStoredId operation lastResult property
         */
        function get getTravelPdfAsStoredId_lastResult():String;
		/**
		 * @private
		 */
        function set getTravelPdfAsStoredId_lastResult(lastResult:String):void;
       /**
        * Add a listener for the getTravelPdfAsStoredId operation successful result event
        * @param The listener function
        */
       function addgetTravelPdfAsStoredIdEventListener(listener:Function):void;
       
       
        /**
         * The getTravelPdfAsStoredId operation request wrapper
         */
        function get getTravelPdfAsStoredId_request_var():GetTravelPdfAsStoredId_request;
        
        /**
         * @private
         */
        function set getTravelPdfAsStoredId_request_var(request:GetTravelPdfAsStoredId_request):void;
                   
    	//Stub functions for the getTravelXmlAsStoredId operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param travel
    	 * @return An AsyncToken
    	 */
    	function getTravelXmlAsStoredId(travel:TravelExpenseVO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getTravelXmlAsStoredId_send():AsyncToken;
        
        /**
         * The getTravelXmlAsStoredId operation lastResult property
         */
        function get getTravelXmlAsStoredId_lastResult():String;
		/**
		 * @private
		 */
        function set getTravelXmlAsStoredId_lastResult(lastResult:String):void;
       /**
        * Add a listener for the getTravelXmlAsStoredId operation successful result event
        * @param The listener function
        */
       function addgetTravelXmlAsStoredIdEventListener(listener:Function):void;
       
       
        /**
         * The getTravelXmlAsStoredId operation request wrapper
         */
        function get getTravelXmlAsStoredId_request_var():GetTravelXmlAsStoredId_request;
        
        /**
         * @private
         */
        function set getTravelXmlAsStoredId_request_var(request:GetTravelXmlAsStoredId_request):void;
                   
    	//Stub functions for the removeDataStoredId operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param id
    	 * @return An AsyncToken
    	 */
    	function removeDataStoredId(id:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function removeDataStoredId_send():AsyncToken;
        
        /**
         * The removeDataStoredId operation lastResult property
         */
        function get removeDataStoredId_lastResult():Boolean;
		/**
		 * @private
		 */
        function set removeDataStoredId_lastResult(lastResult:Boolean):void;
       /**
        * Add a listener for the removeDataStoredId operation successful result event
        * @param The listener function
        */
       function addremoveDataStoredIdEventListener(listener:Function):void;
       
       
        /**
         * The removeDataStoredId operation request wrapper
         */
        function get removeDataStoredId_request_var():RemoveDataStoredId_request;
        
        /**
         * @private
         */
        function set removeDataStoredId_request_var(request:RemoveDataStoredId_request):void;
                   
    	//Stub functions for the getTravelObjectFromXml operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param xmlFileBytes
    	 * @return An AsyncToken
    	 */
    	function getTravelObjectFromXml(xmlFileBytes:flash.utils.ByteArray):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getTravelObjectFromXml_send():AsyncToken;
        
        /**
         * The getTravelObjectFromXml operation lastResult property
         */
        function get getTravelObjectFromXml_lastResult():TravelExpenseVO;
		/**
		 * @private
		 */
        function set getTravelObjectFromXml_lastResult(lastResult:TravelExpenseVO):void;
       /**
        * Add a listener for the getTravelObjectFromXml operation successful result event
        * @param The listener function
        */
       function addgetTravelObjectFromXmlEventListener(listener:Function):void;
       
       
        /**
         * The getTravelObjectFromXml operation request wrapper
         */
        function get getTravelObjectFromXml_request_var():GetTravelObjectFromXml_request;
        
        /**
         * @private
         */
        function set getTravelObjectFromXml_request_var(request:GetTravelObjectFromXml_request):void;
                   
    	//Stub functions for the getTravelObjectFromXmlAsStoredId operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param id
    	 * @return An AsyncToken
    	 */
    	function getTravelObjectFromXmlAsStoredId(id:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getTravelObjectFromXmlAsStoredId_send():AsyncToken;
        
        /**
         * The getTravelObjectFromXmlAsStoredId operation lastResult property
         */
        function get getTravelObjectFromXmlAsStoredId_lastResult():TravelExpenseVO;
		/**
		 * @private
		 */
        function set getTravelObjectFromXmlAsStoredId_lastResult(lastResult:TravelExpenseVO):void;
       /**
        * Add a listener for the getTravelObjectFromXmlAsStoredId operation successful result event
        * @param The listener function
        */
       function addgetTravelObjectFromXmlAsStoredIdEventListener(listener:Function):void;
       
       
        /**
         * The getTravelObjectFromXmlAsStoredId operation request wrapper
         */
        function get getTravelObjectFromXmlAsStoredId_request_var():GetTravelObjectFromXmlAsStoredId_request;
        
        /**
         * @private
         */
        function set getTravelObjectFromXmlAsStoredId_request_var(request:GetTravelObjectFromXmlAsStoredId_request):void;
                   
    	//Stub functions for the RunTestAndGetId operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function runTestAndGetId():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function runTestAndGetId_send():AsyncToken;
        
        /**
         * The runTestAndGetId operation lastResult property
         */
        function get runTestAndGetId_lastResult():String;
		/**
		 * @private
		 */
        function set runTestAndGetId_lastResult(lastResult:String):void;
       /**
        * Add a listener for the runTestAndGetId operation successful result event
        * @param The listener function
        */
       function addrunTestAndGetIdEventListener(listener:Function):void;
       
       
        /**
         * Get access to the underlying web service that the stub uses to communicate with the server
         * @return The base service that the facade implements
         */
        function getWebService():BaseTravelExpense;
	}
}