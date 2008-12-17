using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using MakingWaves.TravelExp.Impl.TravelExpense.Processing;
using MakingWaves.Common.WS.Exceptions;
using MakingWaves.Common.WS.Utils;

/// <summary>
/// Webservice used for manipulating user's data entered to the Flex UI.
/// </summary>
[WebService(Namespace = "http://makingwaves.no/travelExp/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ToolboxItem(false)]
public class TravelExpense : System.Web.Services.WebService
{
    //log4net
    private static log4net.ILog log = log4net.LogManager.GetLogger(typeof(TravelExpense));

    [WebMethod(Description = "Test if webservice is working, and get current version of the assembly")]
    public string GetVersion()
    {
        log.Debug("GetVersion");
        MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService service =
            new MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService();
        String res = service.GetVersion();
        log.Debug("Returning " + res);
        return res;
    }

    /// <summary>
    /// Gets the travel PDF.
    /// </summary>
    /// <param name="travel">The travel.</param>
    /// <returns></returns>
    [WebMethod(Description = "Generates PDF file from specified data structures. Returns array of bytes (wrapped in other structure).")]
    public MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO
        getTravelPdf(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel)
    {
        try
        {
            log.Debug("================================================================");
            log.Debug("=====================  BEGIN - getTravelPdf  ===================");
            log.Debug("getTravelPdf, travel=" + travel.ToString());
            MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService service =
                new MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService();
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO res =
                service.getTravelPdf(travel);
            log.Debug("=======================  END - getTravelPdf  ===================");
            log.Debug("================================================================");
            return res;
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
            throw exc;
        }
    }

    /// <summary>
    /// Gets the travel PDF as stored id.
    /// </summary>
    /// <param name="travel">The travel.</param>
    /// <returns>Unique ID that can be used later on page</returns>
    /// 
    [WebMethod(Description = "Stores specified 'Travel' strucure at server-side and returns its unique identifier. Use GetStoredData.aspx?id=... page to retrieve PDF file.")]
    public string getTravelPdfAsStoredId(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel)
    {
        try
        {
            log.Debug("================================================================");
            log.Debug("=================  BEGIN - getTravelPdfAsStoredId  =============");
            log.Debug("getTravelPdfAsStoredId, travel=" + travel.ToString());
            MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService service =
                new MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService();
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO resPdf = service.getTravelPdf(travel);
            string pdfId = StoredDataRepository.Instance.AddNewEntry(new StoredDataEntry("application/pdf", resPdf.PdfFileBytes));
            log.Debug("getTravelPdfAsStoredId: returning " + pdfId);
            log.Debug("===================  END - getTravelPdfAsStoredId  =============");
            log.Debug("================================================================");
            return pdfId;
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
            throw exc;
        }

    }

    [WebMethod(Description = "Stores specified 'Travel' structure as serialized Xml and returns unique identifier. Use GetStoredData.aspx?id=... page to retrieve XML file.")] 
    public string getTravelXmlAsStoredId(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel)
    {
        log.Debug("================================================================");
        log.Debug("=================  BEGIN - getTravelXmlAsStoredId  =============");
        MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService service =
            new MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService();
        byte[] xmlBin = service.getTravelXml(travel);
        StoredDataEntry entry = new StoredDataEntry("application/download", xmlBin);
        entry.ForceDownload = true;
        entry.SaveAsFileName = "TravelData.xml";
        string id = StoredDataRepository.Instance.AddNewEntry(entry);
        log.Debug("===================  END - getTravelXmlAsStoredId  =============");
        log.Debug("================================================================");
        return id;
    }
    
    /// <summary>
    /// Removes the travel PDF stored id.
    /// </summary>
    /// <param name="id">The id got from method getTravelPdfAsStoredId.</param>
    /// <returns>true if specified id was found and deleted, false if not found</returns>
    [WebMethod(Description = "Clean server-side memory from old, no-more required data. Specify identifier returned by 'getTravelPdfAsStoredId' or other Data-Store method")]
    public bool removeDataStoredId(string id)
    {
        try
        {
            log.Debug("=================== removeTravelPdfStoredId =====================");
            
            //log.Debug("Temporarily disabled for debug puroposes");

            bool res = StoredDataRepository.Instance.DeleteEntry(id);
            log.Info("Deleted PdfRepository item with id="+id);
            return res;
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
            throw exc;
        }
    }

    [WebMethod(Description="Load XML file data and intepret it as TravelExpenseVO serialized object")]
    public MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO
        getTravelObjectFromXml(byte[] xmlFileBytes)
    {
        try
        {
            log.Debug("================================================================");
            log.Debug("=================  BEGIN - GetTravelObjectFromXml  =============");
            System.Xml.Serialization.XmlSerializer ser = new System.Xml.Serialization.XmlSerializer(typeof(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO));
            System.IO.MemoryStream stream = new System.IO.MemoryStream(xmlFileBytes);
            log.Debug("GetTravelObjectFromXml: xmlFileBytes.Length = " + xmlFileBytes.Length);
            object resObj = ser.Deserialize(stream);
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO res = resObj as MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO;
            log.Debug("===================  END - GetTravelObjectFromXml  =============");
            log.Debug("================================================================");
            return res;
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
            throw exc;
        }
    }

    [WebMethod(Description = "Load XML file data and intepret it as TravelExpenseVO serialized object")]
    public MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO
        getTravelObjectFromXmlAsStoredId(string id)
    {
        try
        {
            log.Debug("================================================================");
            log.Debug("=================  BEGIN - GetTravelObjectFromXmlAsStroedId  =============");
            System.Xml.Serialization.XmlSerializer ser = new System.Xml.Serialization.XmlSerializer(typeof(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO));
            byte[] xmlFileBytes = StoredDataRepository.Instance.GetEntry(id).Data;
            System.IO.MemoryStream stream = new System.IO.MemoryStream(xmlFileBytes);
            log.Debug("GetTravelObjectFromXmlAsStroedId: xmlFileBytes.Length = " + xmlFileBytes.Length);
            object resObj = ser.Deserialize(stream);
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO res = resObj as MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO;
            log.Debug("===================  END - GetTravelObjectFromXmlAsStroedId  =============");
            log.Debug("================================================================");
            return res;
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
            throw exc;
        }
    }

    [WebMethod(Description = "Test method that returns sample pdf")]
    public string RunTestAndGetId()
    {
        try
        {
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel =
                GetTravelObjectFromXml_Test();
            log.Debug("================================================================");
            log.Debug("=================  BEGIN - RunTestAndGetId  =============");
            MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService service =
                new MakingWaves.TravelExp.Impl.TravelExpense.TravelExpenseService();
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelReportDocumentVO resPdf =
                service.getTravelPdf(travel);
            log.Debug("getTravelPdfAsStoredId, travel=" + travel.ToString());
            string pdfId = StoredDataRepository.Instance.AddNewEntry(new StoredDataEntry("application/pdf", resPdf.PdfFileBytes));
            log.Debug("getTravelPdfAsStoredId: returning " + pdfId);
            log.Debug("===================  END - RunTestAndGetId  =============");
            log.Debug("================================================================");
            return pdfId;
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
            throw exc;
        }
    }

    private MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO GetTravelObjectFromXml_Test()
    {
        MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO travel;
        travel = DebugEx.LoadObjectContent(@"C:\Making Waves\TravelWS\ws\TravelExpWS\App_Data\TravelData.xml",
            typeof(MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO)) as
            MakingWaves.TravelExp.Impl.TravelExpense.DataStructures.TravelExpenseVO;
        return travel;
    }
}
