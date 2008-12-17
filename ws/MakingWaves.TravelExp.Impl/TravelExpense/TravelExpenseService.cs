using System;
using System.Collections.Generic;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using MakingWaves.Common.WS.Utils;
using System.Reflection;
using System.Xml.Serialization;

namespace MakingWaves.TravelExp.Impl.TravelExpense
{
    /// <summary>
    /// Handles all web-service requests internally.
    /// </summary>
    public class TravelExpenseService
    {
        //log4net
        private static log4net.ILog log = log4net.LogManager.GetLogger(typeof(TravelExpenseService));

        /// <summary>
        /// Gets the travel PDF, from specified travel structures.
        /// </summary>
        /// <param name="travel">The travel.</param>
        /// <returns></returns>
        public MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO
            getTravelPdf(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel)
        {
            //log.Debug("travel_xml="+StringUtils.ObjectToXmlSerialized(travel));
            DebugEx.SaveObjectContent(travel, "getTravelPdf-arg", "txt");
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO res =
                new MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO();
            System.IO.MemoryStream pdfOutput = new System.IO.MemoryStream();
            Processing.PdfGenerator pdfGenerator =
                new MakingWaves.TravelExp.Impl.TravelExpense.Processing.PdfGenerator(travel, pdfOutput);
            pdfGenerator.GeneratePdf();
            res.PdfFileBytes = pdfOutput.GetBuffer();
            DebugEx.SaveBytesToDebugFile(res.PdfFileBytes, "getTravelPdf-res", "pdf");
            return res;
        }

        /// <summary>
        /// Gets the version of this assembly.
        /// </summary>
        /// <returns></returns>
        public string GetVersion()
        {
            return ReflectionUtils.GetProductVersion(Assembly.GetExecutingAssembly()).ToString();
        }

        /// <summary>
        /// Gets the travel XML.
        /// Flex user can save it then on his computer.
        /// </summary>
        /// <param name="travel">The travel.</param>
        /// <returns></returns>
        public byte[] getTravelXml(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel)
        {
            XmlSerializer ser = new XmlSerializer(travel.GetType());
            System.IO.StringWriter stream = new System.IO.StringWriter();
            ser.Serialize(stream, travel);
            string xmlStr = stream.ToString();
            // replace encoding info to UTF-8
            string replaceFrom = "encoding=\"utf-16\"?>";
            string replaceTo = "encoding=\"utf-8\"?>";
            // replace only one occurence
            int idx = xmlStr.IndexOf(replaceFrom);
            if (idx == -1)
                log.Warn("In result XML, there is no 'encoding' info (UTF-16 -> UTF-8) !");
            else
            {
                xmlStr = xmlStr.Substring(0, idx) + replaceTo + xmlStr.Substring(idx + replaceFrom.Length);
            }
            byte[] utf8 = StringUtils.StringToByteArray(xmlStr);
            stream.Close();
            return utf8;
        }
    }
}