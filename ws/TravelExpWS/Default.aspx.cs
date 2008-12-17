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
using System.Xml.Serialization;
using MakingWaves.TravelExp.Impl.TravelExpense.DataStructures;
using System.IO;
using System.Runtime.Serialization.Formatters.Soap;

public partial class _Default : System.Web.UI.Page
{
    /// <summary> A log4net handle for writing log for this class </summary>
    private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(_Default));

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected void ButtonTest_Click(object sender, EventArgs e)
    {
        TravelExpense te = new TravelExpense();        
        string id = te.RunTestAndGetId();
        Response.Redirect("/TravelExpWS/GetStoredData.aspx?id=" + id);
    }
}
