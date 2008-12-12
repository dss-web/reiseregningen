<?xml version="1.0" encoding="UTF-8"?><wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:tns="http://makingwaves.no/travelExp/" targetNamespace="http://makingwaves.no/travelExp/">
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://makingwaves.no/travelExp/">
      <s:element name="getVersion">
        <s:complexType/>
      </s:element>
      <s:element name="getVersionResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getVersionResult" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="getRates">
        <s:complexType/>
      </s:element>
      <s:element name="getRatesResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getRatesResult" type="tns:RatesReisereg"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="RatesReisereg">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="1" name="adm_refund" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_less_5_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_5_to_9_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_9_to_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_above_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="international_6_to_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="international_above_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_overnight_8_to_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_overnight_more_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="international_overnight" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="domestic_overnight_unauthorized" type="s:decimal"/>
        </s:sequence>
      </s:complexType>
      <s:element name="getRatesAbroad">
        <s:complexType/>
      </s:element>
      <s:element name="getRatesAbroadResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="getRatesAbroadResult" type="tns:RatesForCountries"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="RatesForCountries">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="countries" type="tns:ArrayOfRatesForCountry"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfRatesForCountry">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="RatesForCountry" nillable="true" type="tns:RatesForCountry"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="RatesForCountry">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="0" name="countryName" type="s:string"/>
          <s:element maxOccurs="1" minOccurs="1" name="from_6_to_12_hours" type="s:decimal"/>
          <s:element maxOccurs="1" minOccurs="1" name="above_12_hours" type="s:decimal"/>
        </s:sequence>
      </s:complexType>
    </s:schema>
  </wsdl:types>
  <wsdl:message name="getRatesAbroadSoapOut">
    <wsdl:part element="tns:getRatesAbroadResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getVersionSoapIn">
    <wsdl:part element="tns:getVersion" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getRatesSoapOut">
    <wsdl:part element="tns:getRatesResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getRatesAbroadSoapIn">
    <wsdl:part element="tns:getRatesAbroad" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getRatesSoapIn">
    <wsdl:part element="tns:getRates" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getVersionSoapOut">
    <wsdl:part element="tns:getVersionResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:portType name="GovernCodesRatesSoap">
    <wsdl:operation name="getVersion">
      <wsdl:input message="tns:getVersionSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getVersionSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getRates">
      <wsdl:input message="tns:getRatesSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getRatesSoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getRatesAbroad">
      <wsdl:input message="tns:getRatesAbroadSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:getRatesAbroadSoapOut">
    </wsdl:output>
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="GovernCodesRatesSoap12" type="tns:GovernCodesRatesSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="getVersion">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/getVersion" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getRates">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/getRates" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getRatesAbroad">
      <soap12:operation soapAction="http://makingwaves.no/travelExp/getRatesAbroad" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="GovernCodesRatesSoap" type="tns:GovernCodesRatesSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="getVersion">
      <soap:operation soapAction="http://makingwaves.no/travelExp/getVersion" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getRates">
      <soap:operation soapAction="http://makingwaves.no/travelExp/getRates" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getRatesAbroad">
      <soap:operation soapAction="http://makingwaves.no/travelExp/getRatesAbroad" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="GovernCodesRates">
    <wsdl:port binding="tns:GovernCodesRatesSoap12" name="GovernCodesRatesSoap12">
      <soap12:address location="http://10.130.1.161/TravelExpWS/GovernCodesRates.asmx"/>
    </wsdl:port>
    <wsdl:port binding="tns:GovernCodesRatesSoap" name="GovernCodesRatesSoap">
      <soap:address location="http://10.130.1.161/TravelExpWS/GovernCodesRates.asmx"/>
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>