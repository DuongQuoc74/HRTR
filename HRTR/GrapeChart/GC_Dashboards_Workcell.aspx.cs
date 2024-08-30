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
using System.Drawing;
using HRTR.Server;

namespace HRTR.GrapeChart
{
    public partial class GC_Dashboards_Workcell : System.Web.UI.Page
    {
        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    hdEmployeeID_ID.Value = Page.Session["EmployeeID_ID"].ToString();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                try { hdCustomer_ID.Value = Request.QueryString.GetValues("w")[0].ToString(); }
                catch { hdCustomer_ID.Value = ""; }
                string strCustomer = string.Empty;
                try
                {
                    GC_Customers w = new GC_Customers();
                    w.Customer_ID = Convert.ToInt32(Request.QueryString.GetValues("w")[0].ToString());
                    w.Select();
                    strCustomer = w.Customer;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                hdCustomer.Value = strCustomer;
                int iGrapeChartTypeID = 1;
                try { iGrapeChartTypeID = Convert.ToInt32(Request.QueryString.GetValues("t")[0].ToString()); }
                catch { iGrapeChartTypeID = 1; }
                hdGrapeChartTypeID.Value = iGrapeChartTypeID.ToString();
                int iYear = DateTime.Now.Year;
                try { iYear = Convert.ToInt32(Request.QueryString.GetValues("y")[0].ToString()); }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                hdYear.Value = iYear.ToString();
                int iMonth = DateTime.Now.Month;
                try { iMonth = Convert.ToInt32(Request.QueryString.GetValues("m")[0].ToString()); }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                hdMonth.Value = iMonth.ToString();
            }
        }
        #endregion
    }
}