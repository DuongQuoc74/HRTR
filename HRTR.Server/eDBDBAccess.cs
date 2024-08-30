using eUtilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HRTR.Server
{
   public class eDBDBAccess: MSSQLDBAccess
    {
        public eDBDBAccess()
        {
            _connString = HRTRConfig.EDBConnectionString;
        }
    }
}
