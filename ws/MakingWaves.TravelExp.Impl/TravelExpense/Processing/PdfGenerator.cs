using System;
using System.Collections.Generic;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Configuration;
using System.Collections;
using System.IO;
using MakingWaves.Common.WS.Exceptions;
using MakingWaves.TravelExp.Impl.TravelExpense.DataStructures;
using MakingWaves.Common.WS.Utils;

namespace MakingWaves.TravelExp.Impl.TravelExpense.Processing
{
    /// <summary>
    /// Fills in specific form in PDF.
    /// </summary>
    internal class PdfGenerator
    {
        //log4net
        private static log4net.ILog log = log4net.LogManager.GetLogger(typeof(PdfGenerator));
        
        // number of decimals to be used in amount
        private const int NumberOfDecimalsToShow = 2;

        /// <summary>
        /// file used as template, specified in web.config.
        /// </summary>
        public static string PdfTemplateFileName;


        MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travelExpense;
        System.IO.MemoryStream pdfOutput;
        
        /// <summary>
        /// Fields in PDF document
        /// </summary>
        private AcroFields pdfFormFields;

        static PdfGenerator()
        {
            PdfTemplateFileName = ConfigurationManager.AppSettings["MakingWaves.TravelExp.Impl.TravelExpense.Processing.PdfTemplateFileName"];
            if (PdfTemplateFileName == null)
                throw new AdministratorException("MakingWaves.TravelExp.Impl.TravelExpense.Processing.PdfTemplateFileName not defined in configuration");
        }
        
        public PdfGenerator(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travelExpense,
            System.IO.MemoryStream pdfOutput)
        {
            this.travelExpense = travelExpense;
            if (travelExpense.ValidateValues())
                log.Info("Validation succeeded");
            else
                log.Info("Validation failed");
            this.pdfOutput = pdfOutput;
        }

        /// <summary>
        /// Generates the PDF.
        /// Uses already passed data in ctor to do it.
        /// </summary>
        public void GeneratePdf()
        {
            //Document doc = new Document();
            //PdfWriter writer = PdfWriter.GetInstance(doc, pdfOutput);
            //// Metadata
            //doc.AddCreator("Travel Expenses, MakingWaves");
            //doc.AddTitle("A title of the document");
            //doc.AddAuthor("Krzysztof Marzencki, Making Waves");
            //doc.AddSubject("This is my subject");
            //doc.Open();
            //doc.Add(new Paragraph("Hello World"));
            //doc.Add(new Paragraph("This is second paragraph"));
            //doc.Close();

            //string PdfTemplateFileNameNew = @"c:\Temp\New Document.pdf";

            PdfReader pdfReader = new PdfReader(PdfTemplateFileName);
            PdfStamper pdfStamper = new PdfStamper(pdfReader, pdfOutput);

            

            pdfFormFields = pdfStamper.AcroFields;

            ////int counter = 0;
            //foreach (DictionaryEntry de in pdfFormFields.Fields)
            //{
            //    string fieldName = de.Key.ToString();
            //    string fieldValue = "["+de.Key.ToString()+"]"; //"12";
            //    pdfFormFields.SetField(fieldName, fieldValue);
            //}

            SetPersonalFields();
            SetTravel();
            SetTravelSpecificationList(); 
            SetNotes();
            SetTravelOutlays();
            SetAccomodation();
            SetTravelAllowances();


            // flatten the form to remove editting options, set it to false
            // to leave the form open to subsequent manual edits
            pdfStamper.FormFlattening = true; // false;

            // close the pdf
            pdfStamper.Close();

        }

        private void SetAccomodation()
        {
            if (travelExpense.accomodationList == null)
                return;
            //bool isHotel = false;
            //bool isPensjonat = false;
            //bool isOther = false;
            //foreach (TravelAccomodationVO ta in travelExpense.accomodationList)
            //{
            //    switch ((TravelAccomodationVO.AccomodationType)(int)ta.type)
            //    {
            //        case TravelAccomodationVO.AccomodationType.TYPE_HOTEL:
            //            isHotel = true;
            //            break;
            //        case TravelAccomodationVO.AccomodationType.TYPE_UNATHORIZED:
            //            isOther = true;
            //            break;
            //        case TravelAccomodationVO.AccomodationType.TYPE_UNATHORIZED_HOTEL:
            //            isPensjonat = true;
            //            break;
            //    }
            //}
        //    FillField("32", isHotel ? "Yes" : "");
        //    FillField("33", isPensjonat ? "Yes" : "");
        //    FillField("34", isOther ? "Yes" : "");
        }

        /// <summary>
        /// Sets the travel outlays. Second table on second page.
        /// </summary>
        private void SetTravelOutlays()
        {
            int counter = 0;
            double sum = 0;
            if (travelExpense.travelOutlayList != null)
            {
                foreach (TravelOutlayVO to in travelExpense.travelOutlayList)
                {
                    int fieldNr = 258 + 6 * counter;
                    if (to.date.HasValue)
                        FillField(fieldNr.ToString(), to.date.Value.ToString("dd'.'MM'.'yy"));
                    FillField((fieldNr + 1).ToString(), to.specification);
                    if (to.cost != null)
                    {
                        FillField((fieldNr + 2).ToString(), to.cost.cost_currency);
                        FillField((fieldNr + 3).ToString(), to.cost.cost, NumberOfDecimalsToShow);
                        FillField((fieldNr + 4).ToString(), to.cost.cost_currency_rate);
                        double finalCost = to.cost.cost * to.cost.cost_currency_rate;
                        FillField((fieldNr + 5).ToString(), finalCost, NumberOfDecimalsToShow); //to.cost.cost);
                        sum += finalCost; // to.cost.cost;
                    }
                    ++counter;
                    if (counter >= 11)
                    {
                        log.Warn("maximum number of rows in 'costs' exceeded. Total nr of rows is " + travelExpense.travelOutlayList.Length+" + accomodationList");
                        break;
                    }
                }
            }
            if (travelExpense.accomodationList != null)
            {
                int count = 1;

                foreach (TravelAccomodationVO acc in travelExpense.accomodationList)
                {
                    int fieldNr = 258 + 6 * counter;
                    if (acc.fromdate.HasValue)
                        FillField(fieldNr.ToString(), acc.fromdate.Value.ToString("dd'.'MM'.'yy"));
                    FillField((fieldNr + 1).ToString(), acc.country +  (acc.country.Length > 0 ? "," : "") + acc.name); //.specito.specification);

                    // Fill in Overnattning. Take first hotell in list.
                    if(count++ == 1)
                        FillField("324", acc.name + (acc.adress.Length > 0 &&  acc.name.Length > 0 ? "," + acc.adress : ""));



                    if (acc.cost != null)
                    {
                        if (acc.actual_cost.cost_currency_rate != 1)
                        {
                            FillField((fieldNr + 2).ToString(), acc.actual_cost.cost_currency);
                            FillField((fieldNr + 3).ToString(), acc.actual_cost.cost, NumberOfDecimalsToShow);
                            FillField((fieldNr + 4).ToString(), acc.actual_cost.cost_currency_rate);
                        }
                        double finalCost = acc.actual_cost.cost * acc.actual_cost.cost_currency_rate;
                        FillField((fieldNr + 5).ToString(), finalCost, NumberOfDecimalsToShow); //acc.actual_cost.cost);
                        sum += finalCost; //acc.cost.cost;
                    }
                    ++counter;
                    if (counter >= 11)
                    {
                        log.Warn("maximum number of rows in 'costs' exceeded. Total nr of rows is " + travelExpense.travelOutlayList.Length+" + outlaysList");
                        break;
                    }
                }
            }

            string prevSumStr = pdfFormFields.GetField("329").ToString();
            double prevSum = StringUtils.GetDoubleFromString(prevSumStr);
            FillField("330", sum + prevSum);
        }

        private void SetTravelAllowances()
        {

            string prevSumStr = pdfFormFields.GetField("330").ToString();
            FillField("95", prevSumStr);

            TravelAllowanceVO ta = travelExpense.travelAllowances;
            if (ta == null)
                return;
            // summed value of all fields
            double sum = 0;
            AddSum(ref sum, StringUtils.GetDoubleFromString(prevSumStr));


            FillFieldAmounts("35aa", "36aa", "96aa", ta.adm_allowance);
            AddSum(ref sum, ta.adm_allowance.amount);
            if (ta.domestic && !ta.accomodation)
            {
                if (ta.allowance.num < 5)
                {
                    FillFieldAmountsWithHours("35ab", "36ab", "96ab", ta.allowance);
                    AddSum(ref sum, ta.allowance.amount);
                }
                else if (ta.allowance.num < 9)
                {
                    FillFieldAmountsWithHours("35", "36", "96", ta.allowance);
                    AddSum(ref sum, ta.allowance.amount);
                }
                else if (ta.allowance.num < 12)
                {
                    FillFieldAmountsWithHours("37", "37a", "37b", ta.allowance);
                    AddSum(ref sum, ta.allowance.amount);
                }
                else
                {
                    FillFieldAmountsWithHours("38", "39", "97", ta.allowance);
                    AddSum(ref sum, ta.allowance.amount);
                }
            }
            else if (!ta.domestic && !ta.accomodation)
            {
                // count all rates for specific ranges of hours: <0,6), <6, 12) and >=12
                RateVO[] rateSum = {new RateVO(), new RateVO(), new RateVO()};
                // sum international allowances
                foreach (RateVO rate in ta.allowance_international)
                {
                    int whichInterval = 0;
                    if ((rate.num>=6) && (rate.num<12)) // from 6h to 12h
                        whichInterval = 1;
                    else if (rate.num >= 12) // more than 12h
                        whichInterval = 2;
                    else
                    {
                        log.Warn("RateVO in allowance_international has 'num'<6, so this is ignored! " + rate);
                    }
                    rateSum[whichInterval].num += rate.num;
                    rateSum[whichInterval].amount += rate.amount;
                    if ((rateSum[whichInterval].rate == 0) || (rateSum[whichInterval].rate == rate.rate))
                        rateSum[whichInterval].rate = rate.rate;
                    else
                        rateSum[whichInterval].rate = double.NaN; // different rates => do not show rate
                }
                //FillFieldAmounts("48", "49", "102", rateSum[0]);
                FillFieldAmountsWithHours("40", "41", "98", rateSum[1]);
                FillFieldAmountsWithHours("42", "43", "99", rateSum[2]);
                // put '1' instead of anything else in 'num' column
                if (rateSum[1].num > 0)
                    FillField("40", "1");
                if (rateSum[2].num > 0)
                    FillField("42", "1");

                AddSum(ref sum, rateSum[1].amount);
                AddSum(ref sum, rateSum[2].amount);

                //if (ta.allowance_international.num < 6)
                //{
                //    // nothing
                //}
                //else if (ta.allowance_international.num < 12)
                //{
                //    FillFieldAmountsWithHours("40", "41", "98", ta.allowance_international);
                //    AddSum(ref sum, ta.allowance_international.amount);
                //}
                //else
                //{
                //    FillFieldAmountsWithHours("42", "43", "99", ta.allowance_international);
                //    AddSum(ref sum, ta.allowance_international.amount);
                //}
            }
            else if (ta.domestic && ta.accomodation)
            {
                if (ta.allowance.num < 8)
                {
                    // nothing
                }
                else if (ta.allowance.num < 12)
                {
                    FillFieldAmountsWithHours("44", "45", "100", ta.allowance);
                    AddSum(ref sum, ta.allowance.amount);
                }
                else
                {
                    FillFieldAmountsWithHours("46", "47", "101", ta.allowance);
                    AddSum(ref sum, ta.allowance.amount);
                }
            }
            else if (!ta.domestic && ta.accomodation)
            {
                if (ta.allowance_international != null)
                {
                    // two same rows. If count-1, then first row, if count=2, then two rows, if
                    // count>=3 then first row with sum.
                    if (ta.allowance_international.Length >= 3)
                    {
                        RateVO rateSum = new RateVO(); 
                        // sum international allowances
                        foreach (RateVO rate in ta.allowance_international)
                        {
                            rateSum.num += rate.num;
                            rateSum.amount += rate.amount;
                            if ((rateSum.rate == 0) || (rateSum.rate == rate.rate))
                                rateSum.rate = rate.rate;
                            else
                                rateSum.rate = double.NaN; // different rates => do not show rate
                        }
                        FillFieldAmounts("48", "49", "102", rateSum);
                        AddSum(ref sum, rateSum.amount);
                    }
                    else
                    {
                        if (ta.allowance_international.Length > 0)
                        {
                            FillFieldAmounts("48", "49", "102", ta.allowance_international[0]);
                            AddSum(ref sum, ta.allowance_international[0].amount);
                        }
                        if (ta.allowance_international.Length > 1)
                        {
                            FillFieldAmounts("50", "51", "103", ta.allowance_international[1]);
                            AddSum(ref sum, ta.allowance_international[1].amount);
                        }


                    }
                }
                else
                    log.Warn(" (!ta.domestic && ta.accomodation) but ta.allowance_international = null !!!. Immiting this data.");
            }

            // night additionally "ulegitimert"

            FillFieldAmounts("52", "53", "104", ta.nighttariff_domestic);
            AddSum(ref sum, ta.nighttariff_domestic.amount);
            FillFieldAmounts("54", "55", "105", ta.nighttariff_domestic_hotel);
            AddSum(ref sum, ta.nighttariff_domestic_hotel.amount);
            {
                RateVO sumRate = new RateVO();
                foreach (RateVO rate in ta.nighttariff_international)
                {
                    sumRate.num += rate.num;
                    sumRate.amount += rate.amount;
                    if ((sumRate.rate == 0) || (sumRate.rate == rate.rate))
                        sumRate.rate = rate.rate;
                    else
                        sumRate.rate = double.NaN;
                }
                FillFieldAmounts("56", "57", "106", sumRate);
                //AddSum(ref sum, sumRate.rate);
                AddSum(ref sum, sumRate.amount);
            }

            // dedicated fields

            FillFieldAmounts("58", "59", "107", ta.car_distance1);
            AddSum(ref sum, ta.car_distance1.amount);
            FillFieldAmounts("60", "61", "108", ta.car_distance2);
            AddSum(ref sum, ta.car_distance2.amount);
            //FillFieldAmounts("62", "63", "109", ta.car_passengers);
            FillFieldAmounts("64", "65", "110", ta.car_passengers);
            AddSum(ref sum, ta.car_passengers.amount);
            FillFieldAmounts("67", "68", "111", ta.car_otherrates);
            AddSum(ref sum, ta.car_otherrates.amount);

            // accomodation beyond (over) 28 days

            //FillField("69", ta.beyond28days_cost_SDcode);
            //FillField("70", ta.beyond28days_cost_TTcode);
            //FillField("71", ta.beyond28days_cost_M);
            FillFieldAmounts("72", "73", "112", ta.allowance_28days);
            AddSum(ref sum, ta.allowance_28days.amount);

            //FillField("74", ta.beyond28days_nattillegg_SDcode);
            //FillField("75", ta.beyond28days_nattillegg_TTcode);
            //FillField("76", ta.beyond28days_nattillegg_M);
            FillFieldAmounts("77", "78", "113", ta.nighttariff_28days);
            AddSum(ref sum, ta.nighttariff_28days.amount);

            // fill in "Annet" - added by KM 2009-03-17
            if ((ta.allowance_other != null) && (ta.allowance_other.Length>0))
            {
                // check if there are the same 'rate' in all fields and sum 
                double numSum = 0;
                double rateSame = ta.allowance_other[0].rate; // will be checked later if the same
                bool isRateSame = true;
                double amountSum = 0;
                foreach (RateVO rateVO in ta.allowance_other)
                {
                    if (rateVO.rate != rateSame)
                        isRateSame = false;
                    numSum += rateVO.num;
                    amountSum += rateVO.amount;
                }
                FillField("80", numSum);
                if (isRateSame)
                {
                    FillField("81", rateSame);
                }
                FillField("114", amountSum);

                AddSum(ref sum, amountSum);
            }


            FillField("115", sum, NumberOfDecimalsToShow);

            double sumBrutto = sum;
            //FillField("79", ta.other_other_name);
            //FillFieldAmounts("80", "81", "114", ta.other_other_nrof, ta.other_other_rate);
            if (!ta.accomodation)
            {
                double sumCost = GetSummaryOfCost(travelExpense.travelDeductionList);
                FillField("82", sumCost);
                AddSum(ref sumBrutto, -sumCost);
            }
            else
            {
                double sumCost = GetSummaryOfCost(travelExpense.travelDeductionList);
                FillField("83", sumCost);
                AddSum(ref sumBrutto, -sumCost);
            }
            FillField("117", sumBrutto, NumberOfDecimalsToShow);

            if ((travelExpense.travelAdvanceList!=null) &&
                (travelExpense.travelAdvanceList.Length>0))
                FillField("86", travelExpense.travelAdvanceList[0].location);

            FillField("87", GetSummaryOfCost(travelExpense.travelAdvanceList));            
            FillField("118", ta.netamount, NumberOfDecimalsToShow);

        }

        private void AddSum(ref double sum, double item)
        {
            if (!Double.IsNaN(item))
                sum += item;
        }

        private double GetSummaryOfCost(TravelAdvanceVO[] travelAdvanceVO)
        {
            double res = 0;
            if (travelAdvanceVO!=null)
                foreach (TravelAdvanceVO ta in travelAdvanceVO)
                {
                    res += ta.cost;
                }
            return res;
        }

        /// <summary>
        /// Gets the summary of cost.
        /// </summary>
        /// <param name="travelDeductionVO">The travel deduction VO.</param>
        /// <returns></returns>
        private double GetSummaryOfCost(TravelDeductionVO[] travelDeductionVO)
        {
            double res = 0;
            if (travelDeductionVO!=null)
                foreach (TravelDeductionVO td in travelDeductionVO)
                {
                    if (td.cost != null)
                        if (!double.IsNaN(td.cost.cost))
                            res += td.cost.cost;
                }
            return res;
        }

        /// <summary>
        /// Fills the field amounts, trating 'num' as hours and recouonting it to days.
        /// </summary>
        /// <param name="nrofID">The nrof ID.</param>
        /// <param name="rateID">The rate ID.</param>
        /// <param name="amountID">The amount ID.</param>
        /// <param name="rateVO">The rate VO.</param>
        private void FillFieldAmountsWithHours(string nrofID, string rateID, string amountID, RateVO rateVO)
        {
            RateVO dayRate = new RateVO();
            dayRate.num = Math.Floor((rateVO.num + 18) / 24);
            dayRate.rate = rateVO.rate;
            dayRate.amount = dayRate.num * dayRate.rate;
            FillFieldAmounts(nrofID, rateID, amountID, dayRate);
        }

        private void FillFieldAmounts(string nrofID, string rateID, string amountID, RateVO rateVO)
        {
            FillField(nrofID, rateVO.num);
            FillField(rateID, rateVO.rate, NumberOfDecimalsToShow);
            FillField(amountID, rateVO.amount, NumberOfDecimalsToShow);
        }

        private void FillFieldAmounts(string nrofID, string rateID, string amountID, double nrofVal, double rateVal)
        {
            FillField(nrofID, nrofVal);            
            FillField(rateID, rateVal);
            FillField(amountID, nrofVal * rateVal);
        }

        private void SetNotes()
        {
            if (travelExpense.travelCommentList != null)
            {
                // concatenate all comments
                string wholeComment = "";
                foreach (TravelCommentVO comm in travelExpense.travelCommentList)
                {
                    if (comm.comment != null)
                        wholeComment += comm.comment + "\r\n";
                }
                FillField("325", wholeComment);
            }

            
        }

        /// <summary>
        /// Sets the travel specification list. - the upper table at second page.
        /// </summary>
        private void SetTravelSpecificationList()
        {
            if (travelExpense.specificationList == null)
                return;
            double sum_cost_nok = 0;
            double sumDistance = 0;
            for (int c = 0; c < travelExpense.specificationList.Length; ++c)
            {
                // Added 22.10.2008 Örjan Andersson
                // new row should only be handled if it's within the 12 rows inside the "Reisespesifikasjon" section
                if (c < 12)
                {
                    TravelSpecificationVO spec = travelExpense.specificationList[c];
                    // these field have numbers from "123" and each row have 11 items.
                    int startField = 123 + c * 11;
                    if (spec.from_date.HasValue)
                    {
                        DateTime fromDateLocal = spec.from_date.Value;
                        if (!double.IsNaN(spec.from_timezone))
                            fromDateLocal = fromDateLocal.AddHours(spec.from_timezone);

                        FillField(startField.ToString(), fromDateLocal.ToString("dd'.'MM'.'yy"));   // ("yyyy'-'MM'-'dd"));
                        FillField((startField + 1).ToString(), fromDateLocal.ToString("HH':'mm"));
                    }
                    // build location string 'from'
                    string from_location = "";
                    if (travelExpense.travelAllowances.domestic)
                    {
                        if (!string.IsNullOrEmpty(spec.from_destination))
                            from_location += spec.from_destination;
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(spec.from_country))
                            from_location += spec.from_country + ", ";
                        if (!string.IsNullOrEmpty(spec.from_destination))
                            from_location += spec.from_destination;
                    }
                    //if (!string.IsNullOrEmpty(spec.from_city))
                    //{
                    //    if (from_location.Length>0)
                    //        from_location += ", ";
                    //    from_location += spec.from_city;
                    //}
                    FillField((startField + 2).ToString(), from_location);
                    // build location string 'to'
                    string to_location = "";
                    if (travelExpense.travelAllowances.domestic)
                    {
                        if (!string.IsNullOrEmpty(spec.to_destination))
                            to_location += spec.to_destination;
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(spec.to_country))
                            to_location += spec.to_country + ", ";
                        if (!string.IsNullOrEmpty(spec.to_destination))
                            to_location += spec.to_destination;
                    }

                    //if (!string.IsNullOrEmpty(spec.to_country))
                    //    to_location += spec.to_country;
                    //if (!string.IsNullOrEmpty(spec.to_city))
                    //{
                    //    if (to_location.Length > 0)
                    //        to_location += ", ";
                    //    to_location += spec.to_city;
                    //}

                    FillField((startField + 3).ToString(), to_location);
                    // time
                    if (spec.to_date.HasValue)
                    {
                        DateTime dateLocal = spec.to_date.Value;
                        if (!double.IsNaN(spec.to_timezone))
                            dateLocal = dateLocal.AddHours(spec.to_timezone);
                        FillField((startField + 4).ToString(), dateLocal.ToString("HH':'mm"));
                    }
                    FillField((startField + 5).ToString(), spec.transportation_type);
                    // other fields are dependent on specification type
                    bool isNotListed = false;
                    CommonSpecificationVO com = spec.specification_aggregate.GetCommonSpecification();
                    CostVO thisCost = spec.cost;
                    if (com == null)
                    {
                        log.Warn("common specification in aggregate = null. spec.specification_aggregate=" + spec.specification_aggregate.ToString());
                    }
                    else
                    {
                        switch (spec.specification_aggregate.GetSpecificationType())
                        {
                            case AnySpecificationAggregateVO.SpecificationType.Car:
                            case AnySpecificationAggregateVO.SpecificationType.Motorboat:
                            case AnySpecificationAggregateVO.SpecificationType.Motorcycle:
                            case AnySpecificationAggregateVO.SpecificationType.Other:
                                isNotListed = true;
                                FillField((startField + 6).ToString(), com.distance.ToString());

                                // Added 22.10.2008 Örjan Andersson
                                // cost of car should be added to the "Beløp" column and total sum
                                FillField((startField + 10).ToString(), com.cost.cost, NumberOfDecimalsToShow);
                                sum_cost_nok += com.cost.cost;


                                sumDistance += com.distance;
                                break;
                        }
                    }
                    if (!isNotListed)
                    {
                        if (thisCost != null)
                        {
                            if (thisCost.cost_currency_rate != 1)
                            {
                                // currency code (all except 'NOK')
                                FillField((startField + 7).ToString(), thisCost.cost_currency);
                                // cost in local
                                FillField((startField + 8).ToString(), thisCost.cost, NumberOfDecimalsToShow); 
                                FillField((startField + 9).ToString(), thisCost.cost_currency_rate.ToString());
                            }
                            //double finalCost = StringUtils.GetDoubleFromString(thisCost.local_cost) * thisCost.cost_currency_rate;
                            double finalCost = thisCost.cost * thisCost.cost_currency_rate;
                            FillField((startField + 10).ToString(), finalCost, NumberOfDecimalsToShow); // thisCost.cost.ToString());
                            sum_cost_nok += finalCost; // thisCost.cost;
                        }
                        else
                            log.Warn("cost = null!!!");
                    }

                    // block if no more rows...
                    if (c >= 12)
                    {
                        // no more rows!
                        log.Warn("There are no more rows available. Length is:" + travelExpense.specificationList.Length);
                        break;
                    }
                }
            }
            FillField("326", sumDistance);            
            //FillField("329", sum_cost_nok.ToString());
            FillField("329", sum_cost_nok, NumberOfDecimalsToShow);
        }

        private void SetTravel()
        {
            TravelVO tr = travelExpense.travel;
            if (tr == null)
            {
                log.Debug("TravelVO=null");
                return;
            }
            if (tr.travel_date_out.HasValue)
                FillField("23", tr.travel_date_out.Value.ToString("yyyy'-'MM'-'dd"));
            FillField("24", tr.travel_time_out);
            FillField("29", tr.location);
            if (tr.travel_date_in.HasValue)
                FillField("30", tr.travel_date_in.Value.ToString("yyyy'-'MM'-'dd"));
            FillField("31", tr.travel_time_in);
            switch (((TravelVO.TravelCause)(int)tr.travel_cause))
            {
                case TravelVO.TravelCause.BUSINESS:
                    FillField("26", "Yes");
                    break;
                case TravelVO.TravelCause.COURSE:
                    FillField("25", "Yes");
                    break;
                case TravelVO.TravelCause.OTHER:
                    FillField("27", "Yes");
                    FillField("28", tr.travel_cause_other);
                    break;
            }
        }

        /// <summary>
        /// Sets the personal fields.
        /// </summary>
        private void SetPersonalFields()
        {
            PersonalInfoVO pi = travelExpense.personalinfo;
            if (pi == null)
            {
                log.Debug("Personal Info = null");
                return;
            }
            FillField("1", pi.lastname + " "+pi.firstname);
            FillField("2", pi.socialsecuritynumber);
            FillField("3", pi.adress);
            FillField("4", pi.zip);
            FillField("5", pi.postoffice);
            FillField("6", pi.jobtitle);
            FillField("7", pi.account);
            FillField("8", pi.workplace);
            FillField("9", pi.department);
            FillField("20", pi.domicialname);
            FillField("21", pi.domicialnum);
        }

        private void FillField(string id, string value)
        {
            string val = value;
            if (val == null)
            {
                log.Debug("Field '" + id + "' is null");
                val = "(null)";
            }
                //return;
            pdfFormFields.SetField(id, val); 
            
        }

        private void FillField(string id, double value)
        {
            if (double.IsNaN(value))
                return;
            FillField(id, StringUtils.DoubleToStringPoint(value));
        }

        private void FillField(string id, double value, int noDecimals)
        {

            if (double.IsNaN(value))
                return;
            FillField(id, StringUtils.DoubleToStringPoint(value, noDecimals));
        }

    }
}
