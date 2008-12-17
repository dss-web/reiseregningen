using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class CostVO : IValidateValues
    {
		public double cost = 0; // : Number = 0;
		
		public string cost_currency = "NOK"; // : String = "NOK";
		
		public double cost_currency_rate = 1.0; // : Number = 1.0;
		
		public string local_cost = "0.0"; // : Number = 0.0;
		
        //public function getCost():Number {
        //    if (this.cost_currency_rate == 1) {
        //        return this.cost;
        //    } else {
        //        return (this.cost * this.cost_currency_rate);
        //    }
        //}
		
        //public function update():void {
        //    local_cost = getCost();
        //} 


        #region IValidateValues Members

        public bool ValidateValues()
        {
            return true;
        }

        #endregion
    }
}
