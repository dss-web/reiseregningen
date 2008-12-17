using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TravelOutlayVO : IValidateValues
    {
		public DateTime? date;
		
		public String specification = "";

		public CostVO cost = new CostVO();

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            res = res && cost.ValidateValues();
            return res;
        }

        #endregion
    }
}
