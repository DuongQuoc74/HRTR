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
    public partial class MyGrapeChart : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                try
                {
                    using (HR_Employee emp = new HR_Employee())
                    {
                        emp.UserName = this.IdentityUserName;
                        emp.SelectByUserName();
                        hdEmployeeID_ID.Value = emp.EmployeeID_ID.ToString();
                        hdEmployeeName.Value = emp.EmployeeName;
                        hdServerDate.Value = DateTime.Today.ToString("MM/d/yyyy");
                        string strtitle = "My Grape Chart - " + emp.EmployeeID.ToString() + " - " + emp.EmployeeName;
                        this.Title = strtitle;
                        divheader.InnerText = strtitle;
                    }
                    hdIsValidEmployeeID_ID.Value = "1";
                    txtToDate.Text = DateTime.Today.ToString("MM/dd/yyyy");
                }
                catch (Exception ex)
                {
                    ShowError(lblMyGrapeChart, ex.Message);
                    btnSearch.Enabled = false;
                    hdIsValidEmployeeID_ID.Value = "0";
                }

            }
        }
        #endregion
    }
}