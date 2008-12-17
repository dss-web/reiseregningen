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
    public class TravelVO : IValidateValues
    {
        public enum TravelType
        {
            DOMESTIC = 1,
            ABROAD = 2,
            DAY = 3,
        }

        public enum TravelCause
        {
            BUSINESS = 1,
            COURSE = 2,
            OTHER = 3,
        }

        /// <summary> Destination name </summary>
        public String location;
        /// <summary> Type of travel </summary>
        public double travel_type; // TravelType
        /// <summary> Cause of travel </summary>
        public double travel_cause; // TravelCause
        /// <summary> Cause of travel specified </summary>
        public String travel_cause_other;
        /// <summary> Date for start of travel </summary>
        public DateTime? travel_date_out;
        /// <summary> Time for start of travel </summary>
        public String travel_time_out;
        /// <summary> Date for end of travel </summary>
        public DateTime? travel_date_in;
        /// <summary> Time for end of travel </summary>
        public String travel_time_in;
        /// <summary>
        /// Travel number. Added 2008-09-08
        /// </summary>
        public string travelNumber;

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            res = res && MathUtils.CheckIntInDouble(ref travel_type, "travel_type");
            res = res && MathUtils.CheckIntInDouble(ref travel_cause, "travel_cause");
            return res;
        }

        #endregion
    }
}
