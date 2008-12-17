using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.Common.WS.Utils;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    public class RateVO : IValidateValues
    {
        public double num = 0;
        public double rate = 0;
        public double amount = 0;

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            res = res && MathUtils.CheckIntInDouble(ref num, "num");
            res = res && MathUtils.CheckIntInDouble(ref rate, "rate");
            res = res && MathUtils.CheckIntInDouble(ref amount, "amount");
            return res;
        }

        #endregion
    }
}
