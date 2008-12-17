using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TravelCommentVO : IValidateValues
    {
        public String comment;

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            return res;
        }

        #endregion
    }
}
