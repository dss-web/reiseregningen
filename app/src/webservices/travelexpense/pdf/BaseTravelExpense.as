
/**
 * BaseTravelExpenseService.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package webservices.travelexpense.pdf{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.SOAPMessage;
	import mx.rpc.*;
	import mx.rpc.events.*;
	import mx.rpc.soap.*;
	import mx.rpc.soap.types.*;
	import mx.rpc.wsdl.*;
	import mx.rpc.xml.*;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	/**
	 * Base service implementation, extends the AbstractWebService and adds specific functionality for the selected WSDL
	 * It defines the options and properties for each of the WSDL's operations
	 */ 
	public class BaseTravelExpense extends AbstractWebService
    {
		private var results:Object;
		private var schemaMgr:SchemaManager;
		private var BaseTravelExpenseService:WSDLService;
		private var BaseTravelExpensePortType:WSDLPortType;
		private var BaseTravelExpenseBinding:WSDLBinding;
		private var BaseTravelExpensePort:WSDLPort;
		private var currentOperation:WSDLOperation;
		private var internal_schema:BaseTravelExpenseSchema;
		
		/**
		 * Constructor for the base service, initializes all of the WSDL's properties
		 * @param [Optional] The LCDS destination (if available) to use to contact the server
		 * @param [Optional] The URL to the WSDL end-point
		 */
		public function BaseTravelExpense(destination:String=null, rootURL:String=null)
		{
			super(destination, rootURL);
			if(destination == null)
			{
				//no destination available; must set it to go directly to the target
				this.useProxy = false;
			}
			else
			{
				//specific destination requested; must set proxying to true
				this.useProxy = true;
			}
			
			if(rootURL != null)
			{
				this.endpointURI = rootURL;
			} 
			else 
			{
				this.endpointURI = null;
			}
			internal_schema = new BaseTravelExpenseSchema();
			schemaMgr = new SchemaManager();
			for(var i:int;i<internal_schema.schemas.length;i++)
			{
				internal_schema.schemas[i].targetNamespace=internal_schema.targetNamespaces[i];
				schemaMgr.addSchema(internal_schema.schemas[i]);
			}
BaseTravelExpenseService = new WSDLService("BaseTravelExpenseService");
			BaseTravelExpensePort = new WSDLPort("BaseTravelExpensePort",BaseTravelExpenseService);
        	BaseTravelExpenseBinding = new WSDLBinding("BaseTravelExpenseBinding");
	        BaseTravelExpensePortType = new WSDLPortType("BaseTravelExpensePortType");
       		BaseTravelExpenseBinding.portType = BaseTravelExpensePortType;
       		BaseTravelExpensePort.binding = BaseTravelExpenseBinding;
       		BaseTravelExpenseService.addPort(BaseTravelExpensePort);
       		
       		/* changed to collect the webservice url from config xml file */
       		//BaseTravelExpensePort.endpointURI = "http://213.225.125.209/TravelExpWS/TravelExpense.asmx";
       		BaseTravelExpensePort.endpointURI = this.getResourceUrl("webservices");
       		/* end */
       		
       		if(this.endpointURI == null)
       		{
       			this.endpointURI = BaseTravelExpensePort.endpointURI; 
       		} 
       		
			var requestMessage:WSDLMessage;
	        var responseMessage:WSDLMessage;
//define the WSDLOperation: new WSDLOperation(methodName)
            var GetVersion:WSDLOperation = new WSDLOperation("GetVersion");
				//input message for the operation
    	        requestMessage = new WSDLMessage("GetVersion");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","GetVersion");
                
                responseMessage = new WSDLMessage("GetVersionResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","GetVersionResult"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","GetVersion");GetVersion.inputMessage = requestMessage;
	        GetVersion.outputMessage = responseMessage;
            GetVersion.schemaManager = this.schemaMgr;
            GetVersion.soapAction = "http://makingwaves.no/travelExp/GetVersion";
            GetVersion.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(GetVersion);//define the WSDLOperation: new WSDLOperation(methodName)
            var getTravelPdf:WSDLOperation = new WSDLOperation("getTravelPdf");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getTravelPdf");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","travel"),null,new QName("http://makingwaves.no/travelExp/","TravelExpenseVO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelPdf");
                
                responseMessage = new WSDLMessage("getTravelPdfResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","getTravelPdfResult"),null,new QName("http://makingwaves.no/travelExp/","TravelReportDocumentVO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelPdf");getTravelPdf.inputMessage = requestMessage;
	        getTravelPdf.outputMessage = responseMessage;
            getTravelPdf.schemaManager = this.schemaMgr;
            getTravelPdf.soapAction = "http://makingwaves.no/travelExp/getTravelPdf";
            getTravelPdf.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(getTravelPdf);//define the WSDLOperation: new WSDLOperation(methodName)
            var getTravelPdfAsStoredId:WSDLOperation = new WSDLOperation("getTravelPdfAsStoredId");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getTravelPdfAsStoredId");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","travel"),null,new QName("http://makingwaves.no/travelExp/","TravelExpenseVO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelPdfAsStoredId");
                
                responseMessage = new WSDLMessage("getTravelPdfAsStoredIdResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","getTravelPdfAsStoredIdResult"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelPdfAsStoredId");getTravelPdfAsStoredId.inputMessage = requestMessage;
	        getTravelPdfAsStoredId.outputMessage = responseMessage;
            getTravelPdfAsStoredId.schemaManager = this.schemaMgr;
            getTravelPdfAsStoredId.soapAction = "http://makingwaves.no/travelExp/getTravelPdfAsStoredId";
            getTravelPdfAsStoredId.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(getTravelPdfAsStoredId);//define the WSDLOperation: new WSDLOperation(methodName)
            var getTravelXmlAsStoredId:WSDLOperation = new WSDLOperation("getTravelXmlAsStoredId");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getTravelXmlAsStoredId");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","travel"),null,new QName("http://makingwaves.no/travelExp/","TravelExpenseVO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelXmlAsStoredId");
                
                responseMessage = new WSDLMessage("getTravelXmlAsStoredIdResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","getTravelXmlAsStoredIdResult"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelXmlAsStoredId");getTravelXmlAsStoredId.inputMessage = requestMessage;
	        getTravelXmlAsStoredId.outputMessage = responseMessage;
            getTravelXmlAsStoredId.schemaManager = this.schemaMgr;
            getTravelXmlAsStoredId.soapAction = "http://makingwaves.no/travelExp/getTravelXmlAsStoredId";
            getTravelXmlAsStoredId.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(getTravelXmlAsStoredId);//define the WSDLOperation: new WSDLOperation(methodName)
            var removeDataStoredId:WSDLOperation = new WSDLOperation("removeDataStoredId");
				//input message for the operation
    	        requestMessage = new WSDLMessage("removeDataStoredId");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","id"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","removeDataStoredId");
                
                responseMessage = new WSDLMessage("removeDataStoredIdResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","removeDataStoredIdResult"),null,new QName("http://www.w3.org/2001/XMLSchema","boolean")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","removeDataStoredId");removeDataStoredId.inputMessage = requestMessage;
	        removeDataStoredId.outputMessage = responseMessage;
            removeDataStoredId.schemaManager = this.schemaMgr;
            removeDataStoredId.soapAction = "http://makingwaves.no/travelExp/removeDataStoredId";
            removeDataStoredId.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(removeDataStoredId);//define the WSDLOperation: new WSDLOperation(methodName)
            var getTravelObjectFromXml:WSDLOperation = new WSDLOperation("getTravelObjectFromXml");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getTravelObjectFromXml");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","xmlFileBytes"),null,new QName("http://www.w3.org/2001/XMLSchema","base64Binary")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelObjectFromXml");
                
                responseMessage = new WSDLMessage("getTravelObjectFromXmlResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","getTravelObjectFromXmlResult"),null,new QName("http://makingwaves.no/travelExp/","TravelExpenseVO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelObjectFromXml");getTravelObjectFromXml.inputMessage = requestMessage;
	        getTravelObjectFromXml.outputMessage = responseMessage;
            getTravelObjectFromXml.schemaManager = this.schemaMgr;
            getTravelObjectFromXml.soapAction = "http://makingwaves.no/travelExp/getTravelObjectFromXml";
            getTravelObjectFromXml.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(getTravelObjectFromXml);//define the WSDLOperation: new WSDLOperation(methodName)
            var getTravelObjectFromXmlAsStoredId:WSDLOperation = new WSDLOperation("getTravelObjectFromXmlAsStoredId");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getTravelObjectFromXmlAsStoredId");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","id"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelObjectFromXmlAsStoredId");
                
                responseMessage = new WSDLMessage("getTravelObjectFromXmlAsStoredIdResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","getTravelObjectFromXmlAsStoredIdResult"),null,new QName("http://makingwaves.no/travelExp/","TravelExpenseVO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","getTravelObjectFromXmlAsStoredId");getTravelObjectFromXmlAsStoredId.inputMessage = requestMessage;
	        getTravelObjectFromXmlAsStoredId.outputMessage = responseMessage;
            getTravelObjectFromXmlAsStoredId.schemaManager = this.schemaMgr;
            getTravelObjectFromXmlAsStoredId.soapAction = "http://makingwaves.no/travelExp/getTravelObjectFromXmlAsStoredId";
            getTravelObjectFromXmlAsStoredId.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(getTravelObjectFromXmlAsStoredId);//define the WSDLOperation: new WSDLOperation(methodName)
            var RunTestAndGetId:WSDLOperation = new WSDLOperation("RunTestAndGetId");
				//input message for the operation
    	        requestMessage = new WSDLMessage("RunTestAndGetId");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","RunTestAndGetId");
                
                responseMessage = new WSDLMessage("RunTestAndGetIdResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://makingwaves.no/travelExp/","RunTestAndGetIdResult"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://makingwaves.no/travelExp/";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://makingwaves.no/travelExp/","RunTestAndGetId");RunTestAndGetId.inputMessage = requestMessage;
	        RunTestAndGetId.outputMessage = responseMessage;
            RunTestAndGetId.schemaManager = this.schemaMgr;
            RunTestAndGetId.soapAction = "http://makingwaves.no/travelExp/RunTestAndGetId";
            RunTestAndGetId.style = "document";
            BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.addOperation(RunTestAndGetId);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelCommentVO"),webservices.travelexpense.pdf.TravelCommentVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelSpecificationVO"),webservices.travelexpense.pdf.TravelSpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","RateVO"),webservices.travelexpense.pdf.RateVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfTravelDeductionVO"),webservices.travelexpense.pdf.ArrayOfTravelDeductionVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","OtherSpecificationVO"),webservices.travelexpense.pdf.OtherSpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelExpenseVO"),webservices.travelexpense.pdf.TravelExpenseVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelAdvanceVO"),webservices.travelexpense.pdf.TravelAdvanceVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelAccomodationVO"),webservices.travelexpense.pdf.TravelAccomodationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","MotorcycleSpecificationVO"),webservices.travelexpense.pdf.MotorcycleSpecificationVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfRateVO"),webservices.travelexpense.pdf.ArrayOfRateVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","MotorboatSpecificationVO"),webservices.travelexpense.pdf.MotorboatSpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelOutlayVO"),webservices.travelexpense.pdf.TravelOutlayVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfTravelOutlayVO"),webservices.travelexpense.pdf.ArrayOfTravelOutlayVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","SpecificationVO"),webservices.travelexpense.pdf.SpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelDeductionVO"),webservices.travelexpense.pdf.TravelDeductionVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","CommonSpecificationVO"),webservices.travelexpense.pdf.CommonSpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","PersonalInfoVO"),webservices.travelexpense.pdf.PersonalInfoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelVO"),webservices.travelexpense.pdf.TravelVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelReportDocumentVO"),webservices.travelexpense.pdf.TravelReportDocumentVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfTravelAccomodationVO"),webservices.travelexpense.pdf.ArrayOfTravelAccomodationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","AnySpecificationAggregateVO"),webservices.travelexpense.pdf.AnySpecificationAggregateVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","CostVO"),webservices.travelexpense.pdf.CostVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfTravelAdvanceVO"),webservices.travelexpense.pdf.ArrayOfTravelAdvanceVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfTravelCommentVO"),webservices.travelexpense.pdf.ArrayOfTravelCommentVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TicketSpecificationVO"),webservices.travelexpense.pdf.TicketSpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","TravelAllowanceVO"),webservices.travelexpense.pdf.TravelAllowanceVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://makingwaves.no/travelExp/","ArrayOfTravelSpecificationVO"),webservices.travelexpense.pdf.ArrayOfTravelSpecificationVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://makingwaves.no/travelExp/","CarSpecificationVO"),webservices.travelexpense.pdf.CarSpecificationVO);}
		
		/* added to collect the webservice url from config xml file */
		public function getResourceUrl(id:String):String {
			var resourceList:ArrayCollection = ModelLocator.getInstance().resourceList;
			for (var i:Number = 0; i < resourceList.length; i++) {
				if (resourceList.getItemAt(i).id == id) {
					return resourceList.getItemAt(i).url;
				}
			}
			return "";
		}
		/* end */
		
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function getVersion():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("GetVersion");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param travel
		 * @return Asynchronous token
		 */
		public function getTravelPdf(travel:TravelExpenseVO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["travel"] = travel;
	            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("getTravelPdf");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param travel
		 * @return Asynchronous token
		 */
		public function getTravelPdfAsStoredId(travel:TravelExpenseVO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["travel"] = travel;
	            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("getTravelPdfAsStoredId");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param travel
		 * @return Asynchronous token
		 */
		public function getTravelXmlAsStoredId(travel:TravelExpenseVO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["travel"] = travel;
	            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("getTravelXmlAsStoredId");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param id
		 * @return Asynchronous token
		 */
		public function removeDataStoredId(id:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["id"] = id;
	            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("removeDataStoredId");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param xmlFileBytes
		 * @return Asynchronous token
		 */
		public function getTravelObjectFromXml(xmlFileBytes:flash.utils.ByteArray):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["xmlFileBytes"] = xmlFileBytes;
	            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("getTravelObjectFromXml");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param id
		 * @return Asynchronous token
		 */
		public function getTravelObjectFromXmlAsStoredId(id:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["id"] = id;
	            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("getTravelObjectFromXmlAsStoredId");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function runTestAndGetId():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseTravelExpenseService.getPort("BaseTravelExpensePort").binding.portType.getOperation("RunTestAndGetId");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
        /**
         * Performs the actual call to the remove server
         * It SOAP-encodes the message using the schema and WSDL operation options set above and then calls the server using 
         * an async invoker
         * It also registers internal event handlers for the result / fault cases
         * @private
         */
        private function call(operation:WSDLOperation,args:Object,token:AsyncToken,headers:Array=null):void
        {
	    	var enc:SOAPEncoder = new SOAPEncoder();
	        var soap:Object = new Object;
	        var message:SOAPMessage = new SOAPMessage();
	        enc.wsdlOperation = operation;
	        soap = enc.encodeRequest(args,headers);
	        message.setSOAPAction(operation.soapAction);
	        message.body = soap.toString();
	        message.url=endpointURI;
            var inv:AsyncRequest = new AsyncRequest();
            inv.destination = super.destination;
            //we need this to handle multiple asynchronous calls 
            var wrappedData:Object = new Object();
            wrappedData.operation = currentOperation;
            wrappedData.returnToken = token;
            if(!this.useProxy)
            {
            	var dcs:ChannelSet = new ChannelSet();	
	        	dcs.addChannel(new DirectHTTPChannel("direct_http_channel"));
            	inv.channelSet = dcs;
            }                
            var processRes:AsyncResponder = new AsyncResponder(processResult,faultResult,wrappedData);
            inv.invoke(message,processRes);
		}
        
        /**
         * Internal event handler to process a successful operation call from the server
         * The result is decoded using the schema and operation settings and then the events get passed on to the actual facade that the user employs in the application 
         * @private
         */
		private function processResult(result:Object,wrappedData:Object):void
           {
           		var headers:Object;
           		var token:AsyncToken = wrappedData.returnToken;
                var currentOperation:WSDLOperation = wrappedData.operation;
                var decoder:SOAPDecoder = new SOAPDecoder();
                decoder.resultFormat = "object";
                decoder.headerFormat = "object";
                decoder.multiplePartsFormat = "object";
                decoder.ignoreWhitespace = true;
                decoder.makeObjectsBindable=false;
                decoder.wsdlOperation = currentOperation;
                decoder.schemaManager = currentOperation.schemaManager;
                var body:Object = result.message.body;
                var stringResult:String = String(body);
                if(stringResult == null  || stringResult == "")
                	return;
                var soapResult:SOAPResult = decoder.decodeResponse(result.message.body);
                if(soapResult.isFault)
                {
	                var faults:Array = soapResult.result as Array;
	                for each (var soapFault:Fault in faults)
	                {
		                var soapFaultEvent:FaultEvent = FaultEvent.createEvent(soapFault,token,null);
		                token.dispatchEvent(soapFaultEvent);
	                }
                } else {
	                result = soapResult.result;
	                headers = soapResult.headers;
	                var event:ResultEvent = ResultEvent.createEvent(result,token,null);
	                event.headers = headers;
	                token.dispatchEvent(event);
                }
           }
           	/**
           	 * Handles the cases when there are errors calling the operation on the server
           	 * This is not the case for SOAP faults, which is handled by the SOAP decoder in the result handler
           	 * but more critical errors, like network outage or the impossibility to connect to the server
           	 * The fault is dispatched upwards to the facade so that the user can do something meaningful 
           	 * @private
           	 */
			private function faultResult(error:MessageFaultEvent,token:Object):void
			{
				//when there is a network error the token is actually the wrappedData object from above	
				if(!(token is AsyncToken))
					token = token.returnToken;
				token.dispatchEvent(new FaultEvent(FaultEvent.FAULT,true,true,new Fault(error.faultCode,error.faultString,error.faultDetail)));
			}
		}
	}

	import mx.rpc.AsyncToken;
	import mx.rpc.AsyncResponder;
	import mx.rpc.wsdl.WSDLBinding;
                
    /**
     * Internal class to handle multiple operation call scheduling
     * It allows us to pass data about the operation being encoded / decoded to and from the SOAP encoder / decoder units. 
     * @private
     */
    class PendingCall
    {
		public var args:*;
		public var headers:Array;
		public var token:AsyncToken;
		
		public function PendingCall(args:Object, headers:Array=null)
		{
			this.args = args;
			this.headers = headers;
			this.token = new AsyncToken(null);
		}
	}