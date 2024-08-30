using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using eUtilities;
using SystemAuth;

namespace SystemAuth
{
    public partial class ASUserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int i_type = 0;
            if (Request.QueryString["type"] != null)
            {
                i_type = Convert.ToInt32(Request.QueryString["type"]);
            }
            if (i_type == 1)
            {
                int i_userprofileid = 0;
                if (Request.QueryString["userprofileid"] != null)
                {
                    i_userprofileid = Convert.ToInt32(Request.QueryString["userprofileid"]);
                }
                GetUserProfileByUserProfileID(i_userprofileid);
            }
            else if (i_type == 8)
            {
                string str_search = "";
                if (Request.QueryString["search"] != null)
                {
                    str_search = Convert.ToString(Request.QueryString["search"]);
                }
                SearchUserInDomain(str_search);
            }
        }
        private void GetUserProfileByUserProfileID(int pi_userprofileid)
        {
            StringBuilder sb = new StringBuilder();
            try
            {
                using (SC_UserProfile us = new SC_UserProfile())
                {
                    us.UserProfileID = pi_userprofileid;
                    us.Select();
                    sb.Append("1;"
                                + us.UserName + ";"
                                + us.EmployeeID + ";"
                                + us.FullName + ";"
                                + us.Email + ";"
                                + us.DepartmentID + ";"
                                + us.ContactNo + ";"
                                + us.IsActive + ";"
                                );
                }
            }
            catch (Exception ex)
            {
                sb.Append("0;" + ex.Message);
            }
            Response.Clear();
            Response.ContentType = "text/xml";
            Response.Write(sb.ToString());
            Response.End();
        }
        private void SearchUserInDomain(string pstr_search)
        {
            string strreturn = eUtilities.DomainUser.GetUserInfoInDomain(pstr_search);
            StringBuilder sb = new StringBuilder();
            sb.Append(strreturn);
            Response.Clear();
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}