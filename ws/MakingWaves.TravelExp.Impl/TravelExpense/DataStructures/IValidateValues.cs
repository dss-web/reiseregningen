using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    public interface IValidateValues
    {
        /// <summary>
        /// Validates the values.
        /// Checks if all fields that should be of type 'int' but
        /// are of type 'double' because of Flex integration, have valid values.
        /// </summary>
        /// <returns></returns>
        bool ValidateValues();
    }
}
