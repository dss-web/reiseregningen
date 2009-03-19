/**
 * TravelExpenseVO.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */

package webservices.travelexpense.pdf
{
	import mx.utils.ObjectProxy;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;
	/**
	 * Wrapper class for a operation required type
	 */
    
	public class TravelExpenseVO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function TravelExpenseVO() {}
            
		public var personalinfo:webservices.travelexpense.pdf.PersonalInfoVO;
		public var travel:webservices.travelexpense.pdf.TravelVO;
		public var travelAllowances:webservices.travelexpense.pdf.TravelAllowanceVO;
		public var specificationList:webservices.travelexpense.pdf.ArrayOfTravelSpecificationVO;
		public var accomodationList:webservices.travelexpense.pdf.ArrayOfTravelAccomodationVO;
		public var travelAdvanceList:webservices.travelexpense.pdf.ArrayOfTravelAdvanceVO;
		public var travelOutlayList:webservices.travelexpense.pdf.ArrayOfTravelOutlayVO;
		public var travelDeductionList:webservices.travelexpense.pdf.ArrayOfTravelDeductionVO;
		public var travelCommentList:webservices.travelexpense.pdf.ArrayOfTravelCommentVO;
	}
}