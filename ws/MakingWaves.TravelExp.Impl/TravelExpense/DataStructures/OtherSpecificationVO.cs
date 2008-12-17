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
    public class OtherSpecificationVO : CommonSpecificationVO, IValidateValues
    {
        public enum OtherType
        {
		    TYPE_SNOWMOBILE = 1,
		    TYPE_EL_CAR = 2,
		    TYPE_OTHER = 3,
        }

        public double other_type; // OtherType

        public OtherSpecificationVO()
        {
            type = "other";
        }

        #region IValidateValues Members

        public override bool ValidateValues()
        {
            bool res = true;
            res = res && base.ValidateValues();
            res = res && MathUtils.CheckIntInDouble(ref other_type, "other_type");
            return res;
        }

        #endregion
    }
}
