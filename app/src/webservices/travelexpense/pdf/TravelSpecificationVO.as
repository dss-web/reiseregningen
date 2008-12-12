/**
 * TravelSpecificationVO.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */

package webservices.travelexpense.pdf{
    import mx.utils.ObjectProxy;
    import flash.utils.ByteArray;
    import mx.rpc.soap.types.*;
    /**
     * Wrapper class for a operation required type
     */
    
    public class TravelSpecificationVO
    {
        /**
         * Constructor, initializes the type class
         */
public function TravelSpecificationVO() {}
                
                   public var transportation_type:String;
                   public var from_destination:String;
                   public var from_date:Date;
                   public var from_country:String;
                   public var from_city:String;
                   public var to_destination:String;
                   public var to_date:Date;
                   public var to_country:String;
                   public var to_city:String;
                   public var is_travel_start:Boolean;
                   public var is_travel_continious:Boolean;
                   public var is_travel_end:Boolean;
                   public var specification_aggregate:webservices.travelexpense.pdf.AnySpecificationAggregateVO;
                   public var cost:webservices.travelexpense.pdf.CostVO;
                   public var from_timezone:Number;
                   public var to_timezone:Number;
           	}
      	 }