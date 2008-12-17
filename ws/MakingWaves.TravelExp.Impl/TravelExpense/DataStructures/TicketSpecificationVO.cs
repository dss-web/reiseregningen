using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TicketSpecificationVO : SpecificationVO, IValidateValues
    {
        public CostVO cost = new CostVO();

        public TicketSpecificationVO()
        {
            type = "ticket";
        }

        #region IValidateValues Members

        public bool ValidateValues()
        {
            return true;
        }

        #endregion
    }
}
