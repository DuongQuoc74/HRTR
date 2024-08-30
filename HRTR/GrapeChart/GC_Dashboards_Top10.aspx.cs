using System;
using System.Web.UI;
using HRTR.Server;

namespace HRTR.GrapeChart
{
    public partial class GC_Dashboards_Top10 : System.Web.UI.Page
    {
        #region Page Events        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    int iEmployeeID_ID = 0;
                    iEmployeeID_ID = Convert.ToInt32(Page.Session["EmployeeID_ID"]);
                    hdEmployeeID_ID.Value = iEmployeeID_ID.ToString();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }

                int iCustomer_ID;
                try { iCustomer_ID = Convert.ToInt32(Request.QueryString.GetValues("w")[0].ToString()); }
                catch { iCustomer_ID = 1; }
                hdCustomer_ID.Value = iCustomer_ID.ToString();

                string strCustomer = string.Empty;
                try
                {
                    using (GC_Customers w = new GC_Customers())
                    {
                        w.Customer_ID = iCustomer_ID;
                        w.Select();
                        strCustomer = w.Customer;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                hdCustomer.Value = strCustomer;
                int iTypeID, iYear, iMonth;
                try
                {
                    iTypeID = Convert.ToInt32(Request.QueryString.GetValues("t")[0].ToString());
                }
                catch { iTypeID = 1; }
                hdGrapeChartTypeID.Value = iTypeID.ToString();

                try { iYear = Convert.ToInt32(Request.QueryString.GetValues("y")[0].ToString()); }
                catch
                {
                    iYear = DateTime.Now.Year;
                }
                hdYear.Value = iYear.ToString();
                try
                {
                    iMonth = Convert.ToInt32(Request.QueryString.GetValues("m")[0].ToString());
                }
                catch
                {
                    iMonth = DateTime.Now.Month;
                }
                hdMonth.Value = iMonth.ToString();

            }
        }
        #endregion

    }
}