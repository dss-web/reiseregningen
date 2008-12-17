using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// All numeric values are represented as 'double' type for better Flex integration.
    /// </remarks>
    //[Serializable]
    public class PersonalInfoVO : IValidateValues
    {
        public string socialsecuritynumber = ""; // Social sequrity number
        public string firstname = ""; // Firstname
        public string lastname = ""; // Lastname
        public string adress = ""; // Private address
        public string zip = ""; // Zip-code/postal code
        public string postoffice = ""; // Postoffice
		public string jobtitle = "";
        public string account = ""; // Bank account number
        public string workplace = ""; // Name of workplace
        public string department = ""; // Name of department
        public string domicialname = ""; // Name of domicial
        public string domicialnum = ""; // Domicial number

        #region IValidateValues Members

        public bool ValidateValues()
        {
            return true;
        }

        #endregion
    }
}
