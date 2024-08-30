using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using eUtilities;

namespace SystemAuth
{
    public class SystemAuthDBAccess : MSSQLDBAccess
    {
        public SystemAuthDBAccess()
        {
            this._connString = ConfigurationManager.ConnectionStrings["SqlServer"].ConnectionString;
        }
    }
}
