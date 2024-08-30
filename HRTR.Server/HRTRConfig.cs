using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Configuration;
using eUtilities;

namespace HRTR.Server
{
    public class HRTRConfig
    {

        public HRTRConfig()
        {
        }

        public void Dispose()
        {

        }

        /// <summary>
        /// Returns the connectionstring  for the application.
        /// </summary>
        public static string ConnectionString
        {
            get
            {
                return SystemEncryption.DecryptString(ConfigurationManager.ConnectionStrings["SqlServer"].ConnectionString);
            }
        }
        /// <summary>
        /// Returns the connectionstring for the MES application.
        /// </summary>
        public static string MESConnectionString
        {
            get
            {
                return SystemEncryption.DecryptString(ConfigurationManager.ConnectionStrings["MESSqlServer"].ConnectionString);
            }
        }

        /// <summary>
        /// eDB connection string
        /// </summary>
        public static string EDBConnectionString
        {
            get
            {
                return SystemEncryption.DecryptString(ConfigurationManager.ConnectionStrings["eDBSqlServer"].ConnectionString);
            }
        }

        public static string GetTempFolder
        {
            get { return SystemEncryption.DecryptString(readconfig_("TempFolder")); }
        }

        public static string GetTemplatesFolder
        {
            get { return SystemEncryption.DecryptString(readconfig_("TemplatesFolder")); }
        }

        public static string GetExportsFolder
        {
            get { return SystemEncryption.DecryptString(ConfigurationManager.AppSettings["ExportsFolder"].ToString()); }
        }

        #region Private Methods
        /// <summary>
        /// Read system configuration file
        /// </summary>
        /// <param name="Tagname"></param>
        /// <param name="Default">Return this value if cann't find Tagname</param>
        /// <returns></returns>
        private static string readconfig_(string strtagname, string strdefault = "")
        {
            string result = "";
            if (ConfigurationManager.AppSettings[strtagname] == null)
                result = strdefault;
            else
                result = ConfigurationManager.AppSettings[strtagname].ToString();
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strtagname"></param>
        /// <param name="strnewvalue"></param>
        /// <returns></returns>
        private bool writeconfig_(string strtagname, string strnewvalue)
        {
            Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
            config.AppSettings.Settings[strtagname].Value = strnewvalue;
            config.Save();
            return true;
        }

        #endregion
    }
}
