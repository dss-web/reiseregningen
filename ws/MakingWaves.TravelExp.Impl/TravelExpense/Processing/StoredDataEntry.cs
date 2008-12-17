using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.TravelExp.Impl.TravelExpense.DataStructures;

namespace MakingWaves.TravelExp.Impl.TravelExpense.Processing
{
    /// <summary>
    /// Stores one entry for stored pdf document data
    /// </summary>
    public class StoredDataEntry
    {
        public DateTime ExpirationDate;

        public byte[] Data;

        public string ContentType;

        /// <summary>
        /// If true, then special content-disposition is sent, then browser will download the file.
        /// </summary>
        public bool ForceDownload = false;

        /// <summary>
        /// Name of file to be proposed, when ForceDownload=true.
        /// </summary>
        public string SaveAsFileName;

        public string Id;

        /// <summary>
        /// Initializes a new instance of the <see cref="StoredDataEntry"/> class.
        /// </summary>
        /// <param name="contentType">Type of the content for HTTP answer.</param>
        /// <param name="data">The data - array of bytes.</param>
        public StoredDataEntry(string contentType, byte[] data)
        {
            this.Data = data;
            this.ContentType = contentType;
            ExpirationDate = DateTime.Now.AddDays(1);
        }
    }
}
