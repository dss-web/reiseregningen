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
    public class CommonSpecificationVO : SpecificationVO, IValidateValues
    {
        public double distance = 0; // : Number = 0;
		
		public double passengers = 0; // : Number = 0;
		
		public double rate  = 0; //: Number = 0.0;
		
		public CostVO cost = new CostVO();


        #region IValidateValues Members

        public virtual bool ValidateValues()
        {
            bool res = true;
            res = res && MathUtils.CheckIntInDouble(ref distance, "distance");
            res = res && MathUtils.CheckIntInDouble(ref passengers, "passengers");
            if (cost != null)
                res = res && cost.ValidateValues();
            return res;
        }

        #endregion
    }
}
