/**
 * TravelAllowanceVO.as
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
    
	public class TravelAllowanceVO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function TravelAllowanceVO() {}
            
		public var adm_allowance:webservices.travelexpense.pdf.RateVO;
		public var accomodation:Boolean;
		public var domestic:Boolean;
		public var allowance:webservices.travelexpense.pdf.RateVO;
		public var allowance_international:webservices.travelexpense.pdf.ArrayOfRateVO;
		public var allowance_other:webservices.travelexpense.pdf.ArrayOfRateVO;
		public var nighttariff_domestic:webservices.travelexpense.pdf.RateVO;
		public var nighttariff_domestic_hotel:webservices.travelexpense.pdf.RateVO;
		public var nighttariff_international:webservices.travelexpense.pdf.ArrayOfRateVO;
		public var allowance_28days:webservices.travelexpense.pdf.RateVO;
		public var nighttariff_28days:webservices.travelexpense.pdf.RateVO;
		public var car_distance1:webservices.travelexpense.pdf.RateVO;
		public var car_distance2:webservices.travelexpense.pdf.RateVO;
		public var car_passengers:webservices.travelexpense.pdf.RateVO;
		public var car_otherrates:webservices.travelexpense.pdf.RateVO;
		public var netamount:Number;
	}
}