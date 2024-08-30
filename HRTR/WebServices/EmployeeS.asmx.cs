using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using HRTR.Server;

namespace HRTR.WebServices
{
    /// <summary>
    /// Summary description for EmployeeS
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class EmployeeS : System.Web.Services.WebService
    {
        public EmployeeS()
        {

            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }
        [WebMethod]
        public string[] GetEmployeeList(string prefixText, int count)
        {
            //DateTime daJoinedDate = new DateTime(1900, 1, 1);
            DataTable dt_Employee = HRTR.Server.HR_Employee.Search(prefixText);//search all e
            count = dt_Employee.Rows.Count;
            List<string> items = new List<string>(count);
            for (int i = 0; i < count; i++)
            {
                string str_itemid = dt_Employee.Rows[i]["EmployeeID"].ToString();
                string str_itemname = dt_Employee.Rows[i]["EmployeeID"].ToString();
                string str_pairs = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(str_itemname, str_itemid);
                try
                {
                    items.Add(str_pairs);
                }
                catch { }
            }
            return items.ToArray();
        }
        [WebMethod]
        public string[] GetEmployeeListByName(string prefixText, int count)
        {
            //DateTime daJoinedDate = new DateTime(1900, 1, 1);
            DataTable dt_Employee = HRTR.Server.HR_Employee.Search(string.Empty, string.Empty, prefixText);//search all e
            count = dt_Employee.Rows.Count;
            List<string> items = new List<string>(count);
            for (int i = 0; i < count; i++)
            {
                string str_itemid = dt_Employee.Rows[i]["EmployeeID"].ToString();
                string str_itemname = dt_Employee.Rows[i]["EmployeeName"].ToString();
                string str_pairs = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(str_itemname, str_itemid);
                try
                {
                    items.Add(str_pairs);
                }
                catch { }
            }
            return items.ToArray();
        }
    }
}
