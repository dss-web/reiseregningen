<?xml version="1.0" encoding="UTF-8"?><wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:tns="http://makingwaves.no/travelExp/" targetNamespace="http://makingwaves.no/travelExp/">
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://makingwaves.no/travelExp/">
      <s:element name="GetVersion">
        <s:complexType/>
      </s:element>
      <s:element name="GetVersionResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="GetVersionResult" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="getTravelPdf">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="travel" type="tns:TravelExpenseVO"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="TravelExpenseVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="personalinfo" type="tns:PersonalInfoVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="travel" type="tns:TravelVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="specificationList" type="tns:ArrayOfTravelSpecificationVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="accomodationList" type="tns:ArrayOfTravelAccomodationVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="travelAdvanceList" type="tns:ArrayOfTravelAdvanceVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="travelOutlayList" type="tns:ArrayOfTravelOutlayVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="travelDeductionList" type="tns:ArrayOfTravelDeductionVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="travelCommentList" type="tns:ArrayOfTravelCommentVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="PersonalInfoVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="socialsecuritynumber" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="firstname" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="lastname" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="adress" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="zip" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="postoffice" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="jobtitle" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="account" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="workplace" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="department" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="domicialname" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="domicialnum" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="location" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="travel_type" type="s:double"/>
          <s:element maxOccurs="1" minOccurs="1" name="travel_cause" type="s:double"/>
          <s:element maxOccurs="1" minOccurs="0" name="travel_cause_other" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="travel_date_out" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="travel_time_out" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="travel_date_in" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="travel_time_in" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelSpecificationVO">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelSpecificationVO" nillable="true" type="tns:TravelSpecificationVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelSpecificationVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="transportation_type" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="from_destination" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="from_date" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="from_country" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="from_city" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="to_destination" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="to_date" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="to_country" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="to_city" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="is_travel_start" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="1" name="is_travel_continious" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="1" name="is_travel_end" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="0" name="specification_aggregate" type="tns:AnySpecificationAggregateVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="cost" type="tns:CostVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="AnySpecificationAggregateVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="ticket_specification" type="tns:TicketSpecificationVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="car_specification" type="tns:CarSpecificationVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="motorboat_specification" type="tns:MotorboatSpecificationVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="motorcycle_specification" type="tns:MotorcycleSpecificationVO"/>
          <s:element maxOccurs="1" minOccurs="0" name="other_specification" type="tns:OtherSpecificationVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TicketSpecificationVO">
        <s:complexContent mixed="false">
          <s:extension base="tns:SpecificationVO">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="0" name="cost" type="tns:CostVO"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="SpecificationVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="type" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="CommonSpecificationVO">
        <s:complexContent mixed="false">
          <s:extension base="tns:SpecificationVO">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="distance" type="s:double"/>
              <s:element maxOccurs="1" minOccurs="1" name="passengers" type="s:double"/>
              <s:element maxOccurs="1" minOccurs="1" name="rate" type="s:double"/>
              <s:element maxOccurs="1" minOccurs="0" name="cost" type="tns:CostVO"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="CostVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="1" name="cost" type="s:double"/>
          <s:element maxOccurs="1" minOccurs="0" name="cost_currency" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="cost_currency_rate" type="s:double"/>
          <s:element maxOccurs="1" minOccurs="0" name="local_cost" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="OtherSpecificationVO">
        <s:complexContent mixed="false">
          <s:extension base="tns:CommonSpecificationVO">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="other_type" type="s:double"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="MotorcycleSpecificationVO">
        <s:complexContent mixed="false">
          <s:extension base="tns:CommonSpecificationVO">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="motorcycle_type" type="s:double"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="MotorboatSpecificationVO">
        <s:complexContent mixed="false">
          <s:extension base="tns:CommonSpecificationVO">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="motorboat_type" type="s:double"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="CarSpecificationVO">
        <s:complexContent mixed="false">
          <s:extension base="tns:CommonSpecificationVO">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="distance_calender" type="s:double"/>
              <s:element maxOccurs="1" minOccurs="1" name="distance_forestroad" type="s:double"/>
              <s:element maxOccurs="1" minOccurs="1" name="additional_trailer" type="s:boolean"/>
              <s:element maxOccurs="1" minOccurs="1" name="additional_workplace" type="s:boolean"/>
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
          <s:element maxOccurs="1" minOccurs="1" name="type" type="s:double"/>
          <s:element maxOccurs="1" minOccurs="0" name="name" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="adress" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="country" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="city" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="fromdate" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="1" name="todate" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="1" name="breakfast_inluded" type="s:double"/>
          <s:element maxOccurs="1" minOccurs="0" name="cost" type="tns:CostVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelAdvanceVO">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelAdvanceVO" nillable="true" type="tns:TravelAdvanceVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelAdvanceVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="1" name="date" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="location" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="cost" type="s:double"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelOutlayVO">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelOutlayVO" nillable="true" type="tns:TravelOutlayVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelOutlayVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="1" name="date" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="specification" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="cost" type="tns:CostVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelDeductionVO">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelDeductionVO" nillable="true" type="tns:TravelDeductionVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelDeductionVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="1" name="date" nillable="true" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="1" name="breakfast" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="1" name="lunch" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="1" name="dinner" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="0" name="cost" type="tns:CostVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelCommentVO">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelCommentVO" nillable="true" type="tns:TravelCommentVO"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelCommentVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="comment" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:element name="getTravelPdfResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getTravelPdfResult" type="tns:TravelReportDocumentVO"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="TravelReportDocumentVO">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="PdfFileBytes" type="s:base64Binary"/>
        </s:sequence>
      </s:complexType>
      <s:element name="getTravelPdfAsStoredId">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="travel" type="tns:TravelExpenseVO"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="getTravelPdfAsStoredIdResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getTravelPdfAsStoredIdResult" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="getTravelXmlAsStoredId">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="travel" type="tns:TravelExpenseVO"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="getTravelXmlAsStoredIdResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getTravelXmlAsStoredIdResult" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="removeDataStoredId">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="id" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="removeDataStoredIdResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="1" name="removeDataStoredIdResult" type="s:boolean"/>
          </s:sequence>
        </s:complexType>
      </s:element>
    </s:schema>
  </wsdl:types>
  <wsdl:message name="getTravelPdfAsStoredIdSoapIn">
    <wsdl:part element="tns:getTravelPdfAsStoredId" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getTravelPdfSoapOut">
    <wsdl:part element="tns:getTravelPdfResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getTravelPdfAsStoredIdSoapOut">
    <wsdl:part element="tns:getTravelPdfAsStoredIdResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="GetVersionSoapOut">
    <wsdl:part element="tns:GetVersionResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="removeDataStoredIdSoapOut">
    <wsdl:part element="tns:removeDataStoredIdResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getTravelXmlAsStoredIdSoapIn">
    <wsdl:part element="tns:getTravelXmlAsStoredId" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getTravelXmlAsStoredIdSoapOut">
    <wsdl:part element="tns:getTravelXmlAsStoredIdResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="GetVersionSoapIn">
    <wsdl:part element="tns:GetVersion" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="removeDataStoredIdSoapIn">
    <wsdl:part element="tns:removeDataStoredId" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getTravelPdfSoapIn">
    <wsdl:part element="tns:getTravelPdf" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:portType name="TravelExpenseSoap">
    <wsdl:operation name="GetVersion">
<wsdl:documentation>Test if webservice is working, and get current version of the assembly</wsdl:documentation>
      <wsdl:input message="tns:GetVersionSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:GetVersionSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdf">
<wsdl:documentation>Generates PDF file from specified data structures. Returns array of bytes (wrapped in other structure).</wsdl:documentation>
      <wsdl:input message="tns:getTravelPdfSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getTravelPdfSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdfAsStoredId">
<wsdl:documentation>Stores specified 'Travel' strucure at server-side and returns its unique identifier. Use GetStoredData.aspx?id=... page to retrieve PDF file.</wsdl:documentation>
      <wsdl:input message="tns:getTravelPdfAsStoredIdSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getTravelPdfAsStoredIdSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelXmlAsStoredId">
<wsdl:documentation>Stores specified 'Travel' structure as serialized Xml and returns unique identifier. Use GetStoredData.aspx?id=... page to retrieve XML file.</wsdl:documentation>
      <wsdl:input message="tns:getTravelXmlAsStoredIdSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getTravelXmlAsStoredIdSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="removeDataStoredId">
<wsdl:documentation>Clean server-side memory from old, no-more required data. Specify identifier returned by 'getTravelPdfAsStoredId' or other Data-Store method</wsdl:documentation>
      <wsdl:input message="tns:removeDataStoredIdSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:removeDataStoredIdSoapOut">
    </wsdl:output>
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="TravelExpenseSoap12" type="tns:TravelExpenseSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="GetVersion">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/GetVersion" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdf">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/getTravelPdf" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdfAsStoredId">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/getTravelPdfAsStoredId" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelXmlAsStoredId">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/getTravelXmlAsStoredId" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="removeDataStoredId">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/removeDataStoredId" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="TravelExpenseSoap" type="tns:TravelExpenseSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="GetVersion">
      <soap:operation soapAction="http://makingwaves.no/travelExp/GetVersion" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdf">
      <soap:operation soapAction="http://makingwaves.no/travelExp/getTravelPdf" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdfAsStoredId">
      <soap:operation soapAction="http://makingwaves.no/travelExp/getTravelPdfAsStoredId" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelXmlAsStoredId">
      <soap:operation soapAction="http://makingwaves.no/travelExp/getTravelXmlAsStoredId" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="removeDataStoredId">
      <soap:operation soapAction="http://makingwaves.no/travelExp/removeDataStoredId" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="TravelExpense">
    <wsdl:port binding="tns:TravelExpenseSoap12" name="TravelExpenseSoap12">
      <soap12:address location="http://10.130.1.76/TravelExpWS/TravelExpense.asmx"/>
    </wsdl:port>
    <wsdl:port binding="tns:TravelExpenseSoap" name="TravelExpenseSoap">
      <soap:address location="http://10.130.1.76/TravelExpWS/TravelExpense.asmx"/>
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>