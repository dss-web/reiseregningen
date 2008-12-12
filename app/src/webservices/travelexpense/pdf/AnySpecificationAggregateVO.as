/**
 * AnySpecificationAggregateVO.as
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
    
    public class AnySpecificationAggregateVO
    {
        /**
         * Constructor, initializes the type class
         */
public function AnySpecificationAggregateVO() {}
                
                   public var ticket_specification:webservices.travelexpense.pdf.TicketSpecificationVO;
                   public var car_specification:webservices.travelexpense.pdf.CarSpecificationVO;
                   public var motorboat_specification:webservices.travelexpense.pdf.MotorboatSpecificationVO;
                   public var motorcycle_specification:webservices.travelexpense.pdf.MotorcycleSpecificationVO;
                   public var other_specification:webservices.travelexpense.pdf.OtherSpecificationVO;
                   public var which_specification_used:Number;
           	}
      	 }