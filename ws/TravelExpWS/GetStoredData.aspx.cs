using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MakingWaves.TravelExp.Impl.TravelExpense.Processing;
using MakingWaves.Common.WS.Exceptions;

/// <summary>
/// Gets binary data from internal storage.
/// This method of serving data is used so that Flex application can download
/// the file from the server.
/// </summary>
public partial class GetStoredData : System.Web.UI.Page
{
    //log4net
    private static log4net.ILog log = log4net.LogManager.GetLogger(typeof(GetStoredData));

    protected void Page_Load(object sender, System.EventArgs e)
    {
        string id = Request.Params["Id"];
        ReturnData(id);
    }

    /// <summary>
    /// Returns the PDF document, from StoredPdfIdRepository, using specified id.
    /// </summary>
    /// <param name="pdfId">The PDF id.</param>
    private void ReturnData(string id)
    {
        try
        {
            StoredDataEntry res = StoredDataRepository.Instance.GetEntry(id);

            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = res.ContentType;
            if (res.ForceDownload)
                Response.AddHeader("Content-disposition", "attachment; filename="+res.SaveAsFileName);
            //Response.AddHeader("Content-Disposition", "file;filename=" + "MyTravel.xml");
            Response.OutputStream.Write(res.Data, 0, res.Data.Length);
            Response.Flush();
            //Response.Close();            
            Response.End();
            log.Info("Written StoredDataEntry with id="+id+" with ContentType="+res.ContentType);
        }
        catch (EndUserException exc)
        {
            Response.ContentType = "text/html";
            Response.Output.Write("<html><body><h2>There is no such document on the server. Please retry the operation. <br/>If it will fail again, contact administrator.</h2></body></html>");
            log.Info("Showing exception content to the user");
            exc.HandleMe();
        }
        catch (Exception exc)
        {
            MWBaseException.DefaultExceptionHandler(exc);
        }
    }
}
