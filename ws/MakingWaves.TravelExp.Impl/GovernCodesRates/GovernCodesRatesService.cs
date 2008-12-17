using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.GovernCodesRates
{
    public class GovernCodesRatesService
    {
        /// <summary>
        /// Gets the rates.
        /// </summary>
        /// <returns></returns>
        public RatesReisereg getRates()
        {
            RatesReisereg res = new RatesReisereg();
            res.adm_refund = 40.00m;
            res.domestic_less_5_hours = 0.00m;
            return res;
        }

        /// <summary>
        /// Gets the rates abroad.
        /// </summary>
        /// <returns></returns>
        public RatesForCountries getRatesAbroad()
        {
            RatesForCountries res = new RatesForCountries();
            res.countries = new RatesForCountry[2];
            res.countries[0] = new RatesForCountry();
            res.countries[0].countryName = "Algerie";
            res.countries[0].from_6_to_12_hours = 1380.00m;
            res.countries[0].above_12_hours = 700.00m;

            res.countries[1] = new RatesForCountry();
            res.countries[1].countryName = "Angola";
            res.countries[1].from_6_to_12_hours = 1520.00m;
            res.countries[1].above_12_hours = 800.00m;
            return res;
        }
    }
}
