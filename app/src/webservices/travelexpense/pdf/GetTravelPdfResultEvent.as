/**
 * GetTravelPdfResultEvent.as
 * This file was auto-generated from WSDL
 * Any change made to this file will be overwritten when the code is re-generated.
*/
package webservices.travelexpense.pdf
{
    import mx.utils.ObjectProxy;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import mx.rpc.soap.types.*;
    /**
     * Typed event handler for the result of the operation
     */
    
    public class GetTravelPdfResultEvent extends Event
    {
        /**
         * The event type value
         */
        public static var GetTravelPdf_RESULT:String="GetTravelPdf_result";
        /**
         * Constructor for the new event type
         */
        public function GetTravelPdfResultEvent()
        {
            super(GetTravelPdf_RESULT,false,false);
        }
        
        private var _headers:Object;
        private var _result:TravelReportDocumentVO;
         public function get result():TravelReportDocumentVO
        {
            return _result;
        }
        
        public function set result(value:TravelReportDocumentVO):void
        {
            _result = value;
        }

        public function get headers():Object
	    {
            return _headers;
	    }
			
	    public function set headers(value:Object):void
	    {
            _headers = value;
	    }
    }
}