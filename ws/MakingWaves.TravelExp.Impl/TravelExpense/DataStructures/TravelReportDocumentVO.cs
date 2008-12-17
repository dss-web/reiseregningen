using System;
using System.Collections.Generic;
using System.Text;

namespace MakingWaves.TravelExp.Impl.TravelExpense.DataStructures
{
    /// <remarks>
    /// Contains result of PDF file generation.
    /// </remarks>
    //[Serializable]
    public class TravelReportDocumentVO
    {
        /// <summary>
        /// Bytes containing PDF content.
        /// </summary>
        public byte[] PdfFileBytes;
    }
}
