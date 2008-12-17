using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.Common.WS.Utils;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TravelAccomodationVO : IValidateValues
    {
        public enum AccomodationType
        {
		    TYPE_HOTEL = 1,
		    TYPE_UNATHORIZED = 2,
		    TYPE_UNATHORIZED_HOTEL = 3,
        }
				
		public double type = 0;

        public String name = "";

        public String adress = "";

        public String country = "";

        public String city = "";

        public DateTime? fromdate;

        public DateTime? todate;

        public double breakfast_inluded = 0;

        public CostVO cost = new CostVO();

        public CostVO actual_cost = new CostVO();

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            res = res && MathUtils.CheckIntInDouble(ref type, "type");
            return res;
        }

        #endregion
    }
}
