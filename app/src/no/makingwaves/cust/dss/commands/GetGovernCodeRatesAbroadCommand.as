//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	import no.makingwaves.cust.dss.vo.TravelRateInternationalVO;

	public class GetGovernCodeRatesAbroadCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var _governCodeRatesDelegate:GetGovernCodeRatesDelegate = new GetGovernCodeRatesDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			var delegate:GetGovernCodeRatesDelegate = new GetGovernCodeRatesDelegate( this );
			delegate.getGovernCodeRatesAbroad();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				var travelrate:XMLList = e.result.rate;
				var bundleName:String = ModelLocator.getInstance().resources.bundleName;
				for each (var rate:XML in travelrate) {
					var newRate:TravelRateInternationalVO = new TravelRateInternationalVO();
					// collect valid country/city names
					var textid:String = rate.@textid;
					var country:String = "";
					var city:String = "";
					if (textid.indexOf("_") != -1) {
						country = ResourceManager.getInstance().getString(bundleName, textid.split("_")[0]); 
						city = ResourceManager.getInstance().getString(bundleName, textid);
					} else {
						country = ResourceManager.getInstance().getString(bundleName, textid);
					}
					// insert values into VO
					newRate.code = rate.@code;
					newRate.country = country;
					newRate.city = city;
					newRate.night = Number(rate.@night);
					newRate.allowance = Number(rate.@allowance);
					newRate.timezone = (rate.@timezone != "") ? int(rate.@timezone) : 0;
					newRate.daylightsaving = (rate.@daylightsaving == "true") ? true : false;
					
					ModelLocator.getInstance().travelRatesInternationalList.addItem(newRate);
				}
				
			} catch(e:Error) {
				errorOccoured(e.errorID + ": " + e.message);
				
			} finally {
				/*
				// DEBUG PURPOSES
				var mylist:ArrayCollection = ModelLocator.getInstance().travelRatesInternationalList;
				for (var i:int=0; i < mylist.length;i++) {
					var tri:TravelRateInternationalVO = mylist.getItemAt(i) as TravelRateInternationalVO;
					if (tri.city == "" || tri.city == null) {
						trace("<rate code=\"" + tri.code + "\" night=\"" + tri.night + "\" allowance=\"" + tri.allowance + "\" textid=\"" + tri.code + "\" desc=\"" + tri.country + "\" />");
					} else {
						trace("<rate code=\"" + tri.code + "\" night=\"" + tri.night + "\" allowance=\"" + tri.allowance + "\" textid=\"" + tri.code + "_" + tri.city.toLocaleLowerCase() + "\" desc=\"" + tri.country + "; " + tri.city + "\" />");
					}
				}
				// ==============
				*/
				ModelLocator.getInstance().initializer.stepComplete();
								
			}	
		}
		
		//----------------------------------------------------------------------------
		public function fault( info : Object ) : void
		{
			errorOccoured();
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().WARNING;
			error.error_message = "Loading international govern rates failed!"
			error.error_message += "\nThe application will not calculate correctly amounts on international travels";
			error.error_message += "\nDomestic travels will still be functional.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}
	}
}