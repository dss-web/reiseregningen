using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.Common.WS.Exceptions
{

    /// <summary>
    /// Standard exception class, an abstract class.
    /// Use DeveloperException, EndUserException or ConfigurationException class instances.
    /// </summary>
    [global::System.Serializable]
    public abstract class MWBaseException : Exception
    {
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(MWBaseException));

        public MWBaseException() { }
        public MWBaseException(string message) : base(message) { }
        public MWBaseException(string message, Exception inner) : base(message, inner) { }
        protected MWBaseException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context)
            : base(info, context) { }

		/// <summary>
		/// This function will be called in "catch" clause of the  "try..catch" statement.
        /// You can use MWBaseException.DefaultExceptionHandler(exc) to handle the exception caught.
		/// </summary>
		public abstract void HandleMe();

		/// <summary>
		/// Search in inner exceptions and get stack trace of the first exception that made the cause of problems.
		/// </summary>
		/// <returns></returns>
		public string GetMostInnerExceptionCallStack()
		{
			Exception exc = this;
			while (exc.InnerException != null)
				exc = exc.InnerException;
			return exc.StackTrace;
		}

        /// <summary>
        /// Search for inner exceptions and build the complete information string.
        /// Build text from the most inner exceptin to the most outer exception.
        /// </summary>
        /// <param name="exception">The exception.</param>
        /// <returns>Complete message from all exceptions.</returns>
		public static string GetMessageWithInnerExceptions(Exception exception)
		{
			StringBuilder res = new StringBuilder();
			Exception exc = exception;
			Stack<Exception> excs = new Stack<Exception>();
			while (exc != null)
			{
				excs.Push(exc);
				exc = exc.InnerException;
			}
			while (excs.Count > 0)
			{
				exc = excs.Pop();
				res.Append(exc.Message);
				if (excs.Count > 0)
					res.Append("\r\n---------------------------------------------\r\n");
			}
			return res.ToString();
		}


		/// <summary>
		/// Runs the default excepiton handler for specified exception, of any type (not only MWBaseException)
		/// </summary>
		/// <param name="exc">The exc.</param>
		public static void DefaultExceptionHandler(Exception exc)
		{
			if(exc == null)
                log.Error("!!! NULL Exception has been caught !!!!");

			if ((exc as MWBaseException) != null)
			{
				((MWBaseException)exc).HandleMe();
			}
			else if ((exc as System.Threading.ThreadAbortException) != null)
			{
				// if a thread is being aborted, then do nothing
			}
			else
			{
				string excStr = GetMessageWithInnerExceptions(exc);
                log.Error(String.Format("Foreign exception has been caught:\r\n{0}", excStr), exc);
			}
		}
	}
    
    
}
