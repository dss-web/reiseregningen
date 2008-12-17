using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.Common.WS.Exceptions
{

    /// <summary>
    /// The exception of this type should be thrown, if the cause is made by the administrator: e.g. wrong configuration or maintenance.
    /// </summary>
    [global::System.Serializable]
    public class AdministratorException : MWBaseException
    {
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(AdministratorException));

        public AdministratorException() { }
        public AdministratorException(string message) : base(message) { }
        public AdministratorException(string message, Exception inner) : base(message, inner) { }
        protected AdministratorException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context)
            : base(info, context) { }

        public override void HandleMe()
        {
            string excStr = GetMessageWithInnerExceptions(this);
            log.Error(String.Format("Configuration exception:\r\n{0}", excStr), this);
        }
    }
}
