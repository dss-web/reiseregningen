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
    public class CarSpecificationVO : CommonSpecificationVO, IValidateValues
    {
        public enum CarType
        {
            TYPE_BELOW_9000KM = 1,
            TYPE_ABOVE_9000KM = 2,
        }

        /// <summary>
        /// @@@ what type is it?
        /// </summary>
        public double distance_calender; // CarType : Number = TYPE_BELOW_9000KM;
		
		public double distance_forestroad = 0; // : Number = 0;
		
		public bool additional_trailer = false; // : Boolean = false;
		
		//public double passengers = 0; // : Number = 0;
		public bool additional_workplace = false; // : Boolean = false;


        #region IValidateValues Members

        public override bool ValidateValues()
        {
            bool res = true;
            res = res && base.ValidateValues();
            res = res && MathUtils.CheckIntInDouble(ref distance_calender, "distance_calender");
            return res;
        }

        #endregion
    }
}
