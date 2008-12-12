/**
  * Value object for cost specifications	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="CostVO")]
	public class CostVO extends Object implements IValueObject
	{
		
		public var cost : Number = 0;
		
		public var cost_currency : String = "NOK";
		
		public var cost_currency_rate : Number = 1.0;
		
		public var local_cost : String = "0.0";
		
		public var authorized : Boolean;
		
		public var desc : String;
		
		public function getCost():String {
			if (this.cost_currency_rate == 1) {
				return this.cost.toFixed(2);
			} else {
				var rateCost:Number = this.cost * this.cost_currency_rate;
				return rateCost.toFixed(2);
			}
		}
		
		public function update():void {
			local_cost = getCost();
		} 

	}
}