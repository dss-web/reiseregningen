using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using MakingWaves.Common.WS.Exceptions;
using System.Xml.Serialization;

namespace MakingWaves.Common.WS.Utils
{
    /// <summary>
    /// Extended capabilities for writing debug info etc.
    /// </summary>
    public static class DebugEx
    {
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(DebugEx));
        
        /// <summary>
        /// Counter used to avoid having the same files generated.
        /// </summary>
        private static int uniqueCounter = 0;

        /// <summary>
        /// Gets a value indicating whether this instance is enabled in web.config file.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is enabled in web config; otherwise, <c>false</c>.
        /// </value>
        public static bool IsEnabledInWebConfig
        {
            get
            {
                String debugExEnabled = System.Configuration.ConfigurationManager.AppSettings[
                    "MakingWaves.Common.WS.Utils.DebugEx.Enabled"];
                if (debugExEnabled==null)
                    return false;
                debugExEnabled = debugExEnabled.ToLower().Trim();
                if ((debugExEnabled == "true") || (debugExEnabled == "1"))
                    return true;
                return false;
            }
        }
        
        /// <summary>
        /// Saves the content of the object, as XML serialized.
        /// Place of this file is defined by 'MakingWaves.Common.WS.Utils.DebugEx.DestFolder' key in web.config.
        /// </summary>
        /// <param name="obj">The obj.</param>
        /// <param name="fileNamePart">The file name part.</param>
        /// <param name="fileNameExt">The file name extension. If null then 'txt'</param>
        public static void SaveObjectContent(object obj, string fileNamePart, string fileNameExt)
        {
            try
            {

                String objSerialized = ReflectionUtils.ObjectToXmlSerialized(obj);
                byte[] utf8 = StringUtils.StringToByteArray(objSerialized);
                SaveBytesToDebugFile(utf8, fileNamePart, fileNameExt);
            }
            catch (Exception exc)
            {
                log.Error("Cannot run SaveObjectContent");
                MWBaseException.DefaultExceptionHandler(exc);
                try
                {
                    log.Info("Expected content to be written is:\n" + ReflectionUtils.ObjectToXmlSerialized(obj));
                }
                catch (Exception exc2)
                {
                    log.Error("Cannot serialize the object - type is "+obj.GetType().ToString());
                    MWBaseException.DefaultExceptionHandler(exc2);
                }
            }
        }

        /// <summary>
        /// Saves the content to debug file.
        /// </summary>
        /// <param name="bytes">The bytes.</param>
        /// <param name="fileNamePart">The file name part.</param>
        /// <param name="fileNameExt">The file name ext.</param>
        public static void SaveBytesToDebugFile(byte[] bytes, string fileNamePart, string fileNameExt)
        {
            try
            {
                String destFolder = ConfigUtils.GetConfigSetting("MakingWaves.Common.WS.Utils.DebugEx.DestFolder", null);
                FileUtils.EnsureFolderExists(destFolder);
                DateTime dt = DateTime.Now;
                String fileName = dt.ToString("yyyy'-'MM'-'dd'_'HH'_'mm'_'ss") +
                    "_" + uniqueCounter + "_" + fileNamePart + "." + fileNameExt;
                ++uniqueCounter;
                String fullPath = Path.Combine(destFolder, fileName);
                FileStream f = File.Create(fullPath);
                f.Write(bytes, 0, bytes.Length);
                f.Close();
            }
            catch (Exception exc)
            {
                log.Error("Cannot run SaveContentToDebugFile");
                MWBaseException.DefaultExceptionHandler(exc);
            }
        }

        /// <summary>
        /// Loads the content of the object from its XmlSerializer representation.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="objectType">Type of the object.</param>
        /// <returns></returns>
        public static object LoadObjectContent(string fileName, Type objectType)
        {
            FileStream file = null;
            object res = null;
            try
            {
                // Create an instance of the XmlSerializer specifying type.
                XmlSerializer serializer =
                    new XmlSerializer(objectType);

                // Create a TextReader to read the file. 
                FileStream fs = new FileStream(fileName, FileMode.Open);
                TextReader reader = new StreamReader(fs);


                // Use the Deserialize method to restore the object's state.
                res = serializer.Deserialize(reader);


            }
            finally
            {
                if (file!=null)
                    file.Close();
            }
            return res;
        }
    }
}
