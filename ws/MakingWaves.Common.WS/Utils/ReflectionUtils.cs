using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Xml.Serialization;

namespace MakingWaves.Common.WS.Utils
{
    /// <summary>
    /// Utils that uses reflection and serialization.
    /// </summary>
    public static class ReflectionUtils
    {
        /// <summary>
        /// Gets the product version - from current assembly.
        /// Use "Assembly.GetExecutingAssembly()" calling for the argument.
        /// </summary>
        /// <returns></returns>
        public static Version GetProductVersion(Assembly assembly)
        {
            return assembly.GetName().Version;
        }

        /// <summary>
        /// Shows specified object content as XML serialized.
        /// </summary>
        /// <param name="a">A.</param>
        /// <returns></returns>
        public static string ObjectToXmlSerialized(object a)
        {
            XmlSerializer ser = new XmlSerializer(a.GetType());
            System.IO.StringWriter stream = new System.IO.StringWriter();
            ser.Serialize(stream, a);
            return stream.ToString();
        }

        /// <summary>
        /// Reads object content from specified XML.
        /// </summary>
        /// <param name="xmlSerialized">The XML serialized.</param>
        /// <param name="destType">Type of the expected result object</param>
        /// <returns>Deserialized object</returns>
        public static object XmlSerializedToObject(string xmlSerialized, Type destType)
        {
            XmlSerializer ser = new XmlSerializer(destType);
            System.IO.StringReader stream = new System.IO.StringReader(xmlSerialized);
            object res = ser.Deserialize(stream);
            return res;
        }
    
    }
}
