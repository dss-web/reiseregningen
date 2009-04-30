//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.model
{

	import com.adobe.cairngorm.model.ModelLocator;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextArea;
	
	import no.makingwaves.cust.dss.code.AccessibilityDistributer;
	import no.makingwaves.cust.dss.code.Initializer;
	import no.makingwaves.cust.dss.code.StateDistributer;
	import no.makingwaves.cust.dss.code.TravelExpenceCalculator;
	import no.makingwaves.cust.dss.vo.*;
	import no.makingwaves.util.date.DateRanger;
	import no.makingwaves.util.resources.LocaleResourceController;

	[Bindable]
	public class ModelLocator implements com.adobe.cairngorm.model.ModelLocator
	{
		private static var modelLocator : no.makingwaves.cust.dss.model.ModelLocator;

		//-----------------------------------------------------------
		public static function getInstance():no.makingwaves.cust.dss.model.ModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new no.makingwaves.cust.dss.model.ModelLocator();

			return modelLocator;
		}

		//-----------------------------------------------------------
		public function ModelLocator():void
		{
			if ( no.makingwaves.cust.dss.model.ModelLocator.modelLocator != null )
				throw new Error( 'Only one ModelLocator instance should be instantiated' );
		}
		
		public function initialize():void {
			activePerson = new PersonalInfoVO();
			activeTravel = new TravelVO();
			travelAllowance = new TravelAllowanceVO();
			travelSpecsList = new ArrayCollection();
			travelAccomodationList = new ArrayCollection();
			travelDeductionList = new ArrayCollection();
			travelOutlayList = new ArrayCollection();
			travelAdvanceList = new ArrayCollection();
			travelCommentList = new ArrayCollection();
			travelLength = new DateRanger();
			validationStatusPersonal = false;
			validationStatusTravel = false;		
			validationStatusSpecs = false;		
			validationStatusSettlement = false;
			travelExpenseOpen = false;
			localSaveName = "";
			xmlImportId = "";
			localSavePersonal = false;
		}
		
		// VERSION ================================================================
		
		//public const VERSION : String = "1.1.1";
		public const VERSION : String = "1.1.1 - TESTVERSJON 30.04.09";
				
		// STATICS ================================================================
		
		public const DETAILS : Number = 0;
		
		public const SUMMARY : Number = 1;
		
		// STATES  ================================================================
		
		public const BASE : String = "base";
		public const PERSONAL : String = "personal";
		public const TRAVEL : String = "travel";
		public const SPESIFICATIONS : String = "specifications";
		public const SETTLEMENT : String = "settlements";
		
		// MODELS =================================================================
		
		public var debugger : TextArea;
		
		public var activePerson : PersonalInfoVO = new PersonalInfoVO();
		
		public var activeTravel : TravelVO = new TravelVO();
		
		
		public var applicationReference : Reiseregningen;
		
		//public var activeSpecificationNum : TravelSpecificationVO;
		
		public var activeSpecification : TravelSpecificationVO;
		
		public var activeAccomodation : TravelAccomodationVO;
		
		public var travelAllowance : TravelAllowanceVO = new TravelAllowanceVO();
		
		public var travelSpecsList : ArrayCollection = new ArrayCollection(); // list of TravelSpecificationVO
				
		public var travelAccomodationList : ArrayCollection = new ArrayCollection(); // list of TravelAccomodationVO
		
		public var travelDeductionList : ArrayCollection = new ArrayCollection(); // list of TravelDeductionVO
		
		public var travelOutlayList : ArrayCollection = new ArrayCollection();  // list of TravelOutlayVO
		
		public var travelAdvanceList : ArrayCollection = new ArrayCollection(); // list of TravelAdvanceVO
		
		public var travelCommentList : ArrayCollection = new ArrayCollection(); // list of TravelCommentVO
		
		public var travelRateRulesList : ArrayCollection = new ArrayCollection(); // list of TravelRateRuleVO
		
		public var travelRatesInternationalList : ArrayCollection = new ArrayCollection(); // list of TravelRateInternationalVO 
		
		public var travelLength : DateRanger = new DateRanger();	
		
		public var calculator : TravelExpenceCalculator = new TravelExpenceCalculator();
		
		public var languages : ArrayCollection = new ArrayCollection();

		// summary variables ===========================================================
		
		public var summaryTextPersonal : String = "";
		public var summaryTextTravel : String = "";
		public var summaryTextSpecifications : String = "";
		public var summaryTextSettlements : String = "";
		
		// form validation status ======================================================
		
		public var validationStatusPersonal : Boolean = false;
		
		public var validationStatusTravel : Boolean = false;
		
		public var validationStatusSpecs : Boolean = false;
		
		public var validationStatusSettlement : Boolean = false;
		
		// distributers and controllers ================================================
		
		public var resources : LocaleResourceController = new LocaleResourceController();
		
		public var accessibility : AccessibilityDistributer;// = new AccessibilityDistributer();
		
		public var stateDistributer : StateDistributer;
		
		// application states and vars =================================================
		
		public var fieldSizeMain : Number = 180;
		
		public var globalScaleSize : Number = 100;
						
		public var initComplete : Boolean = false;
		
		public var travelExpenseOpen : Boolean = false;
		
		public var runTransitions : Boolean = true;
		
		public var dispatcher : EventDispatcher = new EventDispatcher();
		
		public var resourceList : ArrayCollection = new ArrayCollection(); // list of ResourcesVO
		
		public var currencyCodes : ArrayCollection = new ArrayCollection(); // list of CurrencyCodeVO
		
		public var postOfficeCodes : ArrayCollection = new ArrayCollection(); // list of PostalCodeVO
		
		public var domicialNumberCodes : ArrayCollection = new ArrayCollection(); // list of DomicialNumberCodeVO
		
		public var initializer : Initializer;
		
		public var screenreader : Boolean = false;		// indicating wether screenreader is active or not
		
		public var localSaveName : String = "";
		
		public var localSavePersonal : Boolean = false;
		
		public var saveWithPersonalInfo : Boolean = true;
		
		public var positionParameter : Number = (800 / 3);
		
		public var useDaylightSaving : Boolean = false;
		
		// state icon vars =============================================================
				
		public var helpTextPersonalinfo : String = "";
		public var helpTextPersonalinfoFields : String = "";
		
		public var helpTextTravel : String = "";
		public var helpTextTravelFields : String = "";
		
		public var helpTextSpecifications: String = "";
		public var helpTextSpecificationsFields : String = "";
		
		public var helpTextSettlement : String = "";
		public var helpTextSettlementFields : String = "";
				
		public var helpTextPopUp : String = "";
		public var helpTextPopUpFields : String = "";
		
		// webservice connection variables ==============================================
		
		public var travelexpense_pdf_id : String;
		
		public var xmlImportId : String;
		
		// form validators
		
		public function isPersonalInfoValid():Boolean {
			if (activePerson.socialsecuritynumber != "" &&
				activePerson.firstname != "" &&
				activePerson.lastname != "" &&
				activePerson.adress != "" &&
				activePerson.zip != "" &&
				activePerson.postoffice != "" &&
				activePerson.account != "")
			{
				validationStatusPersonal = true;
			} else {
				validationStatusPersonal = false;
			}
			return validationStatusPersonal;
		}
		
		public function isTravelInfoValid():Boolean {
			if (activeTravel.location != "" &&
				activeTravel.travel_cause != 0 &&
				activeTravel.travel_type != 0 &&
				activeTravel.travel_date_in != null &&
				activeTravel.travel_date_out != null &&
				activeTravel.travel_type != 0 &&
				activeTravel.travel_time_in != "" &&
				activeTravel.travel_time_out != "")
			{
				validationStatusTravel = true;
			} else {
				validationStatusTravel = false;	
			}
			return validationStatusTravel;
		}
		
		public function isSpecificationsValid():Boolean {
			return validationStatusSpecs = isTravelInfoValid();
		}
		
		public function isSettlementValid():Boolean {
			return validationStatusSettlement = isSpecificationsValid();
		}
		
		public function getTimeZoneInfoFromCountryCode(code:String):Object {
			var timezoneInfo:Object = new Object();
			//timezoneInfo.timezone = -((new Date()).timezoneOffset / 60);
			//timezoneInfo.daylightsaving = false;
			for (var i:int = 0; i < travelRatesInternationalList.length; i++) {
				var info:TravelRateInternationalVO = TravelRateInternationalVO(travelRatesInternationalList.getItemAt(i));
				if (info.code == code) {
					timezoneInfo.timezone = info.timezone;
					timezoneInfo.daylightsaving = info.daylightsaving;
					return timezoneInfo;
				}
			}
			return null;
		}
	}
}