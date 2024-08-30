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
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;
using HRTR.Server;

namespace HRTR.GrapeChart
{
    public partial class EmployeeSkillTracker : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                int icurrentyear = DateTime.Now.Year;
                for (int i = icurrentyear; i >= 2012; i--)
                {
                    ddlYearS.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                ddlYearS.SelectedValue = icurrentyear.ToString();

            }
            else
            {
                DataTable dtEmployeeSkillTracker = (DataTable)ViewState["dtEmployeeSkillTracker"];
                string stremployeeidname = txtEmployeeID.Text.Trim() + " - " + txtEmployeeName.Text.Trim();
                int iyear = Convert.ToInt32(ddlYearS.SelectedValue);
                BindChartData(dtEmployeeSkillTracker, stremployeeidname, iyear);
            }

        }
        #endregion

        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindEmployeeSkillTracker();
        }

        private void BindEmployeeSkillTracker(string pstr_sort = "")
        {


            int iemployeeid_id = Convert.ToInt32(hdEmployeeID_ID.Value);

            int iyear = Convert.ToInt32(ddlYearS.SelectedValue);

            DataTable dtEmployeeSkillTracker = HRTR.Server.GC_Data.EmployeeSkillTracker(iemployeeid_id, iyear);

            grvEmployeeSkillTracker.DataSource = dtEmployeeSkillTracker;
            grvEmployeeSkillTracker.DataBind();

            string stremployeeidname = txtEmployeeID.Text.Trim() + " - " + txtEmployeeName.Text.Trim();
            BindChartData(dtEmployeeSkillTracker, stremployeeidname, iyear);

            lblEmployeeSkillTrackerByMonthMessage.Visible = false;

        }

        #endregion

        #region BindChartData
        private void BindChartData(DataTable dt, string pstr_employeeidname, int pi_year)
        {

            chartEmployeeSkillTracker.Titles[0].Text = "EMPLOYEE SKILL PERFORMANCE TRACKER - " + pstr_employeeidname + " - " + pi_year.ToString();

            chartEmployeeSkillTracker.DataSource = dt;
            chartEmployeeSkillTracker.DataBind();
            chartEmployeeSkillTracker.Visible = true;
        }
        #endregion
    }
}