/**
 * TravelAccomodationVO.as
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
    
	public class TravelAccomodationVO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function TravelAccomodationVO() {}
            
		public var type:Number;
		public var name:String;
		public var adress:String;
		public var country:String;
		public var city:String;
		public var fromdate:Date;
		public var todate:Date;
		public var breakfast_inluded:Number;
		public var cost:webservices.travelexpense.pdf.CostVO;
		public var actual_cost:webservices.travelexpense.pdf.CostVO;
	}
}