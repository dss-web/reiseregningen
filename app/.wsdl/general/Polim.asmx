<?xml version="1.0" encoding="UTF-8"?><wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:tns="http://tempaaauri.org/" targetNamespace="http://tempaaauri.org/">
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://tempaaauri.org/">
      <s:element name="HelloWorld2">
        <s:complexType/>
      </s:element>
      <s:element name="HelloWorld2Response">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="HelloWorld2Result" type="s:string"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="DoubleValues">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="dataValues" type="tns:ArrayOfClassBase"/>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:complexType name="ArrayOfClassBase">
        <s:sequence>
          <s:element maxOccurs="unbounded" minOccurs="0" name="ClassBase" nillable="true" type="tns:ClassBase"/>
        </s:sequence>
      </s:complexType>
      <s:complexType abstract="true" name="ClassBase">
        <s:sequence>
          <s:element maxOccurs="1" minOccurs="1" name="baseValue" type="s:int"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ClassA">
        <s:complexContent mixed="false">
          <s:extension base="tns:ClassBase">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="0" name="valueA" type="s:string"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="ClassC">
        <s:complexContent mixed="false">
          <s:extension base="tns:ClassBase">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="valueC" type="s:int"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:complexType name="ClassB">
        <s:complexContent mixed="false">
          <s:extension base="tns:ClassBase">
            <s:sequence>
              <s:element maxOccurs="1" minOccurs="1" name="valueB" type="s:double"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      <s:element name="DoubleValuesResponse">
        <s:complexType>
          <s:sequence>
            <s:element maxOccurs="1" minOccurs="0" name="DoubleValuesResult" type="tns:ArrayOfClassBase"/>
          </s:sequence>
        </s:complexType>
      </s:element>
    </s:schema>
  </wsdl:types>
  <wsdl:message name="HelloWorld2SoapOut">
    <wsdl:part element="tns:HelloWorld2Response" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="HelloWorld2SoapIn">
    <wsdl:part element="tns:HelloWorld2" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="DoubleValuesSoapIn">
    <wsdl:part element="tns:DoubleValues" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="DoubleValuesSoapOut">
    <wsdl:part element="tns:DoubleValuesResponse" name="parameters">
    </wsdl:part>
  </wsdl:message>
  <wsdl:portType name="PolimSoap">
    <wsdl:operation name="HelloWorld2">
      <wsdl:input message="tns:HelloWorld2SoapIn">
    </wsdl:input>
      <wsdl:output message="tns:HelloWorld2SoapOut">
    </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DoubleValues">
<wsdl:documentation>Testing derived classes</wsdl:documentation>
      <wsdl:input message="tns:DoubleValuesSoapIn">
    </wsdl:input>
      <wsdl:output message="tns:DoubleValuesSoapOut">
    </wsdl:output>
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="PolimSoap12" type="tns:PolimSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="HelloWorld2">
      <soap12:operation soapAction="http://tempaaauri.org/HelloWorld2" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DoubleValues">
      <soap12:operation soapAction="http://tempaaauri.org/DoubleValues" style="document"/>
      <wsdl:input>
        <soap12:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="PolimSoap" type="tns:PolimSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="HelloWorld2">
      <soap:operation soapAction="http://tempaaauri.org/HelloWorld2" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="DoubleValues">
      <soap:operation soapAction="http://tempaaauri.org/DoubleValues" style="document"/>
      <wsdl:input>
        <soap:body use="literal"/>
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal"/>
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="Polim">
    <wsdl:port binding="tns:PolimSoap12" name="PolimSoap12">
      <soap12:address location="http://10.130.1.161/TravelExpWSTests/trypolim/Polim.asmx"/>
    </wsdl:port>
    <wsdl:port binding="tns:PolimSoap" name="PolimSoap">
      <soap:address location="http://10.130.1.161/TravelExpWSTests/trypolim/Polim.asmx"/>
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>