using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.Common.WS.Exceptions
{

    /// <summary>
    /// The exception of this type should be thrown, if the cause is made by the developer: bugs in the source code.
    /// </summary>
    [global::System.Serializable]
    public class DeveloperException : MWBaseException
    {
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(DeveloperException));

        public DeveloperException() { }
        public DeveloperException(string message) : base(message) { }
        public DeveloperException(string message, Exception inner) : base(message, inner) { }
        protected DeveloperException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context)
            : base(info, context) { }

        public override void HandleMe()
        {
            string excStr = GetMessageWithInnerExceptions(this);
            log.Error(String.Format("Developer exception:\r\n{0}", excStr), this);
        }
    }
}
