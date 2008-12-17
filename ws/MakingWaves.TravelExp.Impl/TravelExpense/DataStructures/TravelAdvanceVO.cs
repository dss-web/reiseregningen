using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TravelAdvanceVO : IValidateValues
    {
		public DateTime? date;
		
		public string location = "";
		
		public double cost = 0.0;


        #region IValidateValues Members

        public bool ValidateValues()
        {
            return true;
        }

        #endregion
    }
}
