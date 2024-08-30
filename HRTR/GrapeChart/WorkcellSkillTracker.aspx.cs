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
using System.Globalization;
using HRTR.Server;
using System.Collections.Generic;
using SystemAuth;

namespace HRTR.GrapeChart
{
    public partial class WorkcellSkillTracker : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                bool isAdmin = IsValidUserRole(new List<EPermissionRole>() { EPermissionRole.Admin, EPermissionRole.Trainer_Leader });
                DataTable dtWorkcell = isAdmin ? CR_Workcell.Search() : CR_Workcell.SearchByUserProfileId(UserProfileID);
                
                ddlWorkcellS.DataSource = dtWorkcell;
                ddlWorkcellS.DataBind();
                if (dtWorkcell.Rows.Count == 0)
                {
                    ddlWorkcellS.Items.Add(new ListItem("[All]", "0"));
                }


                int icurrentyear = DateTime.Now.Year;
                for (int i = icurrentyear; i >= 2012; i--)
                {
                    ddlYearS.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                ddlYearS.SelectedValue = icurrentyear.ToString();

                Session["WorkcellSkillTrackerSort"] = "";
                BindWorkcellSkillTracker();
            }
        }
        #endregion

        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindWorkcellSkillTracker();
        }
        protected void grvWorkcellSkillTracker_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 1; i <= 12; i++)
                {
                    string strMonthName = GetMonthName(i);
                    decimal deGreen = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, strMonthName));
                    int iCellColumn = i + 2;
                    if (deGreen < 100)
                        e.Row.Cells[iCellColumn].CssClass = "redcenter";
                }

            }
        }
        protected void grvWorkcellSkillTracker_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        protected void grvWorkcellSkillTracker_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "WorkcellSkillTrackerSort";
            string strSort = e.SortExpression.ToString();
            string str_sort = "" + strSort + " " + "ASC" + "";
            try
            {
                if (Session[str_ssname].ToString().Length > 4)
                {
                    string str_temp = "";
                    string str_temp2 = Session[str_ssname].ToString();
                    if (str_temp2.EndsWith("ASC"))
                    {
                        str_temp = str_temp2.Remove(str_temp2.Length - 3, 3);
                        str_temp = str_temp.Trim();
                        if (str_temp.Equals(strSort, StringComparison.OrdinalIgnoreCase))
                        {
                            str_temp2 = str_temp2.Replace("ASC", "DESC");
                            str_sort = str_temp2;
                        }
                    }

                }
            }
            catch
            {
            }
            Session[str_ssname] = str_sort;
            BindWorkcellSkillTracker(str_sort);
        }
        protected void grvWorkcellSkillTracker_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvWorkcellSkillTracker.PageIndex = e.NewPageIndex;
            BindWorkcellSkillTracker();
        }
        private void BindWorkcellSkillTracker(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["WorkcellSkillTrackerSort"] != null)
                    {
                        pstr_sort = Session["WorkcellSkillTrackerSort"].ToString();
                    }
                }
                catch { }
            }


            int iworkcellid = Convert.ToInt32(ddlWorkcellS.SelectedValue);
            int iyear = Convert.ToInt32(ddlYearS.SelectedValue);

            DataSet dsWorkcellSkillTracker = HRTR.Server.GC_Data.WorkcellSkillTracker(iworkcellid, iyear);
            DataTable dtWorkcellSkillTracker = dsWorkcellSkillTracker.Tables[0];
            if (!string.IsNullOrEmpty(pstr_sort))
                dtWorkcellSkillTracker.DefaultView.Sort = pstr_sort;
            grvWorkcellSkillTracker.DataSource = dtWorkcellSkillTracker;
            grvWorkcellSkillTracker.DataBind();

            string strworkcellname = ddlWorkcellS.SelectedItem.Text;
            BindChartData(dsWorkcellSkillTracker.Tables[1], strworkcellname, iyear);

        }
        #endregion

        #region BindChartData
        private void BindChartData(DataTable dt, string pstr_workcellname, int pi_year)
        {
            //chartEmployeeSkillTracker.Series["Green"].Color = Color.FromArgb(0, 128, 0);
            //chartEmployeeSkillTracker.Series["Yellow"].Color = Color.FromArgb(255, 255, 0);
            //chartEmployeeSkillTracker.Series["Red"].Color = Color.FromArgb(255, 0, 0);
            //chartEmployeeSkillTracker.ChartAreas[0].AxisY.Interval = 5;
            //foreach(DataRow dr in dt.Rows)
            //{
            //    chartEmployeeSkillTracker.Series["Green"].Points.AddY(Convert.ToDouble(dr["Green"]));
            //    chartEmployeeSkillTracker.Series["Yellow"].Points.AddY(Convert.ToDouble(dr["Yellow"]));
            //    chartEmployeeSkillTracker.Series["Red"].Points.AddY(Convert.ToDouble(dr["Red"]));
            //    //chartEmployeeSkillTracker.ChartAreas[0].AxisX.IsMarginVisible = false;
            //}
            //chartWorkcellSkillTracker.Series[0].CustomProperties = "BarLabelStyle = Bottom";

            chartWorkcellSkillTracker.Titles[0].Text = "WORKCELL SKILL PERFORMANCE TRACKER - " + pstr_workcellname.ToUpper() + " - " + pi_year.ToString();
            //chartEmployeeSkillTracker.ChartAreas[0].AxisX.Title = pstr_employeeidname;
            chartWorkcellSkillTracker.DataSource = dt;
            chartWorkcellSkillTracker.DataBind();

        }
        #endregion

        #region Private Methods
        private string GetMonthName(int pi_month)
        {
            string strmonthname = new DateTime(2013, pi_month, 1).ToString("MMMM", CultureInfo.InvariantCulture);
            return strmonthname;
        }
        #endregion
    }
}