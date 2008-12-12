//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	import no.makingwaves.cust.dss.vo.TravelRateRuleVO;

	public class GetGovernCodeRatesCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var _governCodeRatesDelegate:GetGovernCodeRatesDelegate = new GetGovernCodeRatesDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			var delegate:GetGovernCodeRatesDelegate = new GetGovernCodeRatesDelegate( this );
			delegate.getGovernCodeRates();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.toString();
				var travelrule:XMLList = e.result.travelraterule;
				for each (var rule:XML in travelrule) {
					var newRule:TravelRateRuleVO = new TravelRateRuleVO();
					newRule.id = rule.@id;
					newRule.cost = rule.@cost;
					newRule.percent = rule.@percent;
					newRule.percent_of_rule = rule.@percent_of_rule;
					newRule.rule_min_hours = rule.@rule_min_hours;
					newRule.rule_max_hours = rule.@rule_max_hours;
					newRule.rule_min_value = rule.@rule_min_value;
					newRule.rule_max_value = rule.@rule_max_value;
					newRule.rule_travel_type = rule.@rule_travel_type;
					newRule.description = rule.@description;
					ModelLocator.getInstance().travelRateRulesList.addItem(newRule);
				}
				
			} catch(e:Error) {
				errorOccoured(e.errorID + ": " + e.message);
				
			} finally {
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
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Loading govern rates failed!"
			error.error_message += "\nThe application will not calculate your travel expense correctly";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}
	}
}