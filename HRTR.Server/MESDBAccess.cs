using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using eUtilities;

namespace HRTR.Server
{
    public class MESDBAccess : MSSQLDBAccess
    {
        public MESDBAccess()
        {
            this._connString = HRTRConfig.MESConnectionString;
        }

        public static string SQLServer
        {
            get
            {
                return SystemEncryption.DecryptString(ConfigurationManager.AppSettings["MESSQLServer"]);
            }
        }
        public static string SQLDatabase
        {
            get
            {
                return SystemEncryption.DecryptString(ConfigurationManager.AppSettings["MESSQLDatabase"]);
            }
        }

    }
}
