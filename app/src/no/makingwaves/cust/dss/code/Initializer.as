package no.makingwaves.cust.dss.code
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.EventDispatcher;
	import flash.system.Security;
	
	import mx.collections.ArrayCollection;
	import mx.core.Container;
	
	import no.makingwaves.cust.dss.events.GetConfigurationEvent;
	import no.makingwaves.cust.dss.events.GetCurrencyCodesEvent;
	import no.makingwaves.cust.dss.events.GetDomicialNumberCodesEvent;
	import no.makingwaves.cust.dss.events.GetGovernCodeRatesEvent;
	import no.makingwaves.cust.dss.events.GetLanguagesEvent;
	import no.makingwaves.cust.dss.events.GetPostalCodesEvent;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.LanguageVO;
	
	public class Initializer extends EventDispatcher
	{
		private var _applicationRef : Container;
		
		private var _activeStep : Number = 1;
		
		public function Initializer(container:Container) {
			_applicationRef = container;
		}
		
		public function run(stepNum:Number=1):void {
			_activeStep = stepNum;
			runStep();
		}
		
		private function runStep():void {
			errorCheck();
			switch(_activeStep) {
				case 1: 
					stepConfiguration();
					break;
				case 2:
					stepCrossDomainPolicy();
					break;
				case 3:
					stepStateDistributor();
					break;
				case 4:
					stepLanguages();
					break;
				case 5:
					stepRegisterLanguages();
					break;
				case 6:
					stepRateRules();
					break;
				case 7:
					stepRatesInternational();
					break;
				case 8:
					stepCurrencyCodes();
					break;
				case 9:
					stepPostalCodes();
					break;
				case 10:
					stepDomicialCodes();
					break;
				default:
					initializerComplete();
					break;
			}
		}
		
		private function errorCheck():void {
			if (ErrorLocator.getInstance().errorCollector.length > 0) {
				ErrorLocator.getInstance().show();
			}
		}
				
		public function stepComplete():void {
			_activeStep++;
			runStep();
		}
		
		private function initializerComplete():void {
			if (!ModelLocator.getInstance().initComplete) {
				ModelLocator.getInstance().initComplete = true;
				ModelLocator.getInstance().stateDistributer.openView(ModelLocator.getInstance().BASE);
			}
		}
		
		// STEP 01 - CONFIGURATION ======================================================
		private function stepConfiguration():void {
			var event:CairngormEvent = new CairngormEvent( GetConfigurationEvent.GET_CONFIGURATION );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 01b - CROSS-DOMAIN-POLICY ===============================================
		private function stepCrossDomainPolicy():void {
			var policyFileUrl:String = "";
			var resourceList:ArrayCollection = ModelLocator.getInstance().resourceList;
			for (var i:Number = 0; i < resourceList.length; i++) {
				if (resourceList.getItemAt(i).id == "cross-domain-policy") {
					policyFileUrl = resourceList.getItemAt(i).url;
					break;
				}
			}
			if (policyFileUrl != "") {
				Security.loadPolicyFile(policyFileUrl);
			}
			stepComplete();
		}
		
		// STEP 02 - STATE DISTRIBUTOR ==================================================
		private function stepStateDistributor():void {
			// init stateDistributer
			ModelLocator.getInstance().stateDistributer = new StateDistributer(_applicationRef);
			
			stepComplete();
		}
		
		// STEP 03 - RATE RULES =========================================================
		private function stepRateRules():void {
			var event:CairngormEvent = new CairngormEvent( GetGovernCodeRatesEvent.GET_RATES );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 04 - RATES INTERNATIONAL ================================================
		private function stepRatesInternational():void {
			var event:CairngormEvent = new CairngormEvent( GetGovernCodeRatesEvent.GET_RATES_ABROAD );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 05 - CURRENCY CODES =====================================================
		private function stepCurrencyCodes():void {
			var event:CairngormEvent = new CairngormEvent( GetCurrencyCodesEvent.GET_CURRENCYCODES );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 06 - POSTAL CODES =======================================================
		private function stepPostalCodes():void {
			var event:CairngormEvent = new CairngormEvent( GetPostalCodesEvent.GET_POSTALCODES );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 07 - DOMICIAL NUMBER CODES ==============================================
		private function stepDomicialCodes():void {
			var event:CairngormEvent = new CairngormEvent( GetDomicialNumberCodesEvent.GET_CODES );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 08 - AVAILIBLE LANGUAGES ==============================================
		private function stepLanguages():void {
			var event:CairngormEvent = new CairngormEvent( GetLanguagesEvent.GET_LANGUAGES );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		// STEP 09 - REGISTER AVAILIBLE LANGUAGES
		private function stepRegisterLanguages():void {
			// add language resources
			var defaultId:String = "";
			var languages:ArrayCollection = ModelLocator.getInstance().languages;
			for (var i:int=0; i < languages.length; i++) {
				var language:LanguageVO = languages.getItemAt(i) as LanguageVO;
				ModelLocator.getInstance().resources.addLocaleResource(language.id, language.filename);
				if (defaultId == "") {
					defaultId = language.id;
				}
			}
			ModelLocator.getInstance().resources.setActiveLocale(defaultId);
			
			//stepComplete();
		}
	}
}