using System.IO;
using System.Web;
using System.Web.Configuration;
using MakingWaves.TravelExp.Impl.TravelExpense.Processing;

public class Uploader : IHttpHandler
{
    public void ProcessRequest(HttpContext _context)
    {
        //// not very elegant - change to full path of your upload folder (there are no upload folders on my site)
        //string uploadDir = "D:\\Domains\\algorithmist.net\\<path to upload folder>\\";

        if (_context.Request.Files.Count == 0)
        {
            _context.Response.Write("<result><status>Error</status><message>No files selected</message></result>");
            return;
        }

        int counter = 0;
        string id = "";
        foreach (string fileKey in _context.Request.Files)
        {
            HttpPostedFile file = _context.Request.Files[fileKey];
            //file.SaveAs(Path.Combine(uploadDir, file.FileName));
            byte[] buffer = new byte[file.ContentLength];
            file.InputStream.Read(buffer, 0, file.ContentLength);
            id = StoredDataRepository.Instance.AddNewEntry(new StoredDataEntry("text/xml", buffer));
            ++counter;
        }
        _context.Response.Write("<result>");
        if (counter != 1)
        {
            _context.Response.Write("<error>More than one file uploaded</error>");
        }
        _context.Response.Write("<storedid>"+id+"</storedid>");
        _context.Response.Write("</result>");
    }

    public bool IsReusable
    {
        get { return true; }
    }
}