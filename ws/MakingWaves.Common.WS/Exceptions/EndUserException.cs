using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.Common.WS.Exceptions
{

    /// <summary>
    /// The exception of this type should be thrown, if the cause is made by the end user or client application: 
    /// No disk in drive, invalid values entered, etc.
    /// </summary>
    [global::System.Serializable]
    public class EndUserException : MWBaseException
    {
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(EndUserException));

        public EndUserException() { }
        public EndUserException(string message) : base(message) { }
        public EndUserException(string message, Exception inner) : base(message, inner) { }
        protected EndUserException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context)
            : base(info, context) { }

        public override void HandleMe()
        {
            string excStr = GetMessageWithInnerExceptions(this);
            log.Warn(String.Format("End User exception:\r\n{0}", excStr), this);
        }
    }
}
