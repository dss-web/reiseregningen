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
    public class MotorcycleSpecificationVO : CommonSpecificationVO, IValidateValues
    {
		public enum MotorcycleType
        {
            TYPE_BELOW_125CC = 1,
            TYPE_ABOVE_125CC = 2,
        }

        public double motorcycle_type; // MotorcycleType

        public MotorcycleSpecificationVO()
        {
            type = "motorcycle";
        }

        #region IValidateValues Members

        public override bool ValidateValues()
        {
            bool res = true;
            res = res && base.ValidateValues();
            res = res && MathUtils.CheckIntInDouble(ref motorcycle_type, "motorcycle_type");
            return res;
        }

        #endregion
    }
}
