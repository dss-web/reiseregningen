package webservices.travelexpense.pdf
{
	 import mx.rpc.xml.Schema
	 public class BaseTravelExpenseSchema
	{
		 public var schemas:Array = new Array();
		 public var targetNamespaces:Array = new Array();
		 public function BaseTravelExpenseSchema():void
		{
			 var xsdXML0:XML = <s:schema xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:tns="http://makingwaves.no/travelExp/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" attributeFormDefault="unqualified" elementFormDefault="qualified" targetNamespace="http://makingwaves.no/travelExp/">
    <s:element name="GetVersion">
        <s:complexType/>
    </s:element>
    <s:element name="GetVersionResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="GetVersionResult" type="s:string"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelPdf">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="travel" type="tns:TravelExpenseVO"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:complexType name="TravelExpenseVO">
        <s:sequence>
            <s:element minOccurs="0" name="personalinfo" type="tns:PersonalInfoVO"/>
            <s:element minOccurs="0" name="travel" type="tns:TravelVO"/>
            <s:element minOccurs="0" name="travelAllowances" type="tns:TravelAllowanceVO"/>
            <s:element minOccurs="0" name="specificationList" type="tns:ArrayOfTravelSpecificationVO"/>
            <s:element minOccurs="0" name="accomodationList" type="tns:ArrayOfTravelAccomodationVO"/>
            <s:element minOccurs="0" name="travelAdvanceList" type="tns:ArrayOfTravelAdvanceVO"/>
            <s:element minOccurs="0" name="travelOutlayList" type="tns:ArrayOfTravelOutlayVO"/>
            <s:element minOccurs="0" name="travelDeductionList" type="tns:ArrayOfTravelDeductionVO"/>
            <s:element minOccurs="0" name="travelCommentList" type="tns:ArrayOfTravelCommentVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="PersonalInfoVO">
        <s:sequence>
            <s:element minOccurs="0" name="socialsecuritynumber" type="s:string"/>
            <s:element minOccurs="0" name="firstname" type="s:string"/>
            <s:element minOccurs="0" name="lastname" type="s:string"/>
            <s:element minOccurs="0" name="adress" type="s:string"/>
            <s:element minOccurs="0" name="zip" type="s:string"/>
            <s:element minOccurs="0" name="postoffice" type="s:string"/>
            <s:element minOccurs="0" name="jobtitle" type="s:string"/>
            <s:element minOccurs="0" name="account" type="s:string"/>
            <s:element minOccurs="0" name="workplace" type="s:string"/>
            <s:element minOccurs="0" name="department" type="s:string"/>
            <s:element minOccurs="0" name="domicialname" type="s:string"/>
            <s:element minOccurs="0" name="domicialnum" type="s:string"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelVO">
        <s:sequence>
            <s:element minOccurs="0" name="location" type="s:string"/>
            <s:element name="travel_type" type="s:double"/>
            <s:element name="travel_cause" type="s:double"/>
            <s:element minOccurs="0" name="travel_cause_other" type="s:string"/>
            <s:element name="travel_date_out" nillable="true" type="s:dateTime"/>
            <s:element minOccurs="0" name="travel_time_out" type="s:string"/>
            <s:element name="travel_date_in" nillable="true" type="s:dateTime"/>
            <s:element minOccurs="0" name="travel_time_in" type="s:string"/>
            <s:element minOccurs="0" name="travelNumber" type="s:string"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelAllowanceVO">
        <s:sequence>
            <s:element minOccurs="0" name="adm_allowance" type="tns:RateVO"/>
            <s:element name="accomodation" type="s:boolean"/>
            <s:element name="domestic" type="s:boolean"/>
            <s:element minOccurs="0" name="allowance" type="tns:RateVO"/>
            <s:element minOccurs="0" name="allowance_international" type="tns:ArrayOfRateVO"/>
            <s:element minOccurs="0" name="allowance_other" type="tns:ArrayOfRateVO"/>
            <s:element minOccurs="0" name="nighttariff_domestic" type="tns:RateVO"/>
            <s:element minOccurs="0" name="nighttariff_domestic_hotel" type="tns:RateVO"/>
            <s:element minOccurs="0" name="nighttariff_international" type="tns:ArrayOfRateVO"/>
            <s:element minOccurs="0" name="allowance_28days" type="tns:RateVO"/>
            <s:element minOccurs="0" name="nighttariff_28days" type="tns:RateVO"/>
            <s:element minOccurs="0" name="car_distance1" type="tns:RateVO"/>
            <s:element minOccurs="0" name="car_distance2" type="tns:RateVO"/>
            <s:element minOccurs="0" name="car_passengers" type="tns:RateVO"/>
            <s:element minOccurs="0" name="car_otherrates" type="tns:RateVO"/>
            <s:element name="netamount" type="s:double"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="RateVO">
        <s:sequence>
            <s:element name="num" type="s:double"/>
            <s:element name="rate" type="s:double"/>
            <s:element name="amount" type="s:double"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="ArrayOfRateVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="RateVO" nillable="true" type="tns:RateVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="ArrayOfTravelSpecificationVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="TravelSpecificationVO" nillable="true" type="tns:TravelSpecificationVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelSpecificationVO">
        <s:sequence>
            <s:element minOccurs="0" name="transportation_type" type="s:string"/>
            <s:element minOccurs="0" name="from_destination" type="s:string"/>
            <s:element name="from_date" nillable="true" type="s:dateTime"/>
            <s:element minOccurs="0" name="from_country" type="s:string"/>
            <s:element minOccurs="0" name="from_city" type="s:string"/>
            <s:element minOccurs="0" name="to_destination" type="s:string"/>
            <s:element name="to_date" nillable="true" type="s:dateTime"/>
            <s:element minOccurs="0" name="to_country" type="s:string"/>
            <s:element minOccurs="0" name="to_city" type="s:string"/>
            <s:element name="is_travel_start" type="s:boolean"/>
            <s:element name="is_travel_continious" type="s:boolean"/>
            <s:element name="is_travel_end" type="s:boolean"/>
            <s:element minOccurs="0" name="specification_aggregate" type="tns:AnySpecificationAggregateVO"/>
            <s:element minOccurs="0" name="cost" type="tns:CostVO"/>
            <s:element name="from_timezone" type="s:double"/>
            <s:element name="to_timezone" type="s:double"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="AnySpecificationAggregateVO">
        <s:sequence>
            <s:element minOccurs="0" name="ticket_specification" type="tns:TicketSpecificationVO"/>
            <s:element minOccurs="0" name="car_specification" type="tns:CarSpecificationVO"/>
            <s:element minOccurs="0" name="motorboat_specification" type="tns:MotorboatSpecificationVO"/>
            <s:element minOccurs="0" name="motorcycle_specification" type="tns:MotorcycleSpecificationVO"/>
            <s:element minOccurs="0" name="other_specification" type="tns:OtherSpecificationVO"/>
            <s:element name="which_specification_used" type="s:double"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TicketSpecificationVO">
        <s:complexContent>
            <s:extension base="tns:SpecificationVO">
                <s:sequence>
                    <s:element minOccurs="0" name="cost" type="tns:CostVO"/>
                </s:sequence>
            </s:extension>
        </s:complexContent>
    </s:complexType>
    <s:complexType name="SpecificationVO">
        <s:sequence>
            <s:element minOccurs="0" name="type" type="s:string"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="CommonSpecificationVO">
        <s:complexContent>
            <s:extension base="tns:SpecificationVO">
                <s:sequence>
                    <s:element name="distance" type="s:double"/>
                    <s:element name="passengers" type="s:double"/>
                    <s:element name="rate" type="s:double"/>
                    <s:element minOccurs="0" name="cost" type="tns:CostVO"/>
                </s:sequence>
            </s:extension>
        </s:complexContent>
    </s:complexType>
    <s:complexType name="CostVO">
        <s:sequence>
            <s:element name="cost" type="s:double"/>
            <s:element minOccurs="0" name="cost_currency" type="s:string"/>
            <s:element name="cost_currency_rate" type="s:double"/>
            <s:element minOccurs="0" name="local_cost" type="s:string"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="OtherSpecificationVO">
        <s:complexContent>
            <s:extension base="tns:CommonSpecificationVO">
                <s:sequence>
                    <s:element name="other_type" type="s:double"/>
                </s:sequence>
            </s:extension>
        </s:complexContent>
    </s:complexType>
    <s:complexType name="MotorcycleSpecificationVO">
        <s:complexContent>
            <s:extension base="tns:CommonSpecificationVO">
                <s:sequence>
                    <s:element name="motorcycle_type" type="s:double"/>
                </s:sequence>
            </s:extension>
        </s:complexContent>
    </s:complexType>
    <s:complexType name="MotorboatSpecificationVO">
        <s:complexContent>
            <s:extension base="tns:CommonSpecificationVO">
                <s:sequence>
                    <s:element name="motorboat_type" type="s:double"/>
                </s:sequence>
            </s:extension>
        </s:complexContent>
    </s:complexType>
    <s:complexType name="CarSpecificationVO">
        <s:complexContent>
            <s:extension base="tns:CommonSpecificationVO">
                <s:sequence>
                    <s:element name="distance_calender" type="s:double"/>
                    <s:element name="distance_forestroad" type="s:double"/>
                    <s:element name="additional_trailer" type="s:boolean"/>
                    <s:element name="additional_workplace" type="s:boolean"/>
                </s:sequence>
            </s:extension>
        </s:complexContent>
    </s:complexType>
    <s:complexType name="ArrayOfTravelAccomodationVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="TravelAccomodationVO" nillable="true" type="tns:TravelAccomodationVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelAccomodationVO">
        <s:sequence>
            <s:element name="type" type="s:double"/>
            <s:element minOccurs="0" name="name" type="s:string"/>
            <s:element minOccurs="0" name="adress" type="s:string"/>
            <s:element minOccurs="0" name="country" type="s:string"/>
            <s:element minOccurs="0" name="city" type="s:string"/>
            <s:element name="fromdate" nillable="true" type="s:dateTime"/>
            <s:element name="todate" nillable="true" type="s:dateTime"/>
            <s:element name="breakfast_inluded" type="s:double"/>
            <s:element minOccurs="0" name="cost" type="tns:CostVO"/>
            <s:element minOccurs="0" name="actual_cost" type="tns:CostVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="ArrayOfTravelAdvanceVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="TravelAdvanceVO" nillable="true" type="tns:TravelAdvanceVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelAdvanceVO">
        <s:sequence>
            <s:element name="date" nillable="true" type="s:dateTime"/>
            <s:element minOccurs="0" name="location" type="s:string"/>
            <s:element name="cost" type="s:double"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="ArrayOfTravelOutlayVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="TravelOutlayVO" nillable="true" type="tns:TravelOutlayVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelOutlayVO">
        <s:sequence>
            <s:element name="date" nillable="true" type="s:dateTime"/>
            <s:element minOccurs="0" name="specification" type="s:string"/>
            <s:element minOccurs="0" name="cost" type="tns:CostVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="ArrayOfTravelDeductionVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="TravelDeductionVO" nillable="true" type="tns:TravelDeductionVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelDeductionVO">
        <s:sequence>
            <s:element name="date" nillable="true" type="s:dateTime"/>
            <s:element name="breakfast" type="s:boolean"/>
            <s:element name="lunch" type="s:boolean"/>
            <s:element name="dinner" type="s:boolean"/>
            <s:element minOccurs="0" name="cost" type="tns:CostVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="ArrayOfTravelCommentVO">
        <s:sequence>
            <s:element maxOccurs="unbounded" minOccurs="0" name="TravelCommentVO" nillable="true" type="tns:TravelCommentVO"/>
        </s:sequence>
    </s:complexType>
    <s:complexType name="TravelCommentVO">
        <s:sequence>
            <s:element minOccurs="0" name="comment" type="s:string"/>
        </s:sequence>
    </s:complexType>
    <s:element name="getTravelPdfResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="getTravelPdfResult" type="tns:TravelReportDocumentVO"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:complexType name="TravelReportDocumentVO">
        <s:sequence>
            <s:element minOccurs="0" name="PdfFileBytes" type="s:base64Binary"/>
        </s:sequence>
    </s:complexType>
    <s:element name="getTravelPdfAsStoredId">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="travel" type="tns:TravelExpenseVO"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelPdfAsStoredIdResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="getTravelPdfAsStoredIdResult" type="s:string"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelXmlAsStoredId">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="travel" type="tns:TravelExpenseVO"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelXmlAsStoredIdResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="getTravelXmlAsStoredIdResult" type="s:string"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="removeDataStoredId">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="id" type="s:string"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="removeDataStoredIdResponse">
        <s:complexType>
            <s:sequence>
                <s:element name="removeDataStoredIdResult" type="s:boolean"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelObjectFromXml">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="xmlFileBytes" type="s:base64Binary"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelObjectFromXmlResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="getTravelObjectFromXmlResult" type="tns:TravelExpenseVO"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelObjectFromXmlAsStoredId">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="id" type="s:string"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="getTravelObjectFromXmlAsStoredIdResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="getTravelObjectFromXmlAsStoredIdResult" type="tns:TravelExpenseVO"/>
            </s:sequence>
        </s:complexType>
    </s:element>
    <s:element name="RunTestAndGetId">
        <s:complexType/>
    </s:element>
    <s:element name="RunTestAndGetIdResponse">
        <s:complexType>
            <s:sequence>
                <s:element minOccurs="0" name="RunTestAndGetIdResult" type="s:string"/>
            </s:sequence>
        </s:complexType>
    </s:element>
</s:schema>
;
			 var xsdSchema0:Schema = new Schema(xsdXML0);
			schemas.push(xsdSchema0);
			targetNamespaces.push(new Namespace('','http://makingwaves.no/travelExp/'));
		}
	}
}