using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using MakingWaves.Common.WS.Exceptions;

namespace MakingWaves.Common.WS.Utils
{
    /// <summary>
    /// Handling files and folders.
    /// </summary>
    public class FileUtils
    {
        /// <summary>
        /// Ensures the folder exists, and all of its parents.
        /// If not, creates all elements.
        /// </summary>
        /// <param name="destFolder">The dest folder.</param>
        public static void EnsureFolderExists(string path)
        {
            if (Directory.Exists(path))
                return;
            Directory.CreateDirectory(path);
            //int lastBS = path.LastIndexOf("\\");
            //string parentFolder = "";
            //string thisFolder = "";
            //if (lastBS == -1)
            //{
            //    parentFolder = "";
            //    thisFolder = path;
            //}
            //else
            //{
            //    parentFolder = path.Substring(0, lastBS);
            //    thisFolder = path.Substring(lastBS + 1);
            //}
            //if (parentFolder.Length>0)
            //    EnsureFolderExists(parentFolder);
            //// create child folder
            //Directory.CreateDirectory(path);

            //// throw new AdministratorException("Unknown folder, cannot be created:" + path);
            //String[] elems = path.Split("\\");

        }
    }
}
