<?xml version="1.0" encoding="UTF-8"?><wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:tns="http://makingwaves.no/travelExp/" targetNamespace="http://makingwaves.no/travelExp/">
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://makingwaves.no/travelExp/">
      <s:element name="HelloWorld">
        <s:complexType/>
      </s:element>
      <s:element name="HelloWorldResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="HelloWorldResult" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="getTravelPdf">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="travel" type="tns:TravelExpense"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="TravelExpense">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="Personalinfo" type="tns:PersonalInfo"/>
          <s:element maxOccurs="1" minOccurs="0" name="Travel" type="tns:Travel"/>
          <s:element maxOccurs="1" minOccurs="0" name="SpecificationList" type="tns:ArrayOfTravelSpecification"/>
          <s:element maxOccurs="1" minOccurs="0" name="AccomodationList" type="tns:ArrayOfTravelAccomodation"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelAdvanceList" type="tns:ArrayOfTravelAdvance"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelOutlayList" type="tns:ArrayOfTravelOutlay"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelDeductionList" type="tns:ArrayOfTravelDeduction"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelCommentList" type="tns:ArrayOfTravelComment"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="PersonalInfo">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="SocialSecurityNumber" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="FirstName" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="LastName" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="Address" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="Zip" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="Postoffice" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="Account" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="Workplace" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="Department" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="DomicialName" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="DomicialNum" type="s:int"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="Travel">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="Location" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="TravelType" type="tns:TravelType"/>
          <s:element maxOccurs="1" minOccurs="1" name="TravelCause" type="tns:TravelCause"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelCauseOther" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="TravelDateOut" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelTimeOut" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="TravelDateIn" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="TravelTimeIn" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:simpleType name="TravelType">
        <s:restriction base="s:string">
          <s:enumeration value="Domestic"/>
          <s:enumeration value="Abroad"/>
        </s:restriction>
      </s:simpleType>
      <s:simpleType name="TravelCause">
        <s:restriction base="s:string">
          <s:enumeration value="Business"/>
          <s:enumeration value="Course"/>
          <s:enumeration value="Other"/>
        </s:restriction>
      </s:simpleType>
      <s:complexType name="ArrayOfTravelSpecification">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelSpecification" nillable="true" type="tns:TravelSpecification"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelSpecification">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="TransportationType" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="FromLocation" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="FromDate" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="FromCountry" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="FromCity" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="ToLocation" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="ToDateTime" type="s:dateTime"/>
          <s:element maxOccurs="1" minOccurs="0" name="ToCountry" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="0" name="ToCity" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="IsTravelStart" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="1" name="IsTravelEnd" type="s:boolean"/>
          <s:element maxOccurs="1" minOccurs="0" name="Specification" type="tns:Specification"/>
          <s:element maxOccurs="1" minOccurs="0" name="Cost" type="tns:Cost"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="Specification"/>
      <s:complexType name="Cost"/>
      <s:complexType name="ArrayOfTravelAccomodation">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelAccomodation" nillable="true" type="tns:TravelAccomodation"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelAccomodation"/>
      <s:complexType name="ArrayOfTravelAdvance">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelAdvance" nillable="true" type="tns:TravelAdvance"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelAdvance">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="SomeField" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelOutlay">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelOutlay" nillable="true" type="tns:TravelOutlay"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelOutlay">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="SomeField" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelDeduction">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelDeduction" nillable="true" type="tns:TravelDeduction"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelDeduction">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="SomeField" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfTravelComment">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="TravelComment" nillable="true" type="tns:TravelComment"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="TravelComment">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="SomeField" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:element name="getTravelPdfResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getTravelPdfResult" type="tns:TravelReportDocument"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="TravelReportDocument">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="PdfFileBytes" type="s:base64Binary"/>
        </s:sequence>
      </s:complexType>
    </s:schema>
  </wsdl:types>
  <wsdl:message name="getTravelPdfSoapOut">
    <wsdl:part element="tns:getTravelPdfResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="HelloWorldSoapIn">
    <wsdl:part element="tns:HelloWorld" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getTravelPdfSoapIn">
    <wsdl:part element="tns:getTravelPdf" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="HelloWorldSoapOut">
    <wsdl:part element="tns:HelloWorldResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:portType name="DocumentsSoap">
    <wsdl:operation name="HelloWorld">
      <wsdl:input message="tns:HelloWorldSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:HelloWorldSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getTravelPdf">
      <wsdl:input message="tns:getTravelPdfSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getTravelPdfSoapOut">
    </wsdl:output>
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="DocumentsSoap" type="tns:DocumentsSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="HelloWorld">
      <soap:operation soapAction="http://makingwaves.no/travelExp/HelloWorld" style="document"/>
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
  </wsdl:binding>
  <wsdl:binding name="DocumentsSoap12" type="tns:DocumentsSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="HelloWorld">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/HelloWorld" style="document"/>
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
  </wsdl:binding>
  <wsdl:service name="Documents">
    <wsdl:port binding="tns:DocumentsSoap12" name="DocumentsSoap12">
      <soap12:address location="http://10.130.1.161/TravelExpWS/Documents.asmx"/>
    </wsdl:port>
    <wsdl:port binding="tns:DocumentsSoap" name="DocumentsSoap">
      <soap:address location="http://10.130.1.161/TravelExpWS/Documents.asmx"/>
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>