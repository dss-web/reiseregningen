using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.Common.WS.Exceptions;
using MakingWaves.TravelExp.Impl.TravelExpense.DataStructures;

namespace MakingWaves.TravelExp.Impl.TravelExpense.Processing
{
    /// <summary>
    /// A repository for storing data structures for generating PDF files.
    /// This is for solution, when a Flex client sends WebService request first and gets ID of request,
    /// and then calls aspx page to get the PDF result.
    /// </summary>
    public class StoredDataRepository
    {
        //log4net
        private static log4net.ILog log = log4net.LogManager.GetLogger(typeof(StoredDataRepository));

        private static StoredDataRepository instance = null;

        private Dictionary<string, StoredDataEntry> entries = new Dictionary<string,StoredDataEntry>();

        /// <summary>
        /// Initializes a new instance of the <see cref="StoredPdfIdRepository"/> class.
        /// Get instance by calling Instance property.
        /// </summary>
        private StoredDataRepository ()
	    {
            
        }

        /// <summary>
        /// Creates the instance.
        /// Call it only if global.asax, or other place.
        /// </summary>
        public static void CreateInstance()
        {
            instance = new StoredDataRepository();
            log.Info("Created new StoredDataRepository instance");
        }

        /// <summary>
        /// Gets the instance.
        /// </summary>
        /// <value>The instance.</value>
        public static StoredDataRepository Instance
        {
            get
            {
                if (instance == null)
                {
                    log.Error("Instance not existing, and 'Instance' property called. Creating instance then...");
                    CreateInstance();
                }
                return instance;
            }
        }

        /// <summary>
        /// Deletes the old entries. Delete i.e. entries that have expired.
        /// </summary>
        private void DeleteOldEntries()
        {
            List<string> expiredEntries = new List<string>();
            DateTime curTime = DateTime.Now;
            // collect entries to be removed
            foreach (StoredDataEntry entry in entries.Values)
            {
                if (entry.ExpirationDate < curTime)
                {
                    expiredEntries.Add(entry.Id);
                }
            }
            // delete all collected elements
            foreach (string id in expiredEntries)
            {
                entries.Remove(id);
            }
        }

        
        
        /// <summary>
        /// Adds the new entry to the repostiory.
        /// Returns id of this entry.
        /// </summary>
        /// <param name="resPdf">The res PDF.</param>
        /// <returns></returns>
        public string AddNewEntry(StoredDataEntry entry)
        {
            DeleteOldEntries();
            string guid = GenerateNewId();
            log.Debug("generated guid for new pdfEntry = " + guid);
            entries.Add(guid, entry);
            entry.Id = guid;
            return guid;
        }

        private static int uniqIdCounter = 0;
        private string GenerateNewId()
        {
            string res = Guid.NewGuid().ToString("N");
            res += uniqIdCounter;
            ++uniqIdCounter;
            return res;
        }

        /// <summary>
        /// Gets the entry.
        /// </summary>
        /// <param name="id">The id returned by AddNewEntry.</param>
        /// <returns></returns>
        public StoredDataEntry GetEntry(string id)
        {
            if (!entries.ContainsKey(id))
            {
                log.Error("User called to get entry that does not exist: "+id+"\nCurrent repository content is:\n"+ToString());
                throw new EndUserException("Specified entry has not been found");
            }
            DeleteOldEntries();
            return entries[id];
        }

        /// <summary>
        /// Deletes the entry.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public bool DeleteEntry(string id)
        {
            bool res = entries.Remove(id);
            DeleteOldEntries();
            return res;
        }

    }
}
