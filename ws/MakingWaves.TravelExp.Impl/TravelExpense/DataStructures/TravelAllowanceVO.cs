using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.Common.WS.Utils;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    //[Serializable]
    public class TravelAllowanceVO : IValidateValues
    {

		public RateVO adm_allowance = new RateVO();
		
		public bool accomodation;
		
		public bool domestic;
		
		public RateVO allowance = new RateVO();

        public RateVO[] allowance_international;
		
		public RateVO nighttariff_domestic = new RateVO();
		
		public RateVO nighttariff_domestic_hotel = new RateVO();
		
		public RateVO[] nighttariff_international;
		
		public RateVO allowance_28days = new RateVO();
		
		public RateVO nighttariff_28days = new RateVO();
		
		public RateVO car_distance1 = new RateVO();
		
		public RateVO car_distance2 = new RateVO();
		
		public RateVO car_passengers = new RateVO();
		
		public RateVO car_otherrates = new RateVO();
		
		public double netamount;
        
        
/*
        public double admin_godtgj_nrof; // 35aa
        public double admin_godtgj_rate; // 36aa

        // without overnights
        
        public double nonight_domestic_below5h_nrof; // 35ab
        public double nonight_domestic_below5h_rate; // 36ab

        public double nonight_domestic_5_9h_nrof; // 35
        public double nonight_domestic_5_9h_rate; // 36

        public double nonight_domestic_9_12h_nrof; // 37
        public double nonight_domestic_9_12h_rate; // 37a

        public double nonight_domestic_over12h_nrof; // 38
        public double nonight_domestic_over12h_rate; // 39

        public double nonight_international_6_12h_nrof; // 40
        public double nonight_international_6_12h_rate; // 41

        public double nonight_international_over12h_nrof; // 42
        public double nonight_international_over12h_rate; // 43

        // with overnights

        public double overnight_domestic_8_12h_nrof; // 44
        public double overnight_domestic_8_12h_rate; // 45

        public double overnight_domestic_over12h_nrof; // 46
        public double overnight_domestic_over12h_rate; // 47

        public double overnight_international_1_nrof; // 48
        public double overnight_international_1_rate; // 49

        public double overnight_international_2_nrof; // 50
        public double overnight_international_2_rate; // 51

        // night additionally "ulegitimert"

        public double ulegitimert_domestic_nrof; // 52
        public double ulegitimert_domestic_rate; // 53

        public double ulegitimert_domestic_hotel_nrof; // 54
        public double ulegitimert_domestic_hotel_rate; // 55

        public double ulegitimert_international_nrof; // 56
        public double ulegitimert_international_rate; // 57

        // dedicated fields

        public double dedicated_car_below9000km_nrof; // 58
        public double dedicated_car_below9000km_rate; // 59

        public double dedicated_car_over9000km_nrof; // 60
        public double dedicated_car_over9000km_rate; // 61

        public double dedicated_homework_nrof; // 62
        public double dedicated_homework_rate; // 63

        public double dedicated_passengers_nrof; // 64
        public double dedicated_passengers_rate; // 65

        public string dedicated_other_name; // 66
        public double dedicated_other_nrof; // 67
        public double dedicated_other_rate; // 68

        // accomodation beyond (over) 28 days

        public string beyond28days_cost_SDcode; // 69
        public string beyond28days_cost_TTcode; // 70
        public string beyond28days_cost_M; // 71
        public double beyond28days_cost_nrof; // 72
        public double beyond28days_cost_rate; // 73

        public string beyond28days_nattillegg_SDcode; // 74
        public string beyond28days_nattillegg_TTcode; // 75
        public string beyond28days_nattillegg_M; // 76
        public double beyond28days_nattillegg_nrof; // 77
        public double beyond28days_nattillegg_rate; // 78

        public double other_other_name; // 79
        public double other_other_nrof; // 80
        public double other_other_rate; // 81

        // summing

        public double totalof_amount; // 115
        public double pull_without_overnight_amount; // 82
        public double pull_with_overnight_amount; // 83

        public double brutto_reiseregning_amount; // 117
        public double brutto_reiseregning_kontering; // 75c
        public double brutto_reiseregning_code2; // 75d
        public double brutto_reiseregning_code3; // 75e
        public double brutto_reiseregning_code4; // 75f

        public string reiseforskudd_name; // 86
        public double reiseforskudd_amount; // 87

        public double netto_belop_amount; // 118
*/
        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            if (adm_allowance != null)
                res = res && adm_allowance.ValidateValues();
            if (allowance != null)
                res = res && allowance.ValidateValues();
            if (allowance_international!=null)
                foreach (RateVO ratevo in allowance_international)
                    res = res && ratevo.ValidateValues();
            if (nighttariff_domestic != null)
                res = res && nighttariff_domestic.ValidateValues();
            if (nighttariff_domestic_hotel!=null)
                res = res && nighttariff_domestic_hotel.ValidateValues();
            if (nighttariff_international != null)
                foreach (RateVO rate in nighttariff_international)
                    res = res && rate.ValidateValues();
            if (allowance_28days != null)
                res = res && allowance_28days.ValidateValues();
            if (car_distance1 != null)
                res = res && car_distance1.ValidateValues();
            if (car_distance2 != null)
                res = res && car_distance2.ValidateValues();
            if (car_passengers != null)
                res = res && car_passengers.ValidateValues();
            if (car_otherrates != null)
                res = res && car_otherrates.ValidateValues();
            res = res && MathUtils.CheckIntInDouble(ref netamount, "netamount");
            return res;
        }

        #endregion
    }
}
