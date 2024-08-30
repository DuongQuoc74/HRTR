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
using System.Collections.Generic;
using SystemAuth;

namespace HRTR.GrapeChart
{
    public partial class GC_Dashboards : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                try
                {

                    //#region Workcell
                    //DataTable dtWorkcell = Workcell.Search();
                    //ddlWorkcellS.DataSource = dtWorkcell;
                    //ddlWorkcellS.DataBind();
                    ////ddlWorkcellS.Items.Insert(0, li);
                    //#endregion
                    bool isAdmin = IsValidUserRole(new List<EPermissionRole>() { EPermissionRole.Admin, EPermissionRole.Trainer_Leader });
                    #region GC_Customers
                    DataTable dtGC_Customers = isAdmin ? GC_Customers.Search() : GC_Customers.SearchByUserProfileId(UserProfileID);
                    ddlGC_CustomersS.DataSource = dtGC_Customers;
                    ddlGC_CustomersS.DataBind();
                    ddlGC_CustomersS.Items.Insert(0, new ListItem("[Please Select]", "0"));
                    #endregion

                    #region Initial Data
                    int icurrentmonth = DateTime.Now.Month;
                    for (int i = 1; i <= 12; i++)
                    {
                        ddlMonthS.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    }
                    ddlMonthS.SelectedValue = icurrentmonth.ToString();

                    int icurrentyear = DateTime.Now.Year;
                    for (int i = icurrentyear; i >= 2012; i--)
                    {
                        ddlYearS.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    }
                    ddlYearS.SelectedValue = icurrentyear.ToString();
                    #endregion

                }
                catch
                {
                }

            }
        }
        #endregion

        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string strcustomer_id = ddlGC_CustomersS.SelectedValue.ToString();
            int iigrapecharttypeid = Convert.ToInt32(ddlGrapeChartTypeS.SelectedValue);
            string stryear = ddlYearS.SelectedValue.ToString();
            string strmonth = ddlMonthS.SelectedValue.ToString();
            string strurl = string.Empty;
            if (cbTopTen.Checked)
            {
                strurl = @"GC_Dashboards_Top10.aspx?w=";
            }
            else
            {
                strurl = @"GC_Dashboards_Workcell.aspx?w=";
            }
            strurl = strurl + strcustomer_id
                 + "&t=" + iigrapecharttypeid.ToString()
                 + "&y=" + stryear
                 + "&m=" + strmonth;
            Response.Redirect(strurl);
        }
        #endregion
    }
}