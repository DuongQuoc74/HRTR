using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HRTR.Server
{
    public class CcsApiErrorLog
    {
        protected CcsApiErrorLog()
        {}

        public static void Save(string requestUri, string requestMethod, string requestBody, string msgError, string terminalName, string userName)
        {
            using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
            {
                object[,] paramarr = new object[7, 2]  {
                                                            {"@Activity", "Save"},
                                                            {"@requestUri", requestUri},
                                                            {"@RequestMethod", requestMethod},
                                                            {"@RequestBody", requestBody},
                                                            {"@MessError", msgError},
                                                            {"@TerminalName", terminalName},
                                                            {"@UserName", userName}
                                                        };
                _con.GetDataTableByStore("sp_CCS_ApiErrorLog", paramarr);
            }
        }
    }
}
