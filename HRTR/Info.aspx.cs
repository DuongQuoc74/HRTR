using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRTR
{
    public partial class Info : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblInfo.Text = "You have not right to access this page, " + NameWithoutDomain(Page.User.Identity.Name) +", please contact Training team for access permission. Go to ";
        }
        private static string NameWithoutDomain(string strname)
        {
            string[] straname = strname.Split(new char[] { '\\' });
            return straname[1];
        }
    }
}