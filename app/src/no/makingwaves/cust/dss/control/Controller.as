//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.control
{

	import no.makingwaves.cust.dss.commands.*;
	import no.makingwaves.cust.dss.events.*;
	import com.adobe.cairngorm.control.FrontController;


	public class Controller extends FrontController
	{
		//-----------------------------------------------------------
		public function Controller():void
		{
			initializeCommands();
		}

		//-----------------------------------------------------------
		public function initializeCommands():void
		{
			
			addCommand( GetConfigurationEvent.GET_CONFIGURATION, GetConfigurationCommand );
			
			addCommand( GetLocalesEvent.GET_LOCALES, GetLocalesCommand );
			
			addCommand( GetGovernCodeRatesEvent.GET_RATES, GetGovernCodeRatesCommand );
			
			addCommand( GetGovernCodeRatesEvent.GET_RATES_ABROAD, GetGovernCodeRatesAbroadCommand );
			
			addCommand( GetCurrencyCodesEvent.GET_CURRENCYCODES, GetCurrencyCodesCommand );
			
			addCommand( GetPostalCodesEvent.GET_POSTALCODES, GetPostalCodesCommand );
			
			addCommand( LocalSaveEvent.SAVE_LOCAL, LocalSaveCommand );
			
			addCommand( GetDomicialNumberCodesEvent.GET_CODES, GetDomicialNumberCodesCommand );
			
			addCommand( GetLanguagesEvent.GET_LANGUAGES, GetLanguagesCommand );
			
			// WebServices //
			addCommand( GetTravelPdfEvent.GET_TRAVEL_PDF, getTravelPdfCommand );
			
			addCommand( GetTravelPdfEvent.REMOVE_TRAVEL_PDF_ID, removeTravelPdfIdCommand );
			
			addCommand( GetTravelXmlEvent.GET_TRAVEL_XML, getTravelXmlCommand );
			
			addCommand( GetTravelXmlEvent.REMOVE_TRAVEL_XML_ID, removeTravelXmlIdCommand );
			
			addCommand( OpenTravelXmlEvent.OPEN_TRAVEL_PDF, openTravelXmlCommand );
			
			/*
			addCommand( Controller.EVENT_GETINVITATION, getInvitationCommand );
			addCommand( Controller.EVENT_UPDATEINVITATION, updateInvitationCommand );
			addCommand( Controller.EVENT_INSERTINVITATION, insertInvitationCommand );
			addCommand( Controller.EVENT_REMOVEINVITATION, removeInvitationCommand );
			*/
		}
	}
}