using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.Common.WS.Exceptions;

namespace MakingWaves.Common.WS.Utils
{
    /// <summary>
    /// Utils connected with numeric manipulations.
    /// </summary>
    public static class MathUtils
    {
         /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(MathUtils));

        /// <summary>
        /// Checks if the value stored in double is valid as integer value.
        /// Checks if it is not NaN and if is even.
        /// For now it is not changing its value, but in next version it may do it.
        /// </summary>
        /// <param name="val">The val.</param>
        /// <exception cref="EndUserException">If value is not numeric</exception>
        /// <returns>true if the value was correct</returns>
        public static bool CheckIntInDouble(ref double val, string varName)
        {
            if (Double.IsNaN(val))
            {
                throw new EndUserException("Numeric variable has value NaN: " + varName);
            }
            if (Double.IsInfinity(val))
            {
                throw new EndUserException("Numeric variable has value Infinity: " + varName);
            }
            if (val != Math.Floor(val))
            {
                throw new EndUserException("Numeric variable has value not even: " + varName+"="+val);
            }
            return true;
        }
    }
}
