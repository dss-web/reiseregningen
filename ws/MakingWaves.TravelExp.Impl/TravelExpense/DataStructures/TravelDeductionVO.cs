using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TravelDeductionVO : IValidateValues
    {
		public DateTime? date;
		
		public bool breakfast = false;
		
		public bool lunch = false;
		
		public bool dinner = false;
		
		public CostVO cost = new CostVO();

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            if (cost!=null)
                res = res && cost.ValidateValues();
            return res;
        }

        #endregion
    }
}
