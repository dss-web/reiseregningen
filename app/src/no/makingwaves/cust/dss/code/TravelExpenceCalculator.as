package no.makingwaves.cust.dss.code
{
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;

	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.view.components.custom_alert;
	import no.makingwaves.cust.dss.vo.CarSpecificationVO;
	import no.makingwaves.cust.dss.vo.MotorboatSpecificationVO;
	import no.makingwaves.cust.dss.vo.MotorcycleSpecificationVO;
	import no.makingwaves.cust.dss.vo.OtherSpecificationVO;
	import no.makingwaves.cust.dss.vo.RateVO;
	import no.makingwaves.cust.dss.vo.TravelAccomodationVO;
	import no.makingwaves.cust.dss.vo.TravelAdvanceVO;
	import no.makingwaves.cust.dss.vo.TravelDeductionVO;
	import no.makingwaves.cust.dss.vo.TravelOutlayVO;
	import no.makingwaves.cust.dss.vo.TravelRateInternationalVO;
	import no.makingwaves.cust.dss.vo.TravelRateRuleVO;
	import no.makingwaves.cust.dss.vo.TravelSpecificationVO;
	import no.makingwaves.cust.dss.vo.TravelVO;
	import no.makingwaves.util.Util;
	import no.makingwaves.util.date.DateRanger;

	public class TravelExpenceCalculator
	{
		[Bindable]
		public var totalExpense : Number = 0.0;

		public function TravelExpenceCalculator() {
		}

		// kalkuler alle kostnader ===========================================================
		public function calculate():Number {
			var totAmount : Number = 0.0;
			totAmount += calculateAllowances();
			totAmount += calculateSpecifications();
			totAmount += calculateAccomodations();
			totAmount += calculateDeductions();
			totAmount += calculateOutlays();
			totAmount += calculateTraveladvances();
			this.totalExpense = totAmount;
			// update allowances-model
			ModelLocator.getInstance().travelAllowance.netamount = Number(totAmount.toFixed(2));

			return totalExpense;
		}

		// kalkuler kostgodtgjørelse =========================================================
		public function calculateAllowances():Number {
			var amount:Number = 0.0;
			var rateRule:TravelRateRuleVO;
			var ratePercent:Number = 0;
			var travelInfo:TravelVO = ModelLocator.getInstance().activeTravel;
			var travelDateInfo:DateRanger = ModelLocator.getInstance().travelLength;
			var days:Number = 1;
			var dailyAllowance:Number;

			ModelLocator.getInstance().travelAllowance.allowance_other.removeAll();
			// update travelallowance accomodation setting
			ModelLocator.getInstance().travelAllowance.accomodation = (travelDateInfo.overnight);

			// domestic or international travel
			if (travelInfo.travel_type == travelInfo.DOMESTIC) {
				// DOMESTIC TRAVEL
				// only travels over 5 hours will get a calculated allowance - any travel below 5 hours must specify manually
				if (travelDateInfo.total_hours > 5 || (travelDateInfo.total_hours == 5 && travelDateInfo.minutes > 0)) {
					rateRule = this.getAllowanceRate(travelInfo, travelDateInfo);
					dailyAllowance = Number(rateRule.cost.toFixed(2));
					// if travel is over more than a day
					if (travelDateInfo.total_hours > 24) {
						days = travelDateInfo.days;
						// for travels over 24 hours, 6 hours or more into a new 24-hour period counts as one 24-hour.
						if (travelDateInfo.hours >= 6) {
							days++;
						}
					}								
					// sum up total allowance for this domestic travel
					var allowance_28days:Number = 0;
					if (days <= 28) {
						amount += Number((dailyAllowance * days).toFixed(2));
					} else {
						amount += Number((dailyAllowance * 28).toFixed(2));
						allowance_28days = Number(((dailyAllowance*0.75) * (days-28)).toFixed(2));
						amount += allowance_28days;
					}

					// update travelallowance
					ModelLocator.getInstance().travelAllowance.domestic = true;
					var allowance:RateVO = new RateVO();
					allowance.num = (days <= 28) ? travelDateInfo.total_hours : (28*24); //days;
					allowance.rate = dailyAllowance;
					allowance.amount = amount;
					ModelLocator.getInstance().travelAllowance.allowance = allowance;
					if (allowance_28days > 0) {
						var allowance28:RateVO = new RateVO();
						allowance28.num = travelDateInfo.total_hours - (28*24);//days - 28;
						allowance28.rate = dailyAllowance * 0.75;
						allowance28.amount = allowance28.num * allowance28.rate;
						ModelLocator.getInstance().travelAllowance.allowance_28days = allowance28;
					}
				}

			} else {
				// INTERNATIONAL TRAVEL
				rateRule = this.getAllowanceRate(travelInfo, travelDateInfo);
				// search and find destinations and period of time on this/these destinations
				amount += calculateInternationalAllowance(rateRule);

				// new rule from 01.03.2009, additonal compensation for travelling abroad
				if (travelDateInfo.total_hours > 12) {
					if (travelDateInfo.total_hours > 24) { 
						days = travelDateInfo.days;
						if (travelDateInfo.hours >= 12) {
							days++;
						}
					} else if (travelDateInfo.total_24hours == 0) {
						days = 1;
					}

					// check the use of the compensation rule
					var nonCompensationDays:int = getNonCompensationDays();
					if (nonCompensationDays < days) {
						// add additional allowance for international travels
						var compensationRule:TravelRateRuleVO = this.getRate("allowance_international");
						var compensation:RateVO = new RateVO();
						compensation.num = days - nonCompensationDays;
						compensation.rate = compensationRule.cost;
						compensation.amount = compensation.num * compensationRule.cost;
						ModelLocator.getInstance().travelAllowance.allowance_other.addItem(compensation);

						amount += compensation.amount;					
					}
				}
			}


			// search and add amounts for admin. allowances
			if (travelDateInfo.total_hours >= 24) {
				var adminNum:Number = 0;
				var deductionList:ArrayCollection = ModelLocator.getInstance().travelDeductionList;
				for (var i:Number = 0; i < deductionList.length; i++) {
					var deduction:TravelDeductionVO = TravelDeductionVO(deductionList.getItemAt(i));
					if (deduction.breakfast && deduction.lunch && deduction.dinner) {
						// all meals are deducted - admin allowance is added
						adminNum++;
					}
				}
				if (adminNum > 0) {
					var admin_allowance:RateVO = new RateVO();
					admin_allowance.num = adminNum;
					if (travelInfo.travel_type == travelInfo.DOMESTIC) {
						admin_allowance.rate = this.getRate("redraw_extra_01").cost;
					} else {
						admin_allowance.rate = this.getRate("redraw_extra_02").cost;
					}
					admin_allowance.amount = admin_allowance.num * admin_allowance.rate;
					ModelLocator.getInstance().travelAllowance.adm_allowance = admin_allowance;

					amount += admin_allowance.amount;
				}
			}

			return amount;
		}


		/*
		 *	Travels from a non-Norway country to Norway should not recieve compensation for international travels
		 *	ticket:60 (https://www.coderesort.com/p/reiseregningen/ticket/60)
		 */
		private function getNonCompensationDays():int {
			var nonDays:int = 0;
			var model:ModelLocator = ModelLocator.getInstance();
			var specificationList:ArrayCollection = model.travelSpecsList;
			var firstSpec:TravelSpecificationVO = specificationList.getItemAt(0) as TravelSpecificationVO;
			var defaultCountry:String = ResourceManager.getInstance().getString(model.resources.bundleName, 'country_default');
			if (firstSpec.from_country.indexOf(defaultCountry) == -1) {
				// travel starts outside Norway, check wether the travel goes to Norway
				var accomodationList:ArrayCollection = model.travelAccomodationList;
				for (var i:int = 0; i < accomodationList.length; i++) {
					var acc:TravelAccomodationVO = accomodationList.getItemAt(i) as TravelAccomodationVO;
					if (acc.country.indexOf(defaultCountry) != -1) {
						// accomocation has occoured in Norway - compensation rule does not apply for these days
						var days:DateRanger = new DateRanger();
						days.getDateRange(acc.fromdate, acc.todate);
						nonDays += days.total_24hours;
					}
				} 
			}
			return nonDays;
		}

		//*******************************************************
		// NEW METHODS FOR CALCULTING INTERNATIONAL ALLOWANCES //
		//*******************************************************

		private function newCalculateInternationalAllowance(rateRule:TravelRateRuleVO, date:Date=null):Number {
			var amount:Number = 0.0;
			var specificationList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;

			// get travel length and add one day if last day exceeds 6 hours
			var travelPeriode:DateRanger = ModelLocator.getInstance().travelLength;
			var num24hours:Number = travelPeriode.total_24hours;
			if (num24hours > 0 && travelPeriode.hours >= 6) { num24hours++; }

			if (travelPeriode.total_min != 0 && specificationList.length > 0) {
				// get 24-hour periodes based on start and end dates 
				var periodes:ArrayCollection;
				var msPerDay:int = 1000 * 60 * 60 * 24;
				var msPerHour:int = 1000 * 60 * 60;
				var timezoneDefault:Number = ModelLocator.getInstance().activeTravel.travel_date_out.timezoneOffset / 60;

				var timeStart:String = ModelLocator.getInstance().activeTravel.travel_time_out;
				var dateStart:Date = new Date();
				dateStart.setTime(ModelLocator.getInstance().activeTravel.travel_date_out.getTime());
				dateStart.setHours(timeStart.substr(0,2), timeStart.substr(2,2));
				dateStart = getUTCTime(dateStart, timezoneDefault);

				var timeStop:String = ModelLocator.getInstance().activeTravel.travel_time_in;
				var dateStop:Date = new Date();
				dateStop.setTime(ModelLocator.getInstance().activeTravel.travel_date_in.getTime());
				dateStop.setHours(timeStop.substr(0,2), timeStop.substr(2,2));
				dateStop = getUTCTime(dateStop, timezoneDefault);

				trace("Total travel period from/to:");
				traceDateAndTime(dateStart)
				traceDateAndTime(dateStop);

				// collect actual 24 hour periodes
				periodes = getPeriodes(dateStart, dateStop);

				// collect travel time on each location
				var travelTime:ArrayCollection = getTravelTimeAtLocations();

				// get the length of each location within each periode
				var locationInPeriodes:ArrayCollection = getLocationForPeriodes(periodes, travelTime);

				// find and calculate rates for each periode
				var daysCalculated:int = 0;
				var allowancesOver28days:RateVO = new RateVO();
				var allowancesInternational:ArrayCollection = new ArrayCollection();
				for (var i:int = 0; i < locationInPeriodes.length; i++) {
					var periode:Object = locationInPeriodes.getItemAt(i) as Object;
					var useForRates:Object = null;
					if (periode.locations.length > 1) {
						for (var r:int = 0; r < periode.locations.length; r++) {
							if (periode.locations[r].intermediate_landing != true) {
								if (useForRates == null) {
									useForRates = periode.locations[r];
								} else {
									if (periode.locations[r].time > useForRates.time) {
										useForRates = periode.locations[r];
									}
								}
							}
						}
					} else {
						useForRates = periode.locations[0];
					}
					if (useForRates == null) {
						// all periodes are marked as intermediate landings, use last registered periode for rates
						useForRates = periode.locations[periode.locations.length-1];
					}

					var allowanceToday:Number = getAllowanceForLocation(useForRates, rateRule);
					//daysCalculated++;

					var allowanceToAdd:ArrayCollection = new ArrayCollection();
					allowanceToAdd.addItem(allowanceToday);

					// check for last periode, may not be included in location-loop due to not a full 24 hour periode
					if ((i+1) == locationInPeriodes.length && periodes.length > locationInPeriodes.length) {
						if (travelPeriode.total_24hours == locationInPeriodes.length && travelPeriode.hours >= 6) {
							if (date == null) {
								allowanceToAdd.addItem(allowanceToday);
							}
						}
					}

					// add allowance(s)
					for (var a:int = 0; a < allowanceToAdd.length; a++) {
						daysCalculated++;
						var dailyAllowance:Number = allowanceToAdd.getItemAt(a) as Number;
						if (daysCalculated > 28) {
							// calculation for over 28 days - reduce allowance with 25%
							dailyAllowance = Number((dailyAllowance*0.75).toFixed(2));
						}
						trace("-------------------");
						trace("Allowance for day " + daysCalculated + ": " + Util.formatDate(dateStart) + "-" + Util.formatDate(dateStop) + ": " + dailyAllowance + ",- (" + useForRates.country + ", " + useForRates.city + ")");

						if (date != null) {
							var testDate:Date = new Date(getUTCTime(date, timezoneDefault));
							testDate.setHours(periode.start.hours, periode.start.minutes, periode.start.seconds);
							// if date is specified in method - return only value for this date
							if (testDate.getTime() >= periode.start.getTime() && testDate.getTime() <= periode.end.getTime()) {
								trace("Single allowance for " + Util.formatDate(testDate) + " is " + dailyAllowance);
								return dailyAllowance;
							}
						}

						// add/update to the allowance model
						var added:Boolean = false;
						if (daysCalculated > 28) {
							// calculation for over 28 days
							allowancesOver28days.num = daysCalculated - 28;
							allowancesOver28days.rate = dailyAllowance;
							allowancesOver28days.amount += dailyAllowance;

						} else {
							// normal calculation
							for (var m:int=0; m < allowancesInternational.length; m++) {
								var allInt:RateVO = allowancesInternational.getItemAt(m) as RateVO;
								if (allInt.rate == dailyAllowance) {
									allInt.num++;
									allInt.amount = Number((allInt.rate * allInt.num).toFixed(2));
									added = true;
									break;
								}
							}
							if (!added) {
								var allowance:RateVO = new RateVO();
								allowance.rate = dailyAllowance;
								if (!travelPeriode.overnight) {
									allowance.num = travelPeriode.total_hours;
								} else {
									allowance.num = 1;
								}
								allowance.amount = dailyAllowance;
								allowancesInternational.addItem(allowance);
							}
						}
					}
				}

				// update allowance model if this is not a 'date only' calculation
				if (date == null) {
					ModelLocator.getInstance().travelAllowance.allowance_international = allowancesInternational;
					ModelLocator.getInstance().travelAllowance.allowance_28days = allowancesOver28days;					
				}

				// calculate amount
				for (var a:int = 0; a < allowancesInternational.length; a++) {
					amount += RateVO(allowancesInternational.getItemAt(a)).amount;
					amount += allowancesOver28days.amount;
				}
			}

			return amount;
		}

		private function getAllowanceForLocation(location:Object, rateRule:TravelRateRuleVO):Number {
			var intRate:TravelRateInternationalVO;
			try {
				intRate = this.getInternationalRate(location.country, location.city);
			} catch (e:Error) { intRate = null; }
			if (intRate == null) {
				// active 'rate' is in home country - find domestic rate 
				intRate = new TravelRateInternationalVO();
				var travelInfo:DateRanger = ModelLocator.getInstance().travelLength;
				var localRate:TravelRateRuleVO;
				if (travelInfo.total_hours >= 12 && travelInfo.overnight) {
					localRate = getRate("allowance_04b"); 

				} else if (travelInfo.total_hours > 12) {
					localRate = getRate("allowance_04a");

				} else {
					localRate = getRate("allowance_03");
				}
				intRate.country = location.country;
				intRate.city = location.city;
				intRate.allowance = localRate.cost;
			}
			return Number(((intRate.allowance * rateRule.percent) / 100).toFixed(2));
		}

		private function getLocationForPeriodes(periodes:ArrayCollection, travelTimes:ArrayCollection):ArrayCollection {
			var locations:ArrayCollection = new ArrayCollection();
			var totalTripTime:Number = 0;
			var travelInfo:DateRanger = ModelLocator.getInstance().travelLength;
			var timePer24:Number = 60 * 24 // minutes in 24 hours

			var rememberLocation:Object;
			var periodeLocation:Object = new Object();
			periodeLocation.time = 0;
			// prepare to register locations within a periode
			for (var i:int = 0; i < periodes.length; i++) {
				trace("----------------------------------------");
				var timeSpent:Number = periodeLocation.time;
				var periode:Object = periodes.getItemAt(i);
				periode.locations = new Array();

				for (var t:int = 0; t < travelTimes.length; t++) {
					var loc:Object = travelTimes.getItemAt(t) as Object;
					var addTime:Boolean = false;

					if (periodeLocation.country == null && loc.time > 0) {
						// no location is registered
						if (t == 0 && i == 0) {
							// first location - use destination as location
							periodeLocation.country = loc.stopCountry;
							periodeLocation.city = loc.stopCity;
							periodeLocation.intermediate_landing = loc.periodeLocation;

						} else {
							// any other location - use departure as location
							periodeLocation.country = loc.startCountry;
							periodeLocation.city = loc.startCity;
							periodeLocation.intermediate_landing = loc.intermediate_landing;
						}
						addTime = true;

					} else if (periodeLocation.country != null && loc.time > 0) {
						// registration has started - continue registering time
						if ( loc.startCountry == periodeLocation.country &&
							loc.startCity == periodeLocation.city ) {

							if (loc.intermediate_landing) {
								periodeLocation.intermediate_landing = loc.intermediate_landing;
							}
							// location is still the same - just add time
							addTime = true;

						} else {
							// new location spotted -> save last location
							trace("PERIOD " + (i+1) + ": " + periodeLocation.country + "/" + periodeLocation.city + ": " + periodeLocation.time + " min - (mellomlanding: " + periodeLocation.intermediate_landing + ")");
							periode.locations.push(periodeLocation);
							// reset and start new location
							periodeLocation = new Object();
							periodeLocation.time = 0;
							periodeLocation.country = loc.startCountry;
							periodeLocation.city = loc.startCity;
							periodeLocation.intermediate_landing = loc.intermediate_landing;
							addTime = true;
						}

					}
					if (addTime) {
						// add time to spent on location
						var timeToAdd:Number;
						if ((timeSpent+loc.time) > timePer24) {
							timeToAdd = timePer24 - timeSpent;
						} else {
							timeToAdd = loc.time;
						}
						timeSpent += timeToAdd;
						totalTripTime += timeToAdd;
						periodeLocation.time += timeToAdd;
						loc.time -= timeToAdd;

					}

					var addPeriod:Boolean = false;
					if (travelInfo.total_min == totalTripTime && totalTripTime < timePer24) {
						// short trip (under 24 hours)
						addPeriod = true;
					}

					// check if period is completely registered
					if (timeSpent == timePer24 || addPeriod) {
						// this 24-hours periode is registered - add it to periode list
						trace("PERIOD " + (i+1) + ": " + periodeLocation.country + "/" + periodeLocation.city + ": " + periodeLocation.time + " min - (mellomlanding: " + periodeLocation.intermediate_landing + ")");
						var regPeriode:Object = periodeLocation;
						periode.locations.push(regPeriode);
						locations.addItem(periode);
						if (rememberLocation != null) {
							loc = rememberLocation;
							rememberLocation = null;
						}
						if (loc.time > 0) {
							rememberLocation = loc;
							// register time for next periode							
							var nextPerTime:Number = (loc.time > timePer24) ? timePer24 : loc.time;
							periodeLocation = new Object();
							periodeLocation.time = nextPerTime;
							periodeLocation.country = regPeriode.country;
							periodeLocation.city = regPeriode.city;
							timeSpent = nextPerTime;
							totalTripTime += nextPerTime;

							rememberLocation.time -= nextPerTime;

						} else {
							periodeLocation = new Object();
							periodeLocation.time = 0;
						}
						// break out of loop to continue on next 24-hour period
						break;

					} else if (travelInfo.total_min == totalTripTime) {
						if (periode.locations.length > 0)
							locations.addItem(periode);

						break;
					}
				}
			}

			return locations;
		}

		private function getTravelTimeAtLocations():ArrayCollection {
			var specificationList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;
			var timeTable:ArrayCollection = new ArrayCollection();
			var location:Object = new Object();
			var currentLocation:Object = new Object();
			var intermediate_landing:Boolean = false;
			var notRegTime:Number = 0;
			for (var i:int = 0; i < specificationList.length; i++) {
				// get specification
				var spec:TravelSpecificationVO = specificationList.getItemAt(i) as TravelSpecificationVO;

				// collect and convert date and time
				var startDate:Date = new Date(spec.from_date);
				startDate.setHours( Number(spec.from_time.substr(0,2)), Number(spec.from_time.substr(2,2)) );
				startDate = this.getUTCTime(startDate, spec.from_timezone);

				var stopDate:Date = new Date(spec.to_date);
				stopDate.setHours( Number(spec.to_time.substr(0,2)), Number(spec.to_time.substr(2,2)) );
				stopDate = this.getUTCTime(stopDate, spec.to_timezone);

				// find time spent on location
				if (currentLocation.startTime == null) {
					// no time registered - look for start time
					currentLocation.startCountry = spec.from_country;
					currentLocation.startCity = spec.from_city;
					currentLocation.startTime = startDate.getTime();
				}

				// check if current stoptime is on other location
				if ((currentLocation.startTime != null) && (currentLocation.startCountry != spec.to_country || currentLocation.startCity != spec.to_city || spec.intermediate_landing)) {
					currentLocation.stopCountry = spec.to_country;
					currentLocation.stopCity = spec.to_city;
					currentLocation.stopTime = stopDate.getTime();
					currentLocation.time = (currentLocation.stopTime - currentLocation.startTime) / 1000 / 60; // in minutes
					//currentLocation.intermediate_landing = false;

					if (spec.transportation_type == TravelSpecificationVO.TRANSPORT_AIRPLANE) {
						// check wether this could be a intermediate landing connection
						if (i < (specificationList.length-1)) {
							// this is not the last specification - check wether next specification is using a plane
							var nextSpec:TravelSpecificationVO = specificationList.getItemAt(i+1) as TravelSpecificationVO;
							if (nextSpec.transportation_type == TravelSpecificationVO.TRANSPORT_AIRPLANE) {
								// next spec is also using plane - tag current as intermediate landing
								intermediate_landing = true;
							}
						}
					}

					var debugIntermediateLandingStr:String = (currentLocation.intermediate_landing) ? "-> mellomlanding" : "";
					trace(currentLocation.startCountry + "/" + currentLocation.startCity + ": " + currentLocation.time + " min " + debugIntermediateLandingStr);

					// add location to timetable
					timeTable.addItem(currentLocation);

					// reset currentLocation and register start of new journey
					currentLocation = new Object();
					currentLocation.startCountry = spec.to_country;
					currentLocation.startCity = spec.to_city;
					currentLocation.startTime = stopDate.getTime();
					currentLocation.intermediate_landing = intermediate_landing;

					// reset intermediate landing checker
					intermediate_landing = false;
					notRegTime = 0;

				} else {
					var leftOverStart:Number = startDate.getTime();
					if (currentLocation) {
						if (currentLocation.startTime)
							leftOverStart = currentLocation.startTime;
					}
					notRegTime += (stopDate.getTime() - leftOverStart) / 1000 / 60;
				}
			}
			if (notRegTime > 0)
				timeTable.getItemAt(timeTable.length-1).time += notRegTime;

			return timeTable;
		}

		/*
		 *	extends the periode object with a destination list .destinations
		 *	the list concists of objects with .country, .city, .startDate, .endDate, .time variables
		 */
		private function addDestinationToPeriod(spec:TravelSpecificationVO, timeSpan:Number, periode:Object, fromDest:Boolean):Object {
			if (periode.destinations == null)
				periode.destinations = new Array();

			// check wether destination has been registered before
			var addedToExisting:Boolean = false;
			for (var i:int = 0; i < periode.destinations.length; i++) {
				var dest:Object = periode.destinations[i];
				if ( (fromDest && dest.country == spec.from_country && dest.city == spec.from_city) ||
					(!fromDest && dest.country == spec.to_country && dest.city == spec.to_city) ) {

					dest.time += timeSpan;
					addedToExisting = true;	
				}
			}	
			if (!addedToExisting) {
				var newDest:Object = new Object();
				newDest.country = (fromDest) ? spec.from_country : spec.to_country;
				newDest.city = (fromDest) ? spec.from_city : spec.to_city;
				newDest.time = timeSpan;
				periode.destinations.push(newDest);
			}

			return periode;
		}

		/*
		 * 	return a list of period objects defined with a .start date and an .end date
		 */
		private function getPeriodes(startDate:Date, stopDate:Date):ArrayCollection {
			var periodes:ArrayCollection = new ArrayCollection();
			var msPerDay:int = 1000 * 60 * 60 * 24;
			var msPerHour:int = 1000 * 60 * 60;

			var startTime:Date = new Date(startDate);
			var endTime:Date = new Date(startDate);
			while (endTime.getTime() < stopDate.getTime()) {
				var dateObj:Object = new Object();
				dateObj.start = startTime;
				endTime = new Date();
				endTime.setTime(startTime.getTime() + msPerDay);
				if (endTime.getTime() > stopDate.getTime())
					endTime.setTime(stopDate.getTime());
				dateObj.end = endTime;
				periodes.addItem(dateObj);
				trace("Period " + (periodes.length) + ": ");
				traceDateAndTime(periodes[periodes.length-1].start);
				traceDateAndTime(periodes[periodes.length-1].end);
				startTime = endTime;
			}

			return periodes;
		}

		private function getUTCTime(date:Date, offset:Number):Date {
			var msPerHour:int = 1000 * 60 * 60;
			var utcDate:Date = new Date(date);
			utcDate.setTime(utcDate.getTime() - (offset*msPerHour));
			return utcDate;
		}

		private function traceDateAndTime(date:Date):void {
			trace(date.getDate() + "/" + date.getMonth() + "/" + date.getFullYear() + " " + date.toTimeString());
		}

		//*******************************************************
		//*******************************************************

		private function calculateInternationalAllowance(rateRule:TravelRateRuleVO, date:Date=null):Number {

			return newCalculateInternationalAllowance(rateRule, date);

		/*
		   var amount:Number = 0.0;
		   var days:Number = 1;
		   var dailyAllowance:Number;
		   var intRate:TravelRateInternationalVO;
		   var prevIntRate:TravelRateInternationalVO;
		   var specificationList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;
		   var startDistance:TravelSpecificationVO;
		   var endDistance:TravelSpecificationVO;
		   var nextDistance:TravelSpecificationVO;
		   var allowancesInternational:ArrayCollection = new ArrayCollection();
		   var allowancesOver28days:RateVO = new RateVO();

		   // get travel length and add one day if last day exceeds 6 hours
		   var travelPeriode:DateRanger = ModelLocator.getInstance().travelLength;
		   var num24hours:Number = travelPeriode.total_24hours;
		   if (num24hours > 0 && travelPeriode.hours >= 6) { num24hours++; }

		   if (travelPeriode.total_min != 0 && specificationList.length > 0) {
		   // set start date and first periode
		   var msPerDay:int = 1000 * 60 * 60 * 24;
		   var msPerHour:int = 1000 * 60 * 60;
		   var timeStart:String = ModelLocator.getInstance().activeTravel.travel_time_out;
		   var dateStart:Date = new Date();
		   dateStart.setTime(ModelLocator.getInstance().activeTravel.travel_date_out.getTime());
		   dateStart.setHours(timeStart.substr(0,2), timeStart.substr(2,2));
		   var dateStop:Date = new Date();
		   dateStop.setTime(dateStart.getTime() + msPerDay);
		   // set dates to UTC-time
		   var timezoneDefault:Number = ModelLocator.getInstance().activeTravel.travel_date_out.timezoneOffset / 60;
		   dateStart.setTime(dateStart.getTime() + (timezoneDefault*msPerHour));
		   dateStop.setTime(dateStop.getTime() + (timezoneDefault*msPerHour));
		   trace("Start time: " + dateStart.toDateString() + " " + dateStart.toTimeString());
		   trace("Stop time : " + dateStop.toDateString() + " " + dateStop.toTimeString());

		   var lastLocationObject:Object;
		   var lastRateUsedObject:Object;
		   var daysCalculated:int = 0;
		   // for each 24-hour day, check which international rate that should be used
		   if (num24hours == 0) { num24hours = 1; }
		   for (var i:int=0; i < num24hours; i++) {
		   trace("UTREGNING FOR DØGN NR " + (i+1) + " av " + num24hours);
		   trace("fra: " + dateStart.toDateString() + " " + dateStart.toTimeString());
		   trace("til: " + dateStop.toDateString() + " " + dateStop.toTimeString());
		   //trace("check between " + Util.formatDate(dateStart) + " - " + Util.formatDate(dateStop));
		   var timeFrameSpecs:ArrayCollection = new ArrayCollection();
		   // get spesifications within current timeframe
		   for (var s:int = 0; s < specificationList.length; s++) {
		   var spec:TravelSpecificationVO = specificationList.getItemAt(s) as TravelSpecificationVO;
		   var fromDate:Date = new Date();
		   var toDate:Date = new Date()
		   fromDate.setTime(spec.from_date.getTime() + (spec.from_timezone*msPerHour));
		   toDate.setTime(spec.to_date.getTime() + (spec.to_timezone*msPerHour));

		   if (fromDate >= dateStart && fromDate < dateStop) {
		   timeFrameSpecs.addItem(spec);
		   trace("--> add spec: from " + spec.from_city + " " + spec.to_city);

		   } else if (toDate >= dateStart && toDate <= dateStop) {
		   timeFrameSpecs.addItem(spec);
		   trace("--> add spec: from " + spec.from_city + " " + spec.to_city);
		   }
		   }
		   // get each country timeframe based on specs between timeframe
		   var activeLocation:Object = null;
		   var locationList:ArrayCollection = new ArrayCollection();
		   var specStartDate:Date = new Date();
		   var specStopDate:Date = new Date();
		   var activeCity:String = "";
		   var specFromCity:String = "";
		   var specToCity:String = "";
		   for (var t:int = 0; t < timeFrameSpecs.length; t++) {
		   var spec:TravelSpecificationVO = timeFrameSpecs.getItemAt(t) as TravelSpecificationVO;
		   var testTravelEnd:Boolean = true;
		   if (activeLocation == null) {
		   activeLocation = null;
		   activeLocation = new Object();
		   activeLocation.country = spec.from_country.split("#")[0];
		   activeLocation.city = (spec.from_city == "-") ? "" : spec.from_city;
		   activeLocation.intermediate_landing = spec.intermediate_landing;
		   specStartDate.setTime(spec.from_date.getTime() - (spec.from_timezone*msPerHour));
		   activeLocation.startDate = (specStartDate.getTime() > dateStart.getTime()) ? specStartDate : dateStart;

		   } else {
		   activeCity = activeLocation.city;
		   specFromCity = (spec.from_city == "-") ? "" : spec.from_city;
		   specToCity = (spec.to_city == "-") ? "" : spec.to_city;
		   if (activeLocation.country != spec.from_country.split("#")[0] || (activeCity != specFromCity)) {
		   specStopDate.setTime(spec.to_date.getTime() - (spec.to_timezone*msPerHour));
		   activeLocation.stopDate = (specStopDate.getTime() < dateStop.getTime()) ? specStopDate : dateStop;;
		   locationList.addItem(activeLocation);
		   //trace(" -> location added: " + activeLocation.country + ", " + activeLocation.city);
		   specStartDate = new Date();
		   specStopDate = new Date();
		   activeLocation = null;
		   activeLocation = new Object();
		   activeLocation.country = spec.from_country.split("#")[0];
		   activeLocation.city = (spec.from_city == "-") ? "" : spec.from_city;
		   activeLocation.intermediate_landing = spec.intermediate_landing;
		   specStartDate.setTime(spec.from_date.getTime() - (spec.from_timezone*msPerHour));
		   activeLocation.startDate = (specStartDate.getTime() > dateStart.getTime()) ? specStartDate : dateStart;

		   } else if (activeLocation.country != spec.to_country.split("#")[0] || activeCity != specToCity) {
		   specStopDate.setTime(spec.to_date.getTime() - (spec.to_timezone*msPerHour));
		   activeLocation.stopDate = (specStopDate.getTime() < dateStop.getTime()) ? specStopDate : dateStop;
		   locationList.addItem(activeLocation);
		   //trace(" -> location added: " + activeLocation.country + ", " + activeLocation.city);
		   specStartDate = new Date();
		   specStopDate = new Date();
		   activeLocation = null;
		   activeLocation = new Object();
		   activeLocation.country = spec.to_country.split("#")[0];
		   activeLocation.city = (spec.to_city == "-") ? "" : spec.to_city;
		   activeLocation.intermediate_landing = spec.intermediate_landing;
		   specStartDate.setTime(spec.from_date.getTime() - (spec.from_timezone*msPerHour));
		   activeLocation.startDate = (specStartDate.getTime() > dateStart.getTime()) ? specStartDate : dateStart;
		   testTravelEnd = false;

		   }
		   }

		   specFromCity = (spec.from_city == "-") ? "" : spec.from_city;
		   specToCity = (spec.to_city == "-") ? "" : spec.to_city;
		   if ((activeLocation != null && testTravelEnd && (spec.from_country.split("#")[0] != spec.to_country.split("#")[0] || specFromCity != specToCity)) ||
		   (activeLocation != null && t == (timeFrameSpecs.length-1))) {
		   // current country rate has reached its end - register it
		   specStopDate.setTime(spec.to_date.getTime() - (spec.to_timezone*msPerHour));
		   activeLocation.stopDate = (specStopDate.getTime() < dateStop.getTime()) ? specStopDate : dateStop;
		   locationList.addItem(activeLocation);
		   if (t != (timeFrameSpecs.length)) {
		   //if (specStopDate.getTime() < dateStop.getTime()) {
		   activeLocation = new Object();
		   activeLocation.country = spec.to_country.split("#")[0];
		   activeLocation.city = (spec.to_city == "-") ? "" : spec.to_city;
		   activeLocation.intermediate_landing = spec.intermediate_landing;
		   activeLocation.startDate = specStopDate;
		   activeLocation.stopDate = dateStop;
		   locationList.addItem(activeLocation);
		   //}
		   }


		   //trace(" -> location added: " + activeLocation.country + ", " + activeLocation.city);
		   specStartDate = new Date();
		   specStopDate = new Date();
		   activeLocation = null;
		   }
		   }
		   // find the correct country/city based on the longest timeframe
		   var maxTimeframe:Number = 0;
		   var maxTimeframeObject:Object;
		   if ((locationList.length == 0 || (i+1) == num24hours) && (lastLocationObject != null || lastRateUsedObject != null)) {
		   // no specification in this timeframe, use last visited country
		   maxTimeframeObject = lastLocationObject;

		   //}
		   } else {
		   // create new array that holds no duplicates
		   var newLocationList:ArrayCollection = new ArrayCollection();
		   // update locationlist with travel length
		   for (var l:int=0; l < locationList.length; l++) {
		   var ranger:DateRanger = new DateRanger();
		   ranger.getDateRange(locationList.getItemAt(l).startDate, locationList.getItemAt(l).stopDate);

		   var add:Boolean = true;
		   locationList.getItemAt(l).total_min = ranger.total_min;
		   locationList.getItemAt(l).overnight = ranger.overnight;
		   for (var n:int=0; n < newLocationList.length; n++) {
		   if (locationList.getItemAt(l).country == newLocationList.getItemAt(n).country && locationList.getItemAt(l).city == newLocationList.getItemAt(n).city) {
		   newLocationList.getItemAt(n).total_min += locationList.getItemAt(l).total_min;
		   if (!newLocationList.getItemAt(n).overnight) {
		   newLocationList.getItemAt(n).overnight = locationList.getItemAt(l).overnight
		   }
		   //if (!locationList.getItemAt(l).intermediate_landing) {
		   // last distance counts, update any intermediate landing parameter
		   newLocationList.getItemAt(n).intermediate_landing = locationList.getItemAt(l).intermediate_landing;
		   //}
		   add = false;
		   break;
		   }
		   }
		   if (add) {
		   newLocationList.addItem(locationList.getItemAt(l));
		   }
		   }
		   // find area with the longest stay
		   for (l = 0; l < newLocationList.length; l++) {
		   trace(newLocationList.getItemAt(l).country + ", (" + newLocationList.getItemAt(l).city + "): " + newLocationList.getItemAt(l).total_min + " minutes");
		   if (newLocationList.getItemAt(l).total_min > maxTimeframe) {
		   // check wether new total time is domestic
		   if ( (this.getInternationalRate(newLocationList.getItemAt(l).country, newLocationList.getItemAt(l).city) != null || newLocationList.getItemAt(l).overnight)
		   && (!newLocationList.getItemAt(l).intermediate_landing)) {

		   maxTimeframe = newLocationList.getItemAt(l).total_min;
		   maxTimeframeObject = newLocationList.getItemAt(l);
		   }
		   }
		   }
		   }
		   // get the rate
		   try {
		   intRate = this.getInternationalRate(maxTimeframeObject.country, maxTimeframeObject.city);
		   } catch (e:Error) { intRate = null; }
		   if (intRate == null) {
		   // active 'rate' is in home country - find domestic rate
		   intRate = new TravelRateInternationalVO();
		   var travelInfo:DateRanger = ModelLocator.getInstance().travelLength;
		   var localRate:TravelRateRuleVO;
		   if (travelInfo.total_hours >= 12 && travelInfo.overnight) {
		   localRate = getRate("allowance_04b");

		   } else if (travelInfo.total_hours > 12) {
		   localRate = getRate("allowance_04a");

		   } else {
		   localRate = getRate("allowance_03");
		   }
		   intRate.country = maxTimeframeObject.country;
		   intRate.city = maxTimeframeObject.city;
		   intRate.allowance = localRate.cost;
		   }
		   dailyAllowance = Number(((intRate.allowance * rateRule.percent) / 100).toFixed(2));
		   daysCalculated++;

		   if (daysCalculated > 28) {
		   // calculation for over 28 days - reduce allowance with 25%
		   dailyAllowance = Number((dailyAllowance*0.75).toFixed(2));
		   }
		   trace("Allowance for day " + daysCalculated + ": " + Util.formatDate(dateStart) + "-" + Util.formatDate(dateStop) + ": " + dailyAllowance + ",- (" + maxTimeframeObject.country + ", " + maxTimeframeObject.city + ")");

		   if (date != null) {
		   // if date is specified in method - return only value for this date
		   if (Util.formatDate(date) == Util.formatDate(dateStart)) {
		   return dailyAllowance;
		   }
		   }

		   // add/update to the allowance model
		   var added:Boolean = false;
		   if (daysCalculated > 28) {
		   // calculation for over 28 days
		   allowancesOver28days.num = daysCalculated - 28;
		   allowancesOver28days.rate = dailyAllowance;
		   allowancesOver28days.amount += dailyAllowance;

		   } else {
		   // normal calculation
		   for (var m:int=0; m < allowancesInternational.length; m++) {
		   var allInt:RateVO = allowancesInternational.getItemAt(m) as RateVO;
		   if (allInt.rate == dailyAllowance) {
		   allInt.num++;
		   allInt.amount = Number((allInt.rate * allInt.num).toFixed(2));
		   added = true;
		   break;
		   }
		   }
		   if (!added) {
		   var allowance:RateVO = new RateVO();
		   allowance.rate = dailyAllowance;
		   if (!travelPeriode.overnight) {
		   allowance.num = travelPeriode.total_hours;
		   } else {
		   allowance.num = 1;
		   }
		   allowance.amount = dailyAllowance;
		   allowancesInternational.addItem(allowance);
		   }
		   }

		   // get ready to find rates for the next 24-hour day
		   dateStart.setTime(dateStop.getTime());
		   dateStop.setTime(dateStart.getTime() + msPerDay);
		   if (locationList.length > 0) {
		   if (maxTimeframeObject != null) {
		   lastRateUsedObject = maxTimeframeObject;
		   }
		   lastLocationObject = locationList.getItemAt(locationList.length-1);
		   }
		   }

		   // update allowance model if this is not a 'date only' calculation
		   if (date == null) {
		   ModelLocator.getInstance().travelAllowance.allowance_international = allowancesInternational;
		   ModelLocator.getInstance().travelAllowance.allowance_28days = allowancesOver28days;
		   }

		   // calculate amount
		   for (var a:int = 0; a < allowancesInternational.length; a++) {
		   amount += RateVO(allowancesInternational.getItemAt(a)).amount;
		   amount += allowancesOver28days.amount;
		   }
		   }

		   return amount;
		 */
		}

		private function getAllowanceRate(travelInfo:TravelVO, travelDateInfo:DateRanger, forDeduction:Boolean=false):TravelRateRuleVO {
			var rateName:String = "allowance";
			if (travelInfo.travel_type == travelInfo.DOMESTIC) {
				// DOMESTIC TRAVEL
				if ((travelDateInfo.total_hours >= 12 && travelDateInfo.overnight) || (travelDateInfo.total_hours > 0 && forDeduction)) {
					// travel longer than 12 hours ( with accomodation ) OR if over 12 hours when getting allowance for deductions
					rateName += "_04b";

				} else if (travelDateInfo.total_hours >= 12) {
					// travel longer than 12 hours
					rateName += "_04a";

				} else if (travelDateInfo.total_hours >= 9 && travelDateInfo.total_hours < 12) {
					// travel periode between 9 and 12 hours
					rateName += "_03";

				} else if (travelDateInfo.total_hours >= 5 && travelDateInfo.total_hours < 9) {
					// travel periode between 5 and 9 hours
					rateName += "_02";

				} else if (travelDateInfo.total_hours < 5) {
					// travel time less than 5 hours
					rateName += "_01";
				}

			} else {
				// INTERNATIONAL TRAVEL
				if (travelDateInfo.total_hours >= 6 && travelDateInfo.total_hours < 12 && !forDeduction) {
					// travel periode between 6 and 12 hours
					rateName += "_05";

				} else if (travelDateInfo.total_hours >= 12 || forDeduction) {
					// travel longer than 12 hours or when calculation deductions
					rateName += "_06";
				}
			}
			return getRate(rateName);
		}

		public function getDailyAllowance(date:Date, forDeduction:Boolean=false):Number {
			var amount:Number = 0.0;
			var travelInfo:TravelVO = ModelLocator.getInstance().activeTravel;
			var travelDateInfo:DateRanger = ModelLocator.getInstance().travelLength;

			if (travelInfo.travel_type == travelInfo.DOMESTIC) {
				// domestic travel, calculate daily allowance based on travellength and totalt allowance
				var days:Number = 1;
				var totaltAllowance:Number = this.calculateAllowances();
				// if travel is over more than a day
				if (travelDateInfo.total_hours > 24) {
					days = travelDateInfo.days;
					// for travels over 24 hours, 6 hours or more into a new 24-hour period counts as one 24-hour.
					if (travelDateInfo.hours >= 6) { days++; }
				}
				amount = totaltAllowance / days;

			} else {
				// internation travel, calculation must check period of time and location
				var rateRule:TravelRateRuleVO = this.getAllowanceRate(travelInfo, travelDateInfo, forDeduction);
				amount = this.calculateInternationalAllowance(rateRule, date);
			}

			return amount;
		}

		// kalkuler reisespesifikasjoner og reiseutlegg ======================================
		public function calculateSpecifications():Number {
			var amount:Number = 0.0;
			var specificationList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;
			for (var i:Number = 0; i < specificationList.length; i++) {
				amount += calculateSpecification(TravelSpecificationVO(specificationList.getItemAt(i)));
			}

			// update allowance parameters for car specifications
			calculateCarAllowances();

			return amount;
		}

		public function calculateSpecification(specification:TravelSpecificationVO):Number {
			var cost:Number = 0.0;
			var type:String = (specification.specification != null) ? specification.specification.type : "ticket";
			switch(type) {
				case "car":
				case "motorcycle":
				case "motorboat":
				case "other":
					cost = calculateOwnVehicle(specification);
					break;
				case "ticket":
					cost = Number(specification.cost.getCost());
					break;
			}

			return cost;
		}

		private function calculateOwnVehicle(specification:TravelSpecificationVO):Number {
			var cost:Number = 0.0;
			var distance:Number;
			var rateRule:TravelRateRuleVO;
			var passengerGeneralRate:TravelRateRuleVO = getRate("transport_passenger_extra_01");
			var rateRuleName:String = "transport_";
			// find correct rate rule
			switch(specification.specification.type) {
				case "other":
					var otherSpec:OtherSpecificationVO = OtherSpecificationVO(specification.specification);
					switch(otherSpec.other_type) {
					case otherSpec.TYPE_EL_CAR:
						rateRuleName += "el-car_01"; break;
					case otherSpec.TYPE_SNOWMOBILE:
						rateRuleName += "snowmobile_01"; break;
					case otherSpec.TYPE_OTHER:
						rateRuleName += "other_01"; break;
				}
					distance = otherSpec.distance;
					break;

				default:
					rateRuleName += specification.specification.type;
					break;
			}

			if (specification.specification.type == "car") {
				var detailsCar:CarSpecificationVO = CarSpecificationVO(specification.specification);
				distance = detailsCar.distance;
				if (detailsCar.distance_calender == detailsCar.TYPE_ABOVE_9000KM) {
					rateRuleName += "_02";
				} else if (detailsCar.distance_calender == detailsCar.TYPE_BELOW_9000KM) {
					rateRuleName += "_01";
				}

				// check for additional car rates
				if (detailsCar.additional_workplace) {
					var workplaceRate:TravelRateRuleVO = getRate("transport_car_extra_01");
					cost += distance * workplaceRate.cost;
				}
				if (detailsCar.passengers > 0) {
					var passengerRate:TravelRateRuleVO = getRate("transport_car_extra_02");
					cost += (distance * passengerRate.cost) * detailsCar.passengers;
				}
				if (detailsCar.additional_trailer) {
					var trailerRate:TravelRateRuleVO = getRate("transport_car_extra_03");
					cost += distance * trailerRate.cost;
				}
				if (detailsCar.distance_forestroad > 0) {
					var forrestRate:TravelRateRuleVO = getRate("transport_car_extra_04");
					cost += detailsCar.distance * forrestRate.cost;
				}

			} else if (specification.specification.type == "motorcycle") {
				var detailsMotorcycle:MotorcycleSpecificationVO = MotorcycleSpecificationVO(specification.specification);
				distance = detailsMotorcycle.distance;
				if (detailsMotorcycle.motorcycle_type == detailsMotorcycle.TYPE_ABOVE_125CC) {
					rateRuleName += "_01";
				} else if (detailsMotorcycle.motorcycle_type == detailsMotorcycle.TYPE_BELOW_125CC) {
					rateRuleName += "_02";
				}

				// check for additional transport rates
				if (detailsMotorcycle.passengers > 0) {
					cost += (distance * passengerGeneralRate.cost) * detailsMotorcycle.passengers;
				}

			} else if (specification.specification.type == "motorboat") {
				var detailsMotorboat:MotorboatSpecificationVO = MotorboatSpecificationVO(specification.specification);
				distance = detailsMotorboat.distance;
				if (detailsMotorboat.motorboat_type == detailsMotorboat.TYPE_ABOVE_50HK) {
					rateRuleName += "_01";
				} else if (detailsMotorboat.motorboat_type == detailsMotorboat.TYPE_BELOW_50HK) {
					rateRuleName += "_02";
				}

				// check for additional transport rates
				if (detailsMotorboat.passengers > 0) {
					cost += (distance * passengerGeneralRate.cost) * detailsMotorboat.passengers;
				}

			}
			// calculate main rate
			rateRule = this.getRate(rateRuleName);
			cost += distance * rateRule.cost;
			/*
			   if (specification.specification.type == "car") {
			   // update specification with correct rate
			   detailsCar.rate = rateRule.cost;
			   detailsCar.cost.cost = rateRule.cost * detailsCar.distance;
			   }
			 */
			// main specification update
			specification.cost.cost = cost;
			specification.cost.cost_currency_rate = 1;
			specification.cost.update();

			return cost;
		}

		private function calculateCarAllowances():void {
			// init calculation variables
			var car_distance1:RateVO = new RateVO();	// below 9000 km
			var car_distance2:RateVO = new RateVO();	// above 9000 km
			var car_passengers:RateVO = new RateVO();
			var car_otherrates:RateVO = new RateVO();
			car_distance1.init();
			car_distance2.init();
			car_passengers.init();
			car_otherrates.init();

			// collect needed rates
			var passengerGeneralRate:TravelRateRuleVO = getRate("transport_passenger_extra_01");
			var distanceBelow9000:TravelRateRuleVO = getRate("transport_car_01");
			var distanceAbove9000:TravelRateRuleVO = getRate("transport_car_02");

			// start calculation
			var specificationList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;
			for (var i:Number = 0; i < specificationList.length; i++) {
				var travelSpec:TravelSpecificationVO = TravelSpecificationVO(specificationList.getItemAt(i));
				var type:String = (travelSpec.specification != null) ? travelSpec.specification.type : "";
				if (type == "car") {
					var detailsCar:CarSpecificationVO = CarSpecificationVO(travelSpec.specification);
					if (detailsCar.distance_calender == detailsCar.TYPE_ABOVE_9000KM) {
						var newAllowance2:Number = detailsCar.distance * distanceAbove9000.cost;
						car_distance2.num += detailsCar.distance;
						car_distance2.rate = distanceAbove9000.cost;
						car_distance2.amount += newAllowance2;

					} else if (detailsCar.distance_calender == detailsCar.TYPE_BELOW_9000KM) {
						var newAllowance1:Number = detailsCar.distance * distanceBelow9000.cost;
						car_distance1.num += detailsCar.distance;
						car_distance1.rate = distanceBelow9000.cost;
						car_distance1.amount += newAllowance1;

					}

					// more rates
					if (detailsCar.additional_workplace) {
						var workplaceRate:TravelRateRuleVO = getRate("transport_car_extra_01");
						var workAllowance:Number = detailsCar.distance * workplaceRate.cost;
						car_otherrates.num += detailsCar.distance;
						car_otherrates.amount += workAllowance;

					}
					if (detailsCar.passengers > 0) {
						var passengerRate:TravelRateRuleVO = getRate("transport_car_extra_02");
						var passAllowance:Number = (detailsCar.distance * detailsCar.passengers) * passengerRate.cost;
						car_passengers.num += (detailsCar.distance * detailsCar.passengers);
						car_passengers.rate = passengerRate.cost;
						car_passengers.amount += passAllowance;

					}
					if (detailsCar.additional_trailer) {
						var trailerRate:TravelRateRuleVO = getRate("transport_car_extra_03");
						var otherAllowance:Number = detailsCar.distance * trailerRate.cost;
						car_otherrates.num += detailsCar.distance;
						car_otherrates.amount += otherAllowance;

					}
					if (detailsCar.distance_forestroad > 0) {
						var forrestRate:TravelRateRuleVO = getRate("transport_car_extra_04");
						var otherAllowance2:Number = detailsCar.distance_forestroad * forrestRate.cost;
						car_otherrates.num += detailsCar.distance_forestroad;
						car_otherrates.amount += otherAllowance2;

					}
				}
			}

			// update model
			ModelLocator.getInstance().travelAllowance.car_distance1 = car_distance1;
			ModelLocator.getInstance().travelAllowance.car_distance2 = car_distance2;
			ModelLocator.getInstance().travelAllowance.car_passengers = car_passengers;
			ModelLocator.getInstance().travelAllowance.car_otherrates = car_otherrates;
		}

		public function getVisitedCountries(onDate:Date=null):ArrayCollection {
			var country:String;
			var lastCountry:String = "";
			var visited:ArrayCollection = new ArrayCollection();
			var specificationList:ArrayCollection = ModelLocator.getInstance().travelSpecsList;
			for (var i:Number = 0; i < specificationList.length; i++) {
				var specification:TravelSpecificationVO = TravelSpecificationVO(specificationList.getItemAt(i));
				var valid:Boolean = true;
				if (onDate != null) {
					if ((specification.from_date.time < onDate.time && specification.to_date.time < onDate.time) ||
						(specification.from_date.time > onDate.time && specification.to_date.time > onDate.time) ) {
						// specification dates are before of after accomodation occours
						valid = false;
					}
				}
				if (specification.to_country != "" && valid) {
					country = specification.to_country;
					visited.addItem(country);						
				} else {
					if (onDate != null) {
						if (specification.from_date.time < onDate.time && specification.to_date.time < onDate.time) {
							lastCountry = specification.to_country;
						}
					}
				}
			}
			if (visited.length == 0 && lastCountry != "") {
				visited.addItem(lastCountry);	
			}
			return visited;
		}

		// kalkuler overnattinger ===========================================================
		public function calculateAccomodations():Number {
			var amount:Number = 0.0;
			var amount28days:Number = 0.0;
			var daysCount:Number = 0;
			var accomodationList:ArrayCollection = ModelLocator.getInstance().travelAccomodationList;
			// reset nighttarif travelallowances 
			var model:ModelLocator = ModelLocator.getInstance()
			model.travelAllowance.nighttariff_international = new ArrayCollection();
			model.travelAllowance.nighttariff_28days = new RateVO();
			model.travelAllowance.nighttariff_domestic = new RateVO();
			model.travelAllowance.nighttariff_domestic_hotel = new RateVO();
			// calculate accomodations
			for (var i:Number = 0; i < accomodationList.length; i++) {
				var accomodation:TravelAccomodationVO = TravelAccomodationVO(accomodationList.getItemAt(i));
				amount += calculateAccomodation(TravelAccomodationVO(accomodationList.getItemAt(i)), daysCount, false);
				// update accomodation days so far
				var distanceRange:DateRanger = new DateRanger();
				distanceRange.getDateRange(accomodation.fromdate, accomodation.todate);
				daysCount += distanceRange.days;

			}

			return amount;
		}

		public function calculateAccomodation(accomodation:TravelAccomodationVO, earlierNightsNum:Number=0, alertUser:Boolean=true):Number {
			var amount:Number = 0.0;
			var days:Number = 1;
			var dailyAllowance:Number;
			var rateRule:TravelRateRuleVO;
			var travelInfo:TravelVO = ModelLocator.getInstance().activeTravel;
			// night tariff for collecting model allowance info 
			var nighttariff:RateVO = new RateVO();
			// Authorized or unauthorized accomodation
			if (accomodation.type != accomodation.TYPE_HOTEL) {
				rateRule = this.getRate("accomodation_unauthorized");
				// accomodation unauthorized - travel by rate
				// domestic accomodation rules apply because all international travel is covered 'by bill'
				dailyAllowance = rateRule.cost;

				// find how long period of time this accomodation lasted
				var distanceRange:DateRanger = new DateRanger();
				distanceRange.getDateRange(accomodation.fromdate, accomodation.todate);

				nighttariff.rate = dailyAllowance;
				nighttariff.num = distanceRange.days;
				nighttariff.amount = Number((dailyAllowance * distanceRange.days).toFixed(2));

				// calculate allowance for this distance
				var totalDays:Number = earlierNightsNum + distanceRange.days;
				if (totalDays <= 28) {
					amount += Number((dailyAllowance * distanceRange.days).toFixed(2));

					// update allowance model
					if (accomodation.type == accomodation.TYPE_UNATHORIZED_HOTEL) {
						ModelLocator.getInstance().travelAllowance.nighttariff_domestic_hotel = nighttariff;
					} else {
						ModelLocator.getInstance().travelAllowance.nighttariff_domestic = nighttariff;
					}

				} else {
					// one or all parts of accomodation should be reduced
					if (earlierNightsNum >= 28) {
						// all days reduced
						amount += Number(((dailyAllowance * 0.75) * distanceRange.days).toFixed(2));
					} else {
						// some days reduced, some not
						var reducedDays:Number = totalDays - 28;
						var normalDays:Number = distanceRange.days - reducedDays;
						amount += Number((dailyAllowance * normalDays).toFixed(2));
						amount += Number(((dailyAllowance * 0.75) * reducedDays).toFixed(2));
					}
				}

				// main specification update
				accomodation.cost.cost = amount;
				accomodation.cost.cost_currency_rate = 1;
				accomodation.cost.update();

			} else {
				// accomodation authorized - 'travel by bill'
				accomodation.actual_cost.update();
				var actualCost:Number = Number(accomodation.actual_cost.getCost());

				var distanceRange:DateRanger = new DateRanger();
				distanceRange.getDateRange(accomodation.fromdate, accomodation.todate);
				// distanceRange.days;

				var costCovered:Number = actualCost;
				var maxCover:Number = 0;
				if (travelInfo.travel_type == travelInfo.DOMESTIC) {
					// get max cover for domestic accomodation
					maxCover = this.getRate("accomodation_maxcover").cost;

				} else {
					// get max cover for international travel
					var intRate:TravelRateInternationalVO = this.getInternationalRate(accomodation.country.split("#")[0], accomodation.city);
					if (intRate != null) {
						maxCover = intRate.night;
					} else {
						maxCover = this.getRate("accomodation_maxcover").cost;
					}
				}
				if ((actualCost/distanceRange.days) > maxCover) {
					//costCovered = maxCover * distanceRange.days;
					// Alert the user about this
					if (alertUser) { 
						var model:ModelLocator = ModelLocator.getInstance();
						var alertWindow:mx.core.IFlexDisplayObject;
						alertWindow = PopUpManager.createPopUp(model.applicationReference, custom_alert, true);

						var alertTitle:String = ResourceManager.getInstance().getString(model.resources.bundleName, "error_warning");
						var alertText:String = ResourceManager.getInstance().getString(model.resources.bundleName, "alert_maxcost_accomodation");
						custom_alert(alertWindow).title = alertTitle;
						custom_alert(alertWindow).alertText = alertText;
					}
						//accomodation.actual_cost.cost = costCovered;
				}

				amount += costCovered;
			}


			return Number(amount.toFixed(2));
		}


		// kalkuler trekk ===================================================================
		public function calculateDeductions(only_deduction:TravelDeductionVO=null):Number {
			// init vars and find different rates
			var amount:Number = 0.0;
			//var days:Number = 1;
			var travelDateInfo:DateRanger = ModelLocator.getInstance().travelLength;
			var travelInfo:TravelVO = ModelLocator.getInstance().activeTravel;

			var rateName:String = "redraw";
			var breakfastRate:TravelRateRuleVO;
			var lunchRate:TravelRateRuleVO;
			var dinnerRate:TravelRateRuleVO;
			var extraRate:TravelRateRuleVO;
			var dailyAllowance:Number = 0;
			var dailyRealAllowance:Number = 0;
			if (travelInfo.travel_type == travelInfo.DOMESTIC) {
				if (travelDateInfo.overnight) {
					breakfastRate = this.getRate(rateName + "_01");
					lunchRate = this.getRate(rateName + "_02");
					dinnerRate = this.getRate(rateName + "_03");
				} else {
					breakfastRate = this.getRate(rateName + "_01_day");
					lunchRate = this.getRate(rateName + "_02_day");
					dinnerRate = this.getRate(rateName + "_03_day");
				}
				// calc daily allowance for domestic travel
				var rateRealRule:TravelRateRuleVO = this.getAllowanceRate(travelInfo, travelDateInfo);
				var rateDeductionRule:TravelRateRuleVO = this.getAllowanceRate(travelInfo, travelDateInfo, true);
				dailyRealAllowance = Number(rateRealRule.cost.toFixed(2));
				dailyAllowance = Number(rateDeductionRule.cost.toFixed(2));
			} else {
				breakfastRate = this.getRate(rateName + "_04");
				lunchRate = this.getRate(rateName + "_05");
				dinnerRate = this.getRate(rateName + "_06");
			}
			extraRate = this.getRate(rateName + "_extra");

			if (only_deduction == null) {	
				var deductionList:ArrayCollection = ModelLocator.getInstance().travelDeductionList;
				for (var i:Number = 0; i < deductionList.length; i++) {
					var deduction:TravelDeductionVO = TravelDeductionVO(deductionList.getItemAt(i));
					amount += this.calculateDeduction(deduction, breakfastRate, lunchRate, dinnerRate, extraRate, dailyAllowance, dailyRealAllowance);
				}
			} else {
				amount += this.calculateDeduction(only_deduction, breakfastRate, lunchRate, dinnerRate, extraRate, dailyAllowance, dailyRealAllowance);
			}
			return amount;
		}

		public function calculateDeduction(deduction:TravelDeductionVO, breakfastRate:TravelRateRuleVO, lunchRate:TravelRateRuleVO, dinnerRate:TravelRateRuleVO, extraRate:TravelRateRuleVO, allowance:Number=0, realAllowance:Number=0):Number {
			var amount:Number = 0.0;
			var dailyAllowance:Number = allowance;
			if (allowance == 0) {
				dailyAllowance = this.getDailyAllowance(deduction.date, true);
				realAllowance = this.getDailyAllowance(deduction.date);
			}
			if (deduction.breakfast) {
				if (breakfastRate.cost != 0) {
					amount -= Number(breakfastRate.cost);
				} else if (breakfastRate.percent != 0) {
					amount -= Number(((dailyAllowance * breakfastRate.percent)/100).toFixed(2));
				}
			}
			if (deduction.lunch) {
				if (lunchRate.cost != 0) {
					amount -= Number(lunchRate.cost);
				} else if (lunchRate.percent != 0) {
					amount -= Number(((dailyAllowance * lunchRate.percent)/100).toFixed(2));
				}
			}
			if (deduction.dinner) {
				if (dinnerRate.cost != 0) {
					amount -= Number(dinnerRate.cost);
				} else if (dinnerRate.percent != 0) {
					amount -= Number(((dailyAllowance * dinnerRate.percent)/100).toFixed(2));
				}
			}
			/* additional allowance when all meals are coverd - temp removed
			   if (deduction.breakfast && deduction.lunch && deduction.dinner) {
			   amount += extraRate.cost;
			   }
			 */

			// if deduction gets larger than the real allowance for this day - reduce deduction
			if (Math.abs(amount) > realAllowance && realAllowance != 0) {
				amount = -realAllowance;
			}

			// update deduction VO
			deduction.cost.cost = amount;
			deduction.cost.update();

			return amount;
		}


		// kalkuler diverse utlegg ==========================================================
		public function calculateOutlays():Number {
			var amount:Number = 0.0;
			var outlayList:ArrayCollection = ModelLocator.getInstance().travelOutlayList;
			for (var i:Number = 0; i < outlayList.length; i++) {
				amount += calculateOutlay(TravelOutlayVO(outlayList.getItemAt(i)));
			}
			return amount;
		}

		public function calculateOutlay(outlay:TravelOutlayVO):Number {
			outlay.cost.update();
			return Number(outlay.cost.local_cost);
		}


		// kalkuler reiseforskudd ===========================================================
		public function calculateTraveladvances():Number {
			var amount:Number = 0.0;
			var advanceList:ArrayCollection = ModelLocator.getInstance().travelAdvanceList;
			for (var i:Number = 0; i < advanceList.length; i++) {
				amount += calculateTraveladvance(TravelAdvanceVO(advanceList.getItemAt(i)));
			}
			return amount;
		}

		public function calculateTraveladvance(advance:TravelAdvanceVO):Number {
			return -(Number(advance.cost.toFixed(2)));
		}




		// collect correct rate =============================================================
		public function getRate(rateName:String):TravelRateRuleVO {
			var rateList:ArrayCollection = ModelLocator.getInstance().travelRateRulesList;
			for (var i:Number = 0; i < rateList.length; i++) {
				if (TravelRateRuleVO(rateList.getItemAt(i)).id == rateName) {
					return TravelRateRuleVO(rateList.getItemAt(i)); 
				}
			}
			return null;
		}

		public function getInternationalRate(countryCode:String, city:String=""):TravelRateInternationalVO {
			if (countryCode.indexOf("#") != -1) { countryCode = countryCode.split("#")[0]; }
			if (city == "-") city = "";
			var rateList:ArrayCollection = ModelLocator.getInstance().travelRatesInternationalList;
			for (var i:Number = 0; i < rateList.length; i++) {
				if (TravelRateInternationalVO(rateList.getItemAt(i)).code == countryCode &&
					TravelRateInternationalVO(rateList.getItemAt(i)).city == city) {
					return TravelRateInternationalVO(rateList.getItemAt(i)); 
				}
			}
			return null;
		}

	}
}

