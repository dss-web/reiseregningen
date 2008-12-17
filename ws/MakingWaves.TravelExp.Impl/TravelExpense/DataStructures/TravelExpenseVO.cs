using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class TravelExpenseVO : IValidateValues
    {
        public PersonalInfoVO personalinfo;
        public TravelVO travel;
        public TravelAllowanceVO travelAllowances;
        /// <summary>
        /// list of TravelSpesificationVO
        /// contains            CostVO
        /// and misc transportation specifications:
        /// TicketSpesificationVO
        /// CarSpesificationVO
        /// MotorboatSpesificationVO
        /// OtherSpesificationVO
        /// MotorcycleSpesificationVO
        /// </summary>
        public TravelSpecificationVO[] specificationList;               // 
        public TravelAccomodationVO[] accomodationList;    // list of TravelAccomodationVO
        public TravelAdvanceVO[] travelAdvanceList;       // list of TravelAdvanceVO
        public TravelOutlayVO[] travelOutlayList;       // list of TravelOutlayVO
        public TravelDeductionVO[] travelDeductionList;          // list of TravelDeductionVO
        public TravelCommentVO[] travelCommentList;              // list of TravelCommentVO

        public override string ToString()
        {
            return base.ToString();
        }

        public bool ValidateValues()
        {
            bool res = true;
            if (personalinfo!=null)
                res = res && personalinfo.ValidateValues();
            if (travel!=null)
                res = res && travel.ValidateValues();
            res = res && ValidateArr(specificationList);
            res = res && ValidateArr(accomodationList);
            res = res && ValidateArr(travelAdvanceList);
            res = res && ValidateArr(travelOutlayList);
            res = res && ValidateArr(travelDeductionList);
            res = res && ValidateArr(travelCommentList);
            return res;
        }

        /// <summary>
        /// Validates the array.
        /// </summary>
        /// <param name="listOfValidatableElems">The list of validatable elems.</param>
        private static bool ValidateArr(IValidateValues[] listOfValidatableElems)
        {
            if (listOfValidatableElems == null)
                return true;
            bool res = true;
            foreach (IValidateValues ivv in listOfValidatableElems)
            {
                if (!ivv.ValidateValues())
                    res = false;
            }
            return res;
        }
    }
}
