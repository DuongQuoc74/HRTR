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
using System.IO;
using HRTR.Server;
using SystemAuth;
using System.Collections.Generic;

namespace HRTR.GrapeChart
{
    public partial class GC_Summary : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                bool isAdmin = IsValidUserRole(new List<EPermissionRole>() { EPermissionRole.Admin, EPermissionRole.Trainer_Leader });
                ListItem liall = new ListItem("[All]", "0");

                #region GC_Customers
                DataTable dtGC_Customers = isAdmin ? GC_Customers.Search() : GC_Customers.SearchByUserProfileId(UserProfileID);
                ddlGC_CustomersS.DataSource = dtGC_Customers;
                ddlGC_CustomersS.DataBind();
                ddlGC_CustomersS.Items.Insert(0, liall);
                #endregion

                #region Shift
                DataTable dtShift = CR_Shift.Search();

                ddlShiftS.DataSource = dtShift;
                ddlShiftS.DataBind();
                ddlShiftS.Items.Insert(0, liall);

                #endregion

                #region Station
                BindStationS();
                #endregion

                #region Defect
                DataTable dtQM_Defect = QM_Defects.Search();

                ddlQM_DefectsS.DataSource = dtQM_Defect;
                ddlQM_DefectsS.DataBind();
                ddlQM_DefectsS.Items.Insert(0, liall);

                #endregion

                DateTime daFromDate = DateTime.Now;
                DateTime daToDate = DateTime.Now;
                try
                {
                    daFromDate = DateTime.ParseExact(Request.QueryString["frm"], "yyyyMMdd", null);
                }
                catch { }
                try
                {
                    daToDate = DateTime.ParseExact(Request.QueryString["to"], "yyyyMMdd", null);
                }
                catch { }

                txtEscapedDateFromS.Text = daFromDate.ToString("MM/dd/yyyy");
                txtEscapedDateToS.Text = daToDate.ToString("MM/dd/yyyy");

                Session["GrapeChartSort"] = "";
                BindData();


            }
        }
        #endregion

        #region Search
        protected void grvGrapeChart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void grvGrapeChart_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvGrapeChart.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvGrapeChart_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvGrapeChart_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "GrapeChartSort";
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
            BindData(str_sort);
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = rptGC_Summary();

                //string strtempfolder = HRTRConfig.GetExportsFolder;

                ///D:\PROJECT\115. OLE Automate\OLE Data Loader\OLEDataLoader\tenfile.csv
                //string strdesfile = @"" + strtempfolder + @"\GrapeChart" + String.Format("{0:MMddyyyyHHmmss}", DateTime.Now) + ".csv";
                string strdesfile = string.Format(@"{0}\GrapeChart_{1}.csv"
    , HRTRConfig.GetExportsFolder
    , DateTime.Now.ToString("MMddyyyyHHmmss"));

                string strdesfilefullpath = MapPath(strdesfile);

                eUtilities.CSVFile.Export(dt, strdesfilefullpath, ",", null, null, false, true);

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptGrapeChart", strscript, false);
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["GrapeChartSort"] != null)
                    {
                        pstr_sort = Session["GrapeChartSort"].ToString();
                    }
                }
                catch
                {
                }
            }
            DataTable dtGrapeChart = rptGC_Summary();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtGrapeChart.DefaultView.Sort = pstr_sort;
            grvGrapeChart.DataSource = dtGrapeChart;
            grvGrapeChart.DataBind();
        }

        private DataTable rptGC_Summary()
        {
            DateTime daEscapedDateFrom = new DateTime();
            try
            {
                daEscapedDateFrom = DateTime.ParseExact(txtEscapedDateFromS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daEscapedDateTo = new DateTime();
            try
            {
                daEscapedDateTo = DateTime.ParseExact(txtEscapedDateToS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            int icustomer_id = Convert.ToInt32(ddlGC_CustomersS.SelectedValue);
            int ishiftid = Convert.ToInt32(ddlShiftS.SelectedValue);
            int iDetectedStationID = Convert.ToInt32(ddlDetectedStationS.SelectedValue);
            int iEscapedStationID = Convert.ToInt32(ddlEscapedStationS.SelectedValue);
            int idefect_id = Convert.ToInt32(ddlQM_DefectsS.SelectedValue);
            string strcrd = txtCRDS.Text.Trim();
            string strserialnumber = txtSerialNumberS.Text.Trim();

            string strescapedbyemployeeid = txtEscapedByEmployeeIDS.Text.Trim();
            string strdetectedbyemployeeid = txtDetectedByEmployeeIDS.Text.Trim();
            int iismesautolinkeds = Convert.ToInt32(ddlIsMESAutoLinkedS.SelectedValue);
            int igrapecharttypeid = Convert.ToInt32(ddlGrapeChartTypeS.SelectedValue);
            return HRTR.Server.GC_Data.rptGC_Summary(daEscapedDateFrom
                , daEscapedDateTo
                , icustomer_id
                , ishiftid
                , iDetectedStationID
                , iEscapedStationID
                , idefect_id
                , strcrd
                , strserialnumber
                , string.Empty
                , strdetectedbyemployeeid
                , strescapedbyemployeeid

                , iismesautolinkeds
                , igrapecharttypeid);
        }

        #endregion

        #region Private Methods
        private void BindStationS()
        {
            int icustomer_id = Convert.ToInt32(ddlGC_CustomersS.SelectedValue);
            DataTable dtStation = GC_Station.Search(string.Empty, icustomer_id, true);
            ddlDetectedStationS.Items.Clear();
            ddlDetectedStationS.DataSource = dtStation;
            ddlDetectedStationS.DataBind();
            ddlDetectedStationS.Items.Insert(0, new ListItem("[All]", "0"));

            ddlEscapedStationS.Items.Clear();
            ddlEscapedStationS.DataSource = dtStation;
            ddlEscapedStationS.DataBind();
            ddlEscapedStationS.Items.Insert(0, new ListItem("[All]", "0"));

        }
        #endregion

        #region Control Events
        protected void ddlGC_CustomersS_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindStationS();
        }
        #endregion
    }
}