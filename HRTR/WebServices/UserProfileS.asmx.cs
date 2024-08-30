using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using SystemAuth;

namespace SystemAuth
{
    /// <summary>
    /// Summary description for UserProfileS
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class UserProfileS : System.Web.Services.WebService
    {

        public UserProfileS()
        {

            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }
        //[WebMethod]
        //public string HelloWorld()
        //{
        //    return "Hello World";
        //}
        [WebMethod]
        public string[] GetUserProfileList(string prefixText, int count)
        {
            DataTable dt_User = SC_UserProfile.Search("", "", "", "", 0, "", 1, 0, 0, prefixText);
            count = dt_User.Rows.Count;
            List<string> items = new List<string>(count);
            for (int i = 0; i < count; i++)
            {
                string str_itemid = dt_User.Rows[i]["UserProfileID"].ToString();
                string str_itemname = dt_User.Rows[i]["FullName"].ToString();
                string str_pairs = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(str_itemname, str_itemid);
                try
                {
                    items.Add(str_pairs);
                }
                catch
                {
                }
            }
            return items.ToArray();
        }
    }
}
