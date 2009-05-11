package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.code.util.Util;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.*;
	import no.makingwaves.util.date.DateRanger;
	
	import webservices.travelexpense.pdf.*;

	public class getTravelInfoBaseCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var model : ModelLocator = ModelLocator.getInstance();
		
		private var outputType:String;
		
		private var extraCommentsList:ArrayCollection = new ArrayCollection();


		// functions ============================
		public function execute( event:CairngormEvent ) : void {}
		
		//----------------------------------------------------------------------------
		public function result( data:Object ) : void {}
		
		//----------------------------------------------------------------------------
		public function fault( info : Object ) : void {}
		
		public function getTravelExpenseData(format:String="xml"):webservices.travelexpense.pdf.TravelExpenseVO {
			outputType = format;
			extraCommentsList = new ArrayCollection();
			
			ModelLocator.getInstance().calculator.calculate();
			var travelExpenseInfo:webservices.travelexpense.pdf.TravelExpenseVO = new webservices.travelexpense.pdf.TravelExpenseVO();
			travelExpenseInfo.personalinfo = this.convertPersonalInfo();
			travelExpenseInfo.travel = this.convertTravelInfo();
			travelExpenseInfo.travelAllowances = this.convertTravelAllowances();
			travelExpenseInfo.specificationList = this.convertTravelSpecifications();
			travelExpenseInfo.accomodationList = this.convertTravelAccomodations();
			travelExpenseInfo.travelDeductionList = this.convertTravelDeductions();
			travelExpenseInfo.travelOutlayList = this.convertTravelOutlays();
			travelExpenseInfo.travelAdvanceList = this.convertTravelAdvances();
			travelExpenseInfo.travelCommentList = this.convertTravelComments();
			
			return travelExpenseInfo;
		}
		
		public function convertPersonalInfo():webservices.travelexpense.pdf.PersonalInfoVO {
			var includeData:Boolean = ModelLocator.getInstance().saveWithPersonalInfo;
			
			var personalInfo:webservices.travelexpense.pdf.PersonalInfoVO = new webservices.travelexpense.pdf.PersonalInfoVO();
			var modelInfo:no.makingwaves.cust.dss.vo.PersonalInfoVO = ModelLocator.getInstance().activePerson;
			personalInfo.socialsecuritynumber = (includeData) ? modelInfo.socialsecuritynumber : "";
			personalInfo.firstname = (includeData) ? modelInfo.firstname : "";
			personalInfo.lastname = (includeData) ? modelInfo.lastname : "";
			personalInfo.adress = (includeData) ? modelInfo.adress : "";
			personalInfo.zip = (includeData) ? modelInfo.zip : "";
			personalInfo.postoffice = (includeData) ? modelInfo.postoffice : "";
			personalInfo.account = (includeData) ? modelInfo.account : "";
			personalInfo.workplace = (includeData) ? modelInfo.workplace : "";
			personalInfo.department = (includeData) ? modelInfo.department : "";
			personalInfo.jobtitle = (includeData) ? modelInfo.jobtitle : "";
			personalInfo.domicialnum = (includeData) ? modelInfo.domicialnum : "";
			personalInfo.domicialname = (includeData) ? modelInfo.domicialname : "";
			// reset parameter, default should be to include data
			ModelLocator.getInstance().saveWithPersonalInfo = true;
			
			return personalInfo;
		}
		
		public function convertTravelInfo():webservices.travelexpense.pdf.TravelVO {
			var travelinfo:webservices.travelexpense.pdf.TravelVO = new webservices.travelexpense.pdf.TravelVO();
			var modelinfo:no.makingwaves.cust.dss.vo.TravelVO = ModelLocator.getInstance().activeTravel;
			travelinfo.location = modelinfo.location;
			travelinfo.travel_type = modelinfo.travel_type;
			travelinfo.travel_cause = modelinfo.travel_cause;
			travelinfo.travel_cause_other = modelinfo.travel_cause_other;
			travelinfo.travel_date_out = modelinfo.travel_date_out;
			travelinfo.travel_time_out = modelinfo.travel_time_out;
			travelinfo.travel_date_in = modelinfo.travel_date_in;
			travelinfo.travel_time_in = modelinfo.travel_time_in;
			travelinfo.travelNumber = modelinfo.travel_number;
			
			return travelinfo;
		}
		
		public function convertTravelAllowances():webservices.travelexpense.pdf.TravelAllowanceVO {
			var allowances:webservices.travelexpense.pdf.TravelAllowanceVO = new webservices.travelexpense.pdf.TravelAllowanceVO();
			var modelAllowance:no.makingwaves.cust.dss.vo.TravelAllowanceVO = ModelLocator.getInstance().travelAllowance;
			allowances.accomodation = modelAllowance.accomodation;
			allowances.adm_allowance = convertRate(modelAllowance.adm_allowance);
			allowances.allowance = convertRate(modelAllowance.allowance);
			allowances.allowance_international = convertRateArray(modelAllowance.allowance_international);
			allowances.allowance_28days = convertRate(modelAllowance.allowance_28days);
			allowances.allowance_other = convertRateArray(modelAllowance.allowance_other);
			allowances.car_distance1 = convertRate(modelAllowance.car_distance1);
			allowances.car_distance2 = convertRate(modelAllowance.car_distance2);
			allowances.car_otherrates = convertRate(modelAllowance.car_otherrates);
			allowances.car_passengers = convertRate(modelAllowance.car_passengers);
			allowances.domestic = modelAllowance.domestic;
			allowances.netamount = modelAllowance.netamount;
			allowances.nighttariff_28days = convertRate(modelAllowance.nighttariff_28days);
			allowances.nighttariff_domestic = convertRate(modelAllowance.nighttariff_domestic);
			allowances.nighttariff_domestic_hotel = convertRate(modelAllowance.nighttariff_domestic_hotel);
			allowances.nighttariff_international = convertRateArray(modelAllowance.nighttariff_international); //convertRate(modelAllowance.nighttariff_international);
			
			// check wether there is need for additional comments on the print-out
			if (this.outputType == "pdf") {
				var travelDateInfo:DateRanger = ModelLocator.getInstance().travelLength;
				var intTravel:Boolean = (ModelLocator.getInstance().activeTravel.travel_type == ModelLocator.getInstance().activeTravel.ABROAD); 
				if (travelDateInfo.total_hours > 12 && intTravel) {
					var days:int = 1;
					if (travelDateInfo.total_hours > 24) { 
						days = travelDateInfo.days;
						if (travelDateInfo.hours >= 12) {
							days++;
						}
					} else if (travelDateInfo.total_24hours == 0) {
						days = 1;
					}					
					
					var commentStr:String = ResourceManager.getInstance().getString(model.resources.bundleName, 'info_international_compensation');
					commentStr = Util.searchAndReplace(commentStr, "%1", days.toString());
					commentStr = Util.searchAndReplace(commentStr, "%2", modelAllowance.allowance_other.getItemAt(0).rate);
					
					var modelComment:no.makingwaves.cust.dss.vo.TravelCommentVO = new no.makingwaves.cust.dss.vo.TravelCommentVO();
					modelComment.comment = commentStr;
					this.extraCommentsList.addItem(modelComment);
				}
			}
			
			return allowances;
		}
		
		private function convertRate(rate:no.makingwaves.cust.dss.vo.RateVO):webservices.travelexpense.pdf.RateVO {
			var returnRate:webservices.travelexpense.pdf.RateVO = new webservices.travelexpense.pdf.RateVO();
			returnRate.amount = rate.amount;
			returnRate.num = rate.num;
			returnRate.rate = rate.rate;
			
			return returnRate;
		}
		
		private function convertRateArray(rateArray:ArrayCollection):ArrayOfRateVO {
			var returnArray:ArrayOfRateVO = new ArrayOfRateVO();
			for (var i:Number = 0; i < rateArray.length; i++) {
				var modelRate:no.makingwaves.cust.dss.vo.RateVO = no.makingwaves.cust.dss.vo.RateVO(rateArray.getItemAt(i));
				returnArray.addRateVO(convertRate(modelRate));
			}
			return returnArray;
		}
		
		public function convertTravelSpecifications():webservices.travelexpense.pdf.ArrayOfTravelSpecificationVO {
			var specificationList:ArrayOfTravelSpecificationVO = new ArrayOfTravelSpecificationVO();
			var modelList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;
			for (var i:Number = 0; i < modelList.length; i++) {
				var newSpecification:webservices.travelexpense.pdf.TravelSpecificationVO = new webservices.travelexpense.pdf.TravelSpecificationVO();
				var modelSpecification:no.makingwaves.cust.dss.vo.TravelSpecificationVO = no.makingwaves.cust.dss.vo.TravelSpecificationVO(modelList.getItemAt(i));
				newSpecification.transportation_type = modelSpecification.transportation_type;
				newSpecification.from_destination = modelSpecification.from_destination;
				newSpecification.from_country = (this.outputType == "pdf") ? modelSpecification.from_country.split("#")[0] : modelSpecification.from_country;
				newSpecification.from_city = modelSpecification.from_city;
				newSpecification.from_date = modelSpecification.from_date;
				if (modelSpecification.from_time != "" && modelSpecification.from_time != null) {
					newSpecification.from_timezone = Number(modelSpecification.from_timezone);
					newSpecification.from_date.setHours(Number(modelSpecification.from_time.substr(0,2)), Number(modelSpecification.from_time.substr(2,2)));
				}
					
				newSpecification.to_destination = modelSpecification.to_destination;
				newSpecification.to_country = (this.outputType == "pdf") ? modelSpecification.to_country.split("#")[0] : modelSpecification.to_country;
				newSpecification.to_city = modelSpecification.to_city;
				newSpecification.to_date = modelSpecification.to_date;
				if (modelSpecification.to_time != "" && modelSpecification.to_time != null) {
					newSpecification.to_timezone = Number(modelSpecification.to_timezone);
					newSpecification.to_date.setHours(Number(modelSpecification.to_time.substr(0,2)), Number(modelSpecification.to_time.substr(2,2)));
				}
					
				newSpecification.is_travel_continious = modelSpecification.is_travel_continious;
				newSpecification.is_travel_start = modelSpecification.is_travel_start;
				newSpecification.is_travel_end = modelSpecification.is_travel_end;
				
				// REMOVE WHEN WEBSERVICE IS UPDATED //newSpecification.intermediate_landing = modelSpecification.intermediate_landing;
				// update cost vo
				newSpecification.cost = new webservices.travelexpense.pdf.CostVO();
				newSpecification.cost.cost = modelSpecification.cost.cost;
				newSpecification.cost.cost_currency = modelSpecification.cost.cost_currency;
				newSpecification.cost.cost_currency_rate = modelSpecification.cost.cost_currency_rate;
				// find correct sub-specification
				if (modelSpecification.specification != null) {
					if (modelSpecification.specification.type == "car") {
						var carModelSpecification:no.makingwaves.cust.dss.vo.CarSpecificationVO = no.makingwaves.cust.dss.vo.CarSpecificationVO(modelSpecification.specification);
						var carNewSpecification:webservices.travelexpense.pdf.CarSpecificationVO = new webservices.travelexpense.pdf.CarSpecificationVO();
						carNewSpecification.type = carModelSpecification.type;
						carNewSpecification.distance = carModelSpecification.distance;
						carNewSpecification.additional_trailer = carModelSpecification.additional_trailer;
						carNewSpecification.additional_workplace = carModelSpecification.additional_workplace;
						carNewSpecification.distance_calender = carModelSpecification.distance_calender;
						carNewSpecification.distance_forestroad = carModelSpecification.distance_forestroad;
						carNewSpecification.passengers = carModelSpecification.passengers;
						carNewSpecification.rate = carModelSpecification.rate;
						carNewSpecification.cost = new webservices.travelexpense.pdf.CostVO();
						carNewSpecification.cost.cost = carModelSpecification.cost.cost; 
						carNewSpecification.cost.cost_currency = carModelSpecification.cost.cost_currency;
						carNewSpecification.cost.cost_currency_rate = carModelSpecification.cost.cost_currency_rate;
						
						newSpecification.specification_aggregate = new webservices.travelexpense.pdf.AnySpecificationAggregateVO();
						newSpecification.specification_aggregate.which_specification_used = 2;
						newSpecification.specification_aggregate.car_specification = carNewSpecification;
						
					} else if (modelSpecification.specification.type == "motorboat") {
						var boatModelSpecification:no.makingwaves.cust.dss.vo.MotorboatSpecificationVO = no.makingwaves.cust.dss.vo.MotorboatSpecificationVO(modelSpecification.specification);
						var boatNewSpecification:webservices.travelexpense.pdf.MotorboatSpecificationVO = new webservices.travelexpense.pdf.MotorboatSpecificationVO();
						boatNewSpecification.type = boatModelSpecification.type;
						boatNewSpecification.distance = boatModelSpecification.distance;
						boatNewSpecification.motorboat_type = boatModelSpecification.motorboat_type;
						boatNewSpecification.passengers = boatModelSpecification.passengers;
						boatNewSpecification.rate = boatModelSpecification.rate;
						boatNewSpecification.cost = new webservices.travelexpense.pdf.CostVO();
						boatNewSpecification.cost.cost = boatModelSpecification.cost.cost; 
						boatNewSpecification.cost.cost_currency = boatModelSpecification.cost.cost_currency;
						boatNewSpecification.cost.cost_currency_rate = boatModelSpecification.cost.cost_currency_rate;
						
						newSpecification.specification_aggregate = new webservices.travelexpense.pdf.AnySpecificationAggregateVO();
						newSpecification.specification_aggregate.which_specification_used = 3;
						newSpecification.specification_aggregate.motorboat_specification = boatNewSpecification;
						
					} else if (modelSpecification.specification.type == "motorcycle") {
						var cycleModelSpecification:no.makingwaves.cust.dss.vo.MotorcycleSpecificationVO = no.makingwaves.cust.dss.vo.MotorcycleSpecificationVO(modelSpecification.specification);
						var cycleNewSpecification:webservices.travelexpense.pdf.MotorcycleSpecificationVO = new webservices.travelexpense.pdf.MotorcycleSpecificationVO();
						cycleNewSpecification.type = cycleModelSpecification.type;
						cycleNewSpecification.distance = cycleModelSpecification.distance;
						cycleNewSpecification.motorcycle_type = cycleModelSpecification.motorcycle_type;
						cycleNewSpecification.passengers = cycleModelSpecification.passengers;
						cycleNewSpecification.rate = cycleModelSpecification.rate;
						cycleNewSpecification.cost = new webservices.travelexpense.pdf.CostVO();
						cycleNewSpecification.cost.cost = cycleModelSpecification.cost.cost; 
						cycleNewSpecification.cost.cost_currency = cycleModelSpecification.cost.cost_currency;
						cycleNewSpecification.cost.cost_currency_rate = cycleModelSpecification.cost.cost_currency_rate;
						
						newSpecification.specification_aggregate = new webservices.travelexpense.pdf.AnySpecificationAggregateVO();
						newSpecification.specification_aggregate.which_specification_used = 4;
						newSpecification.specification_aggregate.motorcycle_specification = cycleNewSpecification;
						
					} else if (modelSpecification.specification.type == "other") {
						var otherModelSpecification:no.makingwaves.cust.dss.vo.OtherSpecificationVO = no.makingwaves.cust.dss.vo.OtherSpecificationVO(modelSpecification.specification);
						var otherNewSpecification:webservices.travelexpense.pdf.OtherSpecificationVO = new webservices.travelexpense.pdf.OtherSpecificationVO();
						otherNewSpecification.type = otherModelSpecification.type;
						otherNewSpecification.distance = otherModelSpecification.distance;
						otherNewSpecification.other_type = otherModelSpecification.other_type;
						otherNewSpecification.passengers = otherModelSpecification.passengers;
						otherNewSpecification.rate = otherModelSpecification.rate;
						otherNewSpecification.cost = newSpecification.cost; /*new webservices.travelexpense.pdf.CostVO();
						otherNewSpecification.cost.cost = otherModelSpecification.cost.cost; 
						otherNewSpecification.cost.cost_currency = otherModelSpecification.cost.cost_currency;
						otherNewSpecification.cost.cost_currency_rate = otherModelSpecification.cost.cost_currency_rate;*/
						
						newSpecification.specification_aggregate = new webservices.travelexpense.pdf.AnySpecificationAggregateVO();
						newSpecification.specification_aggregate.which_specification_used = 5;
						newSpecification.specification_aggregate.other_specification = otherNewSpecification;
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
				specificationList.addTravelSpecificationVO(newSpecification);
			}
			return specificationList;
			
		}
		
		public function convertTravelAccomodations():ArrayOfTravelAccomodationVO {
			var accomodationList:ArrayOfTravelAccomodationVO = new ArrayOfTravelAccomodationVO();
			var modelList:ArrayCollection = ModelLocator.getInstance().travelAccomodationList;
			for (var i:Number = 0; i < modelList.length; i++) {
				var newAccomodation:webservices.travelexpense.pdf.TravelAccomodationVO = new webservices.travelexpense.pdf.TravelAccomodationVO();
				var modelAccomodation:no.makingwaves.cust.dss.vo.TravelAccomodationVO = no.makingwaves.cust.dss.vo.TravelAccomodationVO(modelList.getItemAt(i));
				var addActualCost:Boolean = true;
				// check wether accomodation is unauthorized, if so it should not be a part of the specifications on the PDF
				if (this.outputType == "pdf") {
					if (modelAccomodation.type != modelAccomodation.TYPE_HOTEL) {
						// accomodation is unauthorized
						addActualCost = false;
					}
				}
				newAccomodation.type = modelAccomodation.type;
				newAccomodation.name = modelAccomodation.name;
				newAccomodation.adress = modelAccomodation.adress;
				newAccomodation.fromdate = modelAccomodation.fromdate;
				newAccomodation.todate = modelAccomodation.todate;
				newAccomodation.country = (this.outputType == "pdf") ? modelAccomodation.country.split("#")[0] : modelAccomodation.country;
				newAccomodation.city = modelAccomodation.city;
				newAccomodation.breakfast_inluded = modelAccomodation.breakfast_inluded;
				newAccomodation.cost = new webservices.travelexpense.pdf.CostVO();
				newAccomodation.cost.cost = modelAccomodation.cost.cost; 
				newAccomodation.cost.cost_currency = modelAccomodation.cost.cost_currency;
				newAccomodation.cost.cost_currency_rate = modelAccomodation.cost.cost_currency_rate;
				newAccomodation.actual_cost = new webservices.travelexpense.pdf.CostVO();
				if (addActualCost) {
					newAccomodation.actual_cost.cost = modelAccomodation.actual_cost.cost;
					newAccomodation.actual_cost.cost_currency = modelAccomodation.actual_cost.cost_currency;
					newAccomodation.actual_cost.cost_currency_rate = modelAccomodation.actual_cost.cost_currency_rate;
					
					accomodationList.addTravelAccomodationVO(newAccomodation);
					
				} else {
					// actual cost is not included in calculations, but must be specified in the comments field
					var commentStr:String = ResourceManager.getInstance().getString(model.resources.bundleName, 'accomodation_unauthorized_pdfalert');
					commentStr = Util.searchAndReplace(commentStr, "%1", Util.formatDate(modelAccomodation.fromdate));
					commentStr = Util.searchAndReplace(commentStr, "%2", Util.formatDate(modelAccomodation.todate));
					commentStr = Util.searchAndReplace(commentStr, "%3", modelAccomodation.actual_cost.cost.toString());
					
					var modelComment:no.makingwaves.cust.dss.vo.TravelCommentVO = new no.makingwaves.cust.dss.vo.TravelCommentVO();
					modelComment.comment = commentStr;
					this.extraCommentsList.addItem(modelComment);
				}
			}
			
			return accomodationList;
		}
		
		public function convertTravelDeductions():ArrayOfTravelDeductionVO {
			var deductionList:ArrayOfTravelDeductionVO = new ArrayOfTravelDeductionVO();
			var modelList:ArrayCollection = ModelLocator.getInstance().travelDeductionList;
			for (var i:Number = 0; i < modelList.length; i++) {
				var newDeduction:webservices.travelexpense.pdf.TravelDeductionVO = new webservices.travelexpense.pdf.TravelDeductionVO();
				var modelDeduction:no.makingwaves.cust.dss.vo.TravelDeductionVO = no.makingwaves.cust.dss.vo.TravelDeductionVO(modelList.getItemAt(i));
				newDeduction.date = modelDeduction.date;
				newDeduction.breakfast = modelDeduction.breakfast;
				newDeduction.lunch = modelDeduction.lunch;
				newDeduction.dinner = modelDeduction.dinner;
				newDeduction.cost = new webservices.travelexpense.pdf.CostVO();
				newDeduction.cost.cost = Math.abs(modelDeduction.cost.cost); 
				newDeduction.cost.cost_currency = modelDeduction.cost.cost_currency;
				newDeduction.cost.cost_currency_rate = modelDeduction.cost.cost_currency_rate;
				
				deductionList.addTravelDeductionVO(newDeduction);
			}
			return deductionList;
		}
		
		public function convertTravelOutlays():ArrayOfTravelOutlayVO {
			var outlayList:ArrayOfTravelOutlayVO = new ArrayOfTravelOutlayVO();
			var modelList:ArrayCollection = ModelLocator.getInstance().travelOutlayList;
			for (var i:Number = 0; i < modelList.length; i++) {
				var newOutlay:webservices.travelexpense.pdf.TravelOutlayVO = new webservices.travelexpense.pdf.TravelOutlayVO();
				var modelOutlay:no.makingwaves.cust.dss.vo.TravelOutlayVO = no.makingwaves.cust.dss.vo.TravelOutlayVO(modelList.getItemAt(i));
				//newOutlay.type = modelOutlay.type;
				newOutlay.date = modelOutlay.date;
				newOutlay.specification = modelOutlay.specification;
				newOutlay.cost = new webservices.travelexpense.pdf.CostVO();
				newOutlay.cost.cost = modelOutlay.cost.cost; 
				newOutlay.cost.cost_currency = modelOutlay.cost.cost_currency;
				newOutlay.cost.cost_currency_rate = modelOutlay.cost.cost_currency_rate;
				
				outlayList.addTravelOutlayVO(newOutlay);
			}
			return outlayList;
		}
		
		public function convertTravelAdvances():ArrayOfTravelAdvanceVO {
			var advanceList:ArrayOfTravelAdvanceVO = new ArrayOfTravelAdvanceVO();
			var modelList:ArrayCollection = ModelLocator.getInstance().travelAdvanceList;
			for (var i:Number = 0; i < modelList.length; i++) {
				var newAdvance:webservices.travelexpense.pdf.TravelAdvanceVO = new webservices.travelexpense.pdf.TravelAdvanceVO();
				var modelAdvance:no.makingwaves.cust.dss.vo.TravelAdvanceVO = no.makingwaves.cust.dss.vo.TravelAdvanceVO(modelList.getItemAt(i));
				newAdvance.location = modelAdvance.location;
				newAdvance.date = modelAdvance.date;
				newAdvance.cost = modelAdvance.cost;
				
				advanceList.addTravelAdvanceVO(newAdvance);
			}
			return advanceList;
		}
		
		public function convertTravelComments():ArrayOfTravelCommentVO {
			var commentList:ArrayOfTravelCommentVO = new ArrayOfTravelCommentVO();
			var modelList:ArrayCollection = ModelLocator.getInstance().travelCommentList;
			for (var i:Number = 0; i < modelList.length; i++) {
				var newComment:webservices.travelexpense.pdf.TravelCommentVO = new webservices.travelexpense.pdf.TravelCommentVO();
				var modelComment:no.makingwaves.cust.dss.vo.TravelCommentVO = no.makingwaves.cust.dss.vo.TravelCommentVO(modelList.getItemAt(i));
				newComment.comment = modelComment.comment;
				
				commentList.addTravelCommentVO(newComment);
			}
			for (var e:Number = 0; e < extraCommentsList.length; e++) {
				var newComment:webservices.travelexpense.pdf.TravelCommentVO = new webservices.travelexpense.pdf.TravelCommentVO();
				var modelComment:no.makingwaves.cust.dss.vo.TravelCommentVO = no.makingwaves.cust.dss.vo.TravelCommentVO(extraCommentsList.getItemAt(e));
				newComment.comment = modelComment.comment;
				
				commentList.addTravelCommentVO(newComment);
			}
			return commentList;
		}
		
		
		// resource url collector
		public function getResourceUrl(id:String):String {
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