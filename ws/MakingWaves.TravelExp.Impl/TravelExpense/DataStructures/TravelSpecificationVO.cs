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
    public class TravelSpecificationVO : IValidateValues
    {
        /// <summary>	Type of transportation	(car, airplane, train, bus, taxi……..)</summary>
        public String transportation_type = "";
        /// <summary>	Name of location for travel start	</summary>
        public String from_destination = "";
        /// <summary>	Date for start of travel	</summary>
        public DateTime? from_date;
        /// <summary>	Name of country; travelstart	</summary>
        public String from_country = "";
        /// <summary>	Name of city; travelstart	</summary>
        public String from_city = "";
        /// <summary>	Name of location for travel stop	</summary>
        public String to_destination = "";
        /// <summary>	Date for end of travel	</summary>
        public DateTime? to_date;
        /// <summary>	Name of country; travelend	</summary>
        public String to_country = "";
        /// <summary>	Name of city; travelend	</summary>
        public String to_city = "";
        /// <summary>	Is this the start of complete travel	</summary>
        public bool is_travel_start = false;

        public bool is_travel_continious = false;
        /// <summary>	Is this the end of complete travel	</summary>
        public bool is_travel_end = false;
        //public SpecificationVO specification;
        //public CarSpecificationVO specification; // @@@ tmp for now
        /// <summary>
        /// Contains any type of specification.
        /// </summary>
        public AnySpecificationAggregateVO specification_aggregate;
        /// <summary>	Defining cost of travel and any currency used	</summary>
        public	CostVO	cost = new CostVO();

        public double from_timezone;
        public double to_timezone;

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            res = res && specification_aggregate.ValidateValues();
            res = res && cost.ValidateValues();
            //res = res && MathUtils.CheckIntInDouble(ref from_timezone, "from_timezone");
            //res = res && MathUtils.CheckIntInDouble(ref to_timezone, "to_timezone");
            return res;
        }

        #endregion
    }
}
