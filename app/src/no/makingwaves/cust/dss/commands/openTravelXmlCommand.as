package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.*;
	import flash.net.*;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.*;
	import no.makingwaves.util.date.DateRanger;
	
	import webservices.travelexpense.pdf.*;


	public class openTravelXmlCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var _travelXmlDelegate:OpenTravelXmlDelegate = new OpenTravelXmlDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			var delegate:OpenTravelXmlDelegate = new OpenTravelXmlDelegate( this );
			delegate.openTravelXml();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				// reset values in application
				ModelLocator.getInstance().initialize();
				// get result from webservice
				this.getTravelExpenseData(e.result);
				//  tell application that external file is loaded
				ModelLocator.getInstance().calculator.calculate();
				
			} catch(e:Error) {
				errorOccoured(e.message);
			
	        } finally {
	        	ModelLocator.getInstance().stateDistributer.externalFileLoaded();
	        	
	        }				
		}
		
		//----------------------------------------------------------------------------
		public function fault( info : Object ) : void
		{
			errorOccoured();	
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Opening XML failed!"
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);	
			ErrorLocator.getInstance().show();		
		}
		
		private function getTravelExpenseData(travelExpenseInfo:webservices.travelexpense.pdf.TravelExpenseVO):void {
			//ModelLocator.getInstance()
			//var travelExpenseInfo:webservices.travelexpense.pdf.TravelExpenseVO = new webservices.travelexpense.pdf.TravelExpenseVO();
			this.convertPersonalInfo(travelExpenseInfo.personalinfo);
			this.convertTravelInfo(travelExpenseInfo.travel);
			//this.convertTravelAllowances(travelExpenseInfo.travelAllowances);
			this.convertTravelSpecifications(travelExpenseInfo.specificationList);
			this.convertTravelAccomodations(travelExpenseInfo.accomodationList);
			this.convertTravelDeductions(travelExpenseInfo.travelDeductionList);
			this.convertTravelOutlays(travelExpenseInfo.travelOutlayList);
			this.convertTravelAdvances(travelExpenseInfo.travelAdvanceList);
			this.convertTravelComments(travelExpenseInfo.travelCommentList);
			// update model references
			var tempDateOut:Date = ModelLocator.getInstance().activeTravel.travel_date_out;
			var tempDateIn :Date = ModelLocator.getInstance().activeTravel.travel_date_in;
			//var diffUtcTime:Number = new Date().timezoneOffset / 60; // the users timezone
			tempDateOut.setHours(Number(ModelLocator.getInstance().activeTravel.travel_time_out.substr(0,2)), Number(ModelLocator.getInstance().activeTravel.travel_time_out.substr(2,2)));
			tempDateIn.setHours(Number(ModelLocator.getInstance().activeTravel.travel_time_in.substr(0,2)), Number(ModelLocator.getInstance().activeTravel.travel_time_in.substr(2,2)));
			var dateRange:DateRanger = new DateRanger();
			dateRange.getDateRange(tempDateOut, tempDateIn);
			// update model
			ModelLocator.getInstance().travelLength = dateRange;
					

		}
		
		private function convertPersonalInfo(personalInfo:webservices.travelexpense.pdf.PersonalInfoVO):void {
			var modelInfo:no.makingwaves.cust.dss.vo.PersonalInfoVO = new no.makingwaves.cust.dss.vo.PersonalInfoVO();
			modelInfo.socialsecuritynumber = personalInfo.socialsecuritynumber;
			modelInfo.firstname = personalInfo.firstname;
			modelInfo.lastname = personalInfo.lastname;
			modelInfo.adress = personalInfo.adress;
			modelInfo.zip = personalInfo.zip;
			modelInfo.postoffice = personalInfo.postoffice;
			modelInfo.account = personalInfo.account;
			modelInfo.workplace = personalInfo.workplace;
			modelInfo.department = personalInfo.department;
			modelInfo.jobtitle = personalInfo.jobtitle;
			modelInfo.domicialnum = personalInfo.domicialnum;
			modelInfo.domicialname = personalInfo.domicialname;
			
			ModelLocator.getInstance().activePerson = modelInfo;
		}
		
		private function convertTravelInfo(travelinfo:webservices.travelexpense.pdf.TravelVO):void {
			var modelinfo:no.makingwaves.cust.dss.vo.TravelVO = new no.makingwaves.cust.dss.vo.TravelVO();
			modelinfo.location = travelinfo.location;
			modelinfo.travel_type = travelinfo.travel_type;
			modelinfo.travel_cause = travelinfo.travel_cause;
			modelinfo.travel_cause_other = travelinfo.travel_cause_other;
			modelinfo.travel_date_out = travelinfo.travel_date_out;
			modelinfo.travel_time_out = travelinfo.travel_time_out;
			modelinfo.travel_date_in = travelinfo.travel_date_in;
			modelinfo.travel_time_in = travelinfo.travel_time_in;
			modelinfo.travel_number = travelinfo.travelNumber;
			
			ModelLocator.getInstance().activeTravel = modelinfo;
		}
		
		private function convertTravelSpecifications(specificationList:webservices.travelexpense.pdf.ArrayOfTravelSpecificationVO):void {
			var modelList:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i < specificationList.length; i++) {
				var newSpecification:no.makingwaves.cust.dss.vo.TravelSpecificationVO = new no.makingwaves.cust.dss.vo.TravelSpecificationVO();
				var savedSpecification:webservices.travelexpense.pdf.TravelSpecificationVO = webservices.travelexpense.pdf.TravelSpecificationVO(specificationList.getItemAt(i));
				newSpecification.transportation_type = savedSpecification.transportation_type;
				newSpecification.from_destination = savedSpecification.from_destination;
				newSpecification.from_country = savedSpecification.from_country;
				newSpecification.from_city = savedSpecification.from_city;
				newSpecification.from_date = savedSpecification.from_date;
				if (newSpecification.from_date != null) {
					var hours:String = savedSpecification.from_date.getHours().toString();
					var minutes:String = savedSpecification.from_date.getMinutes().toString();
					if (hours.length == 1) { hours = "0" + hours; }
					if (minutes.length == 1) { minutes = "0" + minutes; }
					newSpecification.from_time = hours + minutes;
					newSpecification.from_timezone = savedSpecification.from_timezone; //-newSpecification.from_date.getTimezoneOffset() / 60;
				}
				
					
				//newSpecification.from_time = savedSpecification.from_time;
				newSpecification.to_destination = savedSpecification.to_destination;
				newSpecification.to_country = savedSpecification.to_country;
				newSpecification.to_city = savedSpecification.to_city;
				newSpecification.to_date = savedSpecification.to_date;
				if (newSpecification.to_date != null) {
					var hours:String = savedSpecification.to_date.getHours().toString()
					var minutes:String = savedSpecification.to_date.getMinutes().toString();
					if (hours.length == 1) { hours = "0" + hours; }
					if (minutes.length == 1) { minutes = "0" + minutes; }
					newSpecification.to_time = hours + minutes;
					newSpecification.to_timezone = savedSpecification.to_timezone; //-newSpecification.to_date.getTimezoneOffset() / 60;
				}

				//newSpecification.to_time = savedSpecification.to_time;
				newSpecification.is_travel_continious = savedSpecification.is_travel_continious;
				newSpecification.is_travel_start = savedSpecification.is_travel_start;
				newSpecification.is_travel_end = savedSpecification.is_travel_end;
				// update cost vo
				newSpecification.cost = new no.makingwaves.cust.dss.vo.CostVO();
				newSpecification.cost.cost = savedSpecification.cost.cost;
				newSpecification.cost.cost_currency = savedSpecification.cost.cost_currency;
				newSpecification.cost.cost_currency_rate = savedSpecification.cost.cost_currency_rate;
				// find correct sub-specification
				if (savedSpecification.specification_aggregate != null) {
					if (savedSpecification.specification_aggregate.car_specification) {
						var carSavedSpecification:webservices.travelexpense.pdf.CarSpecificationVO = webservices.travelexpense.pdf.CarSpecificationVO(savedSpecification.specification_aggregate.car_specification);
						var carNewSpecification:no.makingwaves.cust.dss.vo.CarSpecificationVO = new no.makingwaves.cust.dss.vo.CarSpecificationVO();
						carNewSpecification.type = carSavedSpecification.type;
						carNewSpecification.distance = carSavedSpecification.distance;
						carNewSpecification.additional_trailer = carSavedSpecification.additional_trailer;
						carNewSpecification.additional_workplace = carSavedSpecification.additional_workplace;
						carNewSpecification.distance_calender = carSavedSpecification.distance_calender;
						carNewSpecification.distance_forestroad = carSavedSpecification.distance_forestroad;
						carNewSpecification.passengers = carSavedSpecification.passengers;
						carNewSpecification.rate = carSavedSpecification.rate;
						carNewSpecification.cost = new no.makingwaves.cust.dss.vo.CostVO();
						carNewSpecification.cost.cost = carSavedSpecification.cost.cost; 
						carNewSpecification.cost.cost_currency = carSavedSpecification.cost.cost_currency;
						carNewSpecification.cost.cost_currency_rate = carSavedSpecification.cost.cost_currency_rate;
						
						newSpecification.specification = new no.makingwaves.cust.dss.vo.CarSpecificationVO();
						newSpecification.specification = carNewSpecification;
						
					} else if (savedSpecification.specification_aggregate.motorboat_specification) {
						var boatSavedSpecification:webservices.travelexpense.pdf.MotorboatSpecificationVO = webservices.travelexpense.pdf.MotorboatSpecificationVO(savedSpecification.specification_aggregate.motorboat_specification);
						var boatNewSpecification:no.makingwaves.cust.dss.vo.MotorboatSpecificationVO = new no.makingwaves.cust.dss.vo.MotorboatSpecificationVO();
						boatNewSpecification.type = boatSavedSpecification.type;
						boatNewSpecification.distance = boatSavedSpecification.distance;
						boatNewSpecification.motorboat_type = boatSavedSpecification.motorboat_type;
						boatNewSpecification.passengers = boatSavedSpecification.passengers;
						boatNewSpecification.rate = boatSavedSpecification.rate;
						boatNewSpecification.cost = new no.makingwaves.cust.dss.vo.CostVO();
						boatNewSpecification.cost.cost = boatSavedSpecification.cost.cost; 
						boatNewSpecification.cost.cost_currency = boatSavedSpecification.cost.cost_currency;
						boatNewSpecification.cost.cost_currency_rate = boatSavedSpecification.cost.cost_currency_rate;
						
						newSpecification.specification = new no.makingwaves.cust.dss.vo.MotorboatSpecificationVO();
						newSpecification.specification = boatNewSpecification;
						
					} else if (savedSpecification.specification_aggregate.motorcycle_specification) {
						var cycleModelSpecification:webservices.travelexpense.pdf.MotorcycleSpecificationVO = webservices.travelexpense.pdf.MotorcycleSpecificationVO(savedSpecification.specification_aggregate.motorcycle_specification);
						var cycleNewSpecification:no.makingwaves.cust.dss.vo.MotorcycleSpecificationVO = new no.makingwaves.cust.dss.vo.MotorcycleSpecificationVO();
						cycleNewSpecification.type = cycleModelSpecification.type;
						cycleNewSpecification.distance = cycleModelSpecification.distance;
						cycleNewSpecification.motorcycle_type = cycleModelSpecification.motorcycle_type;
						cycleNewSpecification.passengers = cycleModelSpecification.passengers;
						cycleNewSpecification.rate = cycleModelSpecification.rate;
						cycleNewSpecification.cost = new no.makingwaves.cust.dss.vo.CostVO();
						cycleNewSpecification.cost.cost = cycleModelSpecification.cost.cost; 
						cycleNewSpecification.cost.cost_currency = cycleModelSpecification.cost.cost_currency;
						cycleNewSpecification.cost.cost_currency_rate = cycleModelSpecification.cost.cost_currency_rate;
						
						newSpecification.specification = new no.makingwaves.cust.dss.vo.MotorcycleSpecificationVO();
						newSpecification.specification = cycleNewSpecification;
						
					} else if (savedSpecification.specification_aggregate.other_specification) {
						var otherSavedSpecification:webservices.travelexpense.pdf.OtherSpecificationVO = webservices.travelexpense.pdf.OtherSpecificationVO(savedSpecification.specification_aggregate.other_specification);
						var otherNewSpecification:no.makingwaves.cust.dss.vo.OtherSpecificationVO = new no.makingwaves.cust.dss.vo.OtherSpecificationVO();
						otherNewSpecification.type = otherSavedSpecification.type;
						otherNewSpecification.distance = otherSavedSpecification.distance;
						otherNewSpecification.other_type = otherSavedSpecification.other_type;
						otherNewSpecification.passengers = otherSavedSpecification.passengers;
						otherNewSpecification.rate = otherSavedSpecification.rate;
						otherNewSpecification.cost = new no.makingwaves.cust.dss.vo.CostVO();
						otherNewSpecification.cost.cost = otherSavedSpecification.cost.cost; 
						otherNewSpecification.cost.cost_currency = otherSavedSpecification.cost.cost_currency;
						otherNewSpecification.cost.cost_currency_rate = otherSavedSpecification.cost.cost_currency_rate;
						
						newSpecification.specification = new no.makingwaves.cust.dss.vo.OtherSpecificationVO();
						newSpecification.specification = cycleNewSpecification;
					}
				} else {
					//var ticketModelSpecification:no.makingwaves.cust.dss.vo.TicketSpecificationVO = no.makingwaves.cust.dss.vo.TicketSpecificationVO(modelSpecification.specification);
					//var ticketNewSpecification:webservices.travelexpense.pdf.TicketSpecificationVO = new webservices.travelexpense.pdf.TicketSpecificationVO();
					/*ticketNewSpecification.type = ticketModelSpecification.type;
					ticketNewSpecification.cost = new webservices.travelexpense.pdf.CostVO();
					ticketNewSpecification.cost.cost = ticketModelSpecification.cost.cost; 
					ticketNewSpecification.cost.cost_currency = ticketModelSpecification.cost.cost_currency;
					ticketNewSpecification.cost.cost_currency_rate = ticketModelSpecification.cost.cost_currency_rate;
					*/
					//newSpecification.specification_aggregate.ticket_specification = ticketNewSpecification;
					
				}
				// add to list
				modelList.addItem(newSpecification);
			}
			
			ModelLocator.getInstance().travelSpecsList = modelList;
		}
		
		private function convertTravelAccomodations(accomodationList:ArrayOfTravelAccomodationVO):void {
			var modelList:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i < accomodationList.length; i++) {
				var newAccomodation:no.makingwaves.cust.dss.vo.TravelAccomodationVO= new no.makingwaves.cust.dss.vo.TravelAccomodationVO();
				var savedAccomodation:webservices.travelexpense.pdf.TravelAccomodationVO = webservices.travelexpense.pdf.TravelAccomodationVO(accomodationList.getItemAt(i));
				newAccomodation.type = savedAccomodation.type;
				newAccomodation.name = savedAccomodation.name;
				newAccomodation.adress = savedAccomodation.adress;
				newAccomodation.fromdate = savedAccomodation.fromdate;
				newAccomodation.todate = savedAccomodation.todate;
				newAccomodation.country = savedAccomodation.country;
				newAccomodation.city = savedAccomodation.city;
				newAccomodation.breakfast_inluded = savedAccomodation.breakfast_inluded;
				newAccomodation.cost = new no.makingwaves.cust.dss.vo.CostVO();
				newAccomodation.cost.cost = savedAccomodation.cost.cost; 
				newAccomodation.cost.cost_currency = savedAccomodation.cost.cost_currency;
				newAccomodation.cost.cost_currency_rate = savedAccomodation.cost.cost_currency_rate;
				newAccomodation.actual_cost = new no.makingwaves.cust.dss.vo.CostVO();
				newAccomodation.actual_cost.cost = savedAccomodation.actual_cost.cost; 
				newAccomodation.actual_cost.cost_currency = savedAccomodation.actual_cost.cost_currency;
				newAccomodation.actual_cost.cost_currency_rate = savedAccomodation.actual_cost.cost_currency_rate;
								
				modelList.addItem(newAccomodation);
			}
			
			ModelLocator.getInstance().travelAccomodationList = modelList;
		}
		
		private function convertTravelDeductions(deductionList:ArrayOfTravelDeductionVO):void {
			var modelList:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i < deductionList.length; i++) {
				var newDeduction:no.makingwaves.cust.dss.vo.TravelDeductionVO = new no.makingwaves.cust.dss.vo.TravelDeductionVO();
				var savedDeduction:webservices.travelexpense.pdf.TravelDeductionVO = webservices.travelexpense.pdf.TravelDeductionVO(deductionList.getItemAt(i));
				newDeduction.date = savedDeduction.date;
				newDeduction.breakfast = savedDeduction.breakfast;
				newDeduction.lunch = savedDeduction.lunch;
				newDeduction.dinner = savedDeduction.dinner;
				newDeduction.cost = new no.makingwaves.cust.dss.vo.CostVO();
				newDeduction.cost.cost = -Math.abs(savedDeduction.cost.cost); 
				newDeduction.cost.cost_currency = savedDeduction.cost.cost_currency;
				newDeduction.cost.cost_currency_rate = savedDeduction.cost.cost_currency_rate;
				
				modelList.addItem(newDeduction);
			}
			
			ModelLocator.getInstance().travelDeductionList = modelList;
		}
		
		private function convertTravelOutlays(outlayList:ArrayOfTravelOutlayVO):void {
			var modelList:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i < outlayList.length; i++) {
				var newOutlay:no.makingwaves.cust.dss.vo.TravelOutlayVO = new no.makingwaves.cust.dss.vo.TravelOutlayVO();
				var savedOutlay:webservices.travelexpense.pdf.TravelOutlayVO = webservices.travelexpense.pdf.TravelOutlayVO(outlayList.getItemAt(i));
				//newOutlay.type = savedOutlay.type;
				newOutlay.date = savedOutlay.date;
				newOutlay.specification = savedOutlay.specification;
				newOutlay.cost = new no.makingwaves.cust.dss.vo.CostVO();
				newOutlay.cost.cost = savedOutlay.cost.cost; 
				newOutlay.cost.cost_currency = savedOutlay.cost.cost_currency;
				newOutlay.cost.cost_currency_rate = savedOutlay.cost.cost_currency_rate;
				
				modelList.addItem(newOutlay);
			}
			
			ModelLocator.getInstance().travelOutlayList = modelList;
		}
		
		private function convertTravelAdvances(advanceList:ArrayOfTravelAdvanceVO):void {
			var modelList:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i < advanceList.length; i++) {
				var newAdvance:no.makingwaves.cust.dss.vo.TravelAdvanceVO = new no.makingwaves.cust.dss.vo.TravelAdvanceVO();
				var modelAdvance:webservices.travelexpense.pdf.TravelAdvanceVO = webservices.travelexpense.pdf.TravelAdvanceVO(advanceList.getItemAt(i));
				newAdvance.location = modelAdvance.location;
				newAdvance.date = modelAdvance.date;
				newAdvance.cost = modelAdvance.cost;
				
				modelList.addItem(newAdvance);
			}
			
			ModelLocator.getInstance().travelAdvanceList = modelList;
		}
		
		private function convertTravelComments(commentList:ArrayOfTravelCommentVO):void {
			var modelList:ArrayCollection = new ArrayCollection();
			for (var i:Number = 0; i < commentList.length; i++) {
				var newComment:no.makingwaves.cust.dss.vo.TravelCommentVO = new no.makingwaves.cust.dss.vo.TravelCommentVO();
				var savedComment:webservices.travelexpense.pdf.TravelCommentVO = webservices.travelexpense.pdf.TravelCommentVO(commentList.getItemAt(i));
				newComment.comment = savedComment.comment;
				
				modelList.addItem(newComment);
			}
			
			ModelLocator.getInstance().travelCommentList = modelList;
		}
		
		
		// resource url collector
		private function getResourceUrl(id:String):String {
			var resourceList:ArrayCollection = ModelLocator.getInstance().resourceList;
			for (var i:Number = 0; i < resourceList.length; i++) {
				if (resourceList.getItemAt(i).id == id) {
					return resourceList.getItemAt(i).url;
				}
			}
			return "";
		}
		
		
	}
}