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
    public class MotorboatSpecificationVO : CommonSpecificationVO, IValidateValues
    {
        public enum MotorboatType
        {
		    TYPE_BELOW_50HK = 1,
            TYPE_ABOVE_50HK = 2,
        }

        public double motorboat_type; // MotorboatType

        public MotorboatSpecificationVO()
        {
       		type = "motorboat";
        }

        #region IValidateValues Members

        public override bool ValidateValues()
        {
            bool res = true;
            res = res && base.ValidateValues();
            res = res && MathUtils.CheckIntInDouble(ref motorboat_type, "motorboat_type");
            return res;
        }

        #endregion
    }
}
