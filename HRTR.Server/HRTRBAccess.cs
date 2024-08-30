using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eUtilities;

namespace HRTR.Server
{
    public class SystemAuthDBAccess : MSSQLDBAccess
    {
        public SystemAuthDBAccess()
        {
            this._connString = HRTRConfig.ConnectionString;
        }
    }
}
