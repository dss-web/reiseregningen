using System;
using System.Collections.Generic;
using System.Text;
using MakingWaves.Common.WS.Exceptions;

namespace MakingWaves.Common.WS.Utils
{
    /// <summary>
    /// Reading configuration from web.config or app.config.
    /// </summary>
    public static class ConfigUtils
    {
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(ConfigUtils));
       
        /// <summary>
        /// Gets the config setting.
        /// Handles situation when the key is not found.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="defaultVal">The default val. If null, then exception is thrown if key does not exist in config.</param>
        /// <returns></returns>
        public static string GetConfigSetting(String key, String defaultVal)
        {
            string res = System.Configuration.ConfigurationManager.AppSettings[key];
            if (res==null)
            {
                if (defaultVal==null)
                    throw new AdministratorException("No key "+key+" in web.config file!");
                return defaultVal;
            }
            return res;
        }

    }
}
