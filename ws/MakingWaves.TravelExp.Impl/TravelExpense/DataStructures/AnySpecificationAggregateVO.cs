using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <summary>
    /// Only one of these fields can contain a value.
    /// This strange construction is created to avoid usage of polymorphism.
    /// </summary>
    //[Serializable]
    public class AnySpecificationAggregateVO : IValidateValues
    {
        public enum SpecificationType
        {
            Unknown = 0,
            Ticket = 1,
            Car = 2,
            Motorboat = 3,
            Motorcycle = 4,
            Other = 5,
        }

        public TicketSpecificationVO ticket_specification = null;
        public CarSpecificationVO car_specification = null;
        public MotorboatSpecificationVO motorboat_specification = null;
        public MotorcycleSpecificationVO motorcycle_specification = null;
        public OtherSpecificationVO other_specification = null;

        public double which_specification_used = 0;

        public SpecificationType GetSpecificationType()
        {
            return (SpecificationType)(int)which_specification_used;
            //if (ticket_specification!=null)
            //    return SpecificationType.Ticket;
            //if (car_specification != null)
            //    return SpecificationType.Car;
            //if (motorboat_specification != null)
            //    return SpecificationType.Motorboat;
            //if (motorcycle_specification != null)
            //    return SpecificationType.Motorcycle;
            //if (other_specification != null)
            //    return SpecificationType.Other;
            //return SpecificationType.Unknown;
        }

        #region IValidateValues Members

        public bool ValidateValues()
        {
            bool res = true;
            if (ticket_specification != null)
                res = res && ticket_specification.ValidateValues();
            if (car_specification != null)
                res = res && car_specification.ValidateValues();
            if (motorboat_specification != null)
                res = res && motorboat_specification.ValidateValues();
            if (motorcycle_specification != null)
                res = res && motorcycle_specification.ValidateValues();
            if (other_specification != null)
                res = res && other_specification.ValidateValues();
            return res;
        }

        #endregion

        public CommonSpecificationVO GetCommonSpecification()
        {
            switch (GetSpecificationType())
            {
                case SpecificationType.Unknown:
                    return null;
                case SpecificationType.Ticket:
                    return null; // ticket is not common
                case SpecificationType.Car:
                    return car_specification;
                case SpecificationType.Motorboat:
                    return motorboat_specification;
                case SpecificationType.Motorcycle:
                    return motorcycle_specification;
                case SpecificationType.Other:
                    return other_specification;
                default:
                    return null;
            }
        }

        public override string ToString()
        {
            return "[SpecificaitonType=" + GetSpecificationType() + "]";
        }
    }
}
