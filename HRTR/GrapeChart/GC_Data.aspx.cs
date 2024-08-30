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
using System.Linq;
using System.Collections.Generic;

namespace HRTR.GrapeChart
{
    public partial class GC_Data : HCM.BasePage.BasePage
    {
        protected bool IsAdmin
        {
            get
            {
                try
                {
                    string strvalue = hdIsAdmin.Value.ToUpper();
                    if (strvalue == "1"
                        || strvalue == "TRUE"
                        || strvalue == "YES")
                    {
                        return true;
                    }
                    else
                    {
                        return Convert.ToBoolean(strvalue);
                    }
                }
                catch
                {
                    return false;
                }
            }
        }
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                bool isAdmin = IsValidUserRole(new List<EPermissionRole>() { EPermissionRole.Admin, EPermissionRole.Trainer_Leader });
                hdIsAdmin.Value = isAdmin.ToString();
                #region GC_Customers
                DataTable dtGC_Customers = isAdmin ? GC_Customers.Search() : GC_Customers.SearchByUserProfileId(UserProfileID);
                ddlGC_CustomersS.DataSource = dtGC_Customers;
                ddlGC_CustomersS.DataBind();
                ddlGC_CustomersS.Items.Insert(0, new ListItem("[All]", "0"));
                ddlGC_Customers.DataSource = dtGC_Customers;
                ddlGC_Customers.DataBind();
                ddlGC_Customers.Items.Insert(0, new ListItem("[Please Select]", "0"));
                #endregion

                #region Shift
                DataTable dtShift = CR_Shift.Search();

                ddlShiftS.DataSource = dtShift;
                ddlShiftS.DataBind();
                ddlShiftS.Items.Insert(0, new ListItem("[All]", "0"));

                ddlShift.DataSource = dtShift;
                ddlShift.DataBind();

                #endregion

                #region Station
                BindStation();
                BindStationS();
                #endregion

                #region Defect
                DataTable dtQM_Defect = QM_Defects.Search();

                ddlQM_DefectsS.DataSource = dtQM_Defect;
                ddlQM_DefectsS.DataBind();
                ddlQM_DefectsS.Items.Insert(0, new ListItem("[All]", "0"));

                ddlQM_Defects.DataSource = dtQM_Defect;
                ddlQM_Defects.DataBind();
                ddlQM_Defects.Items.Insert(0, new ListItem("[Please Select]", "0"));
                #endregion

                #region Default Values
                DateTime daEscapedDateFrom = new DateTime();
                DateTime daEscapedDateTo = new DateTime();
                try
                {
                    try
                    {
                        daEscapedDateFrom = DateTime.ParseExact(Request.QueryString["f"], "yyyyMMdd", null);
                    }
                    catch
                    {
                        daEscapedDateFrom = DateTime.Now.AddMonths(-1);
                    }
                    try
                    {
                        daEscapedDateTo = DateTime.ParseExact(Request.QueryString["t"], "yyyyMMdd", null);
                    }
                    catch
                    {
                        daEscapedDateTo = DateTime.Now;
                    }

                    ddlGC_CustomersS.SelectedValue = Request.QueryString["cs"].ToString();
                    BindStationS();
                    txtEscapedByEmployeeIDS.Text = Request.QueryString["ee"].ToString();
                }
                catch { }

                txtEscapedDateFromS.Text = daEscapedDateFrom.ToString("MM/dd/yyyy");
                txtEscapedDateToS.Text = daEscapedDateTo.ToString("MM/dd/yyyy");
                #endregion

                txtEscapedDate.Text = DateTime.Now.ToString("MM/dd/yyyy");

                Session["GrapeChartSort"] = "";
                BindData();
            }
        }
        #endregion

        #region Search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = GrapeChartData();

                //string strtempfolder = HRTRConfig.GetExportsFolder;

                ///D:\PROJECT\115. OLE Automate\OLE Data Loader\OLEDataLoader\tenfile.csv
                string strdesfile = string.Format(@"{0}\GrapeChart_{1}.xlsx"
                    , HRTRConfig.GetExportsFolder
                    , DateTime.Now.ToString("MMddyyyyHHmmss"));


                string strdesfilefullpath = MapPath(strdesfile);
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, null, null, "Grape Chart Record");

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
        protected void grvGrapeChart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                int igc_dataid = Convert.ToInt32(e.CommandArgument);
                LoadGrapeChart(igc_dataid);
                //if (e.CommandName == "Select") /// For editing
                //{
                //    mvGC_Data.ActiveViewIndex = 1; //Edit
                //}
                //else /// For deleting
                //{
                //    mvGC_Data.ActiveViewIndex = 1; //Edit
                //}
                mvGC_Data.ActiveViewIndex = 1; //Edit
                btnAdd.Visible = false;
                btnUpdateAsk.Visible = true;
                //btnDelete.Visible = true;
                ////btnCancel2.Visible = true;
                //btnCancel.Visible = true;
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
            DataTable dtGrapeChart = GrapeChartData();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtGrapeChart.DefaultView.Sort = pstr_sort;
            grvGrapeChart.DataSource = dtGrapeChart;
            grvGrapeChart.DataBind();


        }
        private DataTable GrapeChartData()
        {
            DateTime daescapeddatefrom = new DateTime();
            try
            {
                daescapeddatefrom = DateTime.ParseExact(txtEscapedDateFromS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daescapeddateto = new DateTime();
            try
            {
                daescapeddateto = DateTime.ParseExact(txtEscapedDateToS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            int icustomer_id = Convert.ToInt32(ddlGC_CustomersS.SelectedValue);
            int ishiftid = Convert.ToInt32(ddlShiftS.SelectedValue);
            int idetectedstationid = Convert.ToInt32(ddlDetectedStationS.SelectedValue);
            int iescapedstationid = Convert.ToInt32(ddlEscapedStationS.SelectedValue);
            int idefect_id = Convert.ToInt32(ddlQM_DefectsS.SelectedValue);
            string strcrd = txtCRDS.Text.Trim();
            string strserialnumber = txtSerialNumberS.Text.Trim();

            string strescapedbyemployeeid = txtEscapedByEmployeeIDS.Text.Trim();
            string strdetectedbyemployeeid = txtDetectedByEmployeeIDS.Text.Trim();
            int iismesautolinkeds = Convert.ToInt32(ddlIsMESAutoLinkedS.SelectedValue);
            return HRTR.Server.GC_Data.Search(daescapeddatefrom
                , daescapeddateto
                , icustomer_id
                , ishiftid
                , idetectedstationid
                , iescapedstationid
                , idefect_id
                , strcrd
                , strserialnumber
                , string.Empty
                , strdetectedbyemployeeid
                , strescapedbyemployeeid
                , iismesautolinkeds);
        }
        #endregion

        #region GrapeChart
        private void LoadGrapeChart(int pi_gc_dataid)
        {
            using (HRTR.Server.GC_Data gc = new HRTR.Server.GC_Data())
            {
                hdGC_DataID.Value = pi_gc_dataid.ToString();
                gc.GC_DataID = pi_gc_dataid;
                gc.Select();

                ddlGC_Customers.SelectedValue = gc.Customer_ID.ToString();
                BindStation();
                txtEscapedDate.Text = gc.EscapedDate.ToString("MM/dd/yyyy");
                ddlShift.SelectedValue = gc.ShiftID.ToString();

                ddlQM_Defects.SelectedValue = gc.Defect_ID.ToString();
                txtCRD.Text = gc.CRD;
                txtSerialNumber.Text = gc.SerialNumber;
                txtDescription.Text = gc.Description;

                try
                {
                    ddlEscapedStation.SelectedValue = gc.EscapedStationID.ToString();
                }
                catch { }
                txtEscapedByEmployeeID.Text = gc.EscapedByEmployeeID;
                try
                {
                    ddlDetectedStation.SelectedValue = gc.DetectedStationID.ToString();
                }
                catch { }
                txtDetectedByEmployeeID.Text = gc.DetectedByEmployeeID;


                lblGrapeChartMessage.Text = "";

            }
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            mvGC_Data.ActiveViewIndex = 1; //Edit
            hdGC_DataID.Value = "-2000000001";
            txtEscapedDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            ddlShift.SelectedIndex = 0;
            txtDetectedByEmployeeID.Text = "";
            ddlDetectedStation.SelectedIndex = 0;
            txtEscapedByEmployeeID.Text = "";
            ddlEscapedStation.SelectedIndex = 0;
            ddlQM_Defects.SelectedIndex = 0;
            txtCRD.Text = "";
            txtSerialNumber.Text = "";
            txtDescription.Text = "";
            lblGrapeChartMessage.Text = "";

            btnAdd.Visible = true;
            btnUpdateAsk.Visible = false;
            //btnDelete.Visible = false;
            ////btnCancel2.Visible = false;
            //btnCancel.Visible = true;

        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.GC_Data gc = new HRTR.Server.GC_Data())
                {
                    gc.GC_DataID = Convert.ToInt32(hdGC_DataID.Value);
                    gc.Delete();
                }
                mvGC_Data.ActiveViewIndex = 0; //Search
                BindData();
            }
            catch (Exception ex)
            {
                lblGrapeChartMessage.Text = ex.Message;
            }

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SaveGC_Data();
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SaveGC_Data();
        }
        private void SaveGC_Data()
        {
            try
            {
                using (HRTR.Server.GC_Data gc = new HRTR.Server.GC_Data())
                {
                    gc.GC_DataID = Convert.ToInt32(hdGC_DataID.Value);
                    gc.Customer_ID = Convert.ToInt32(ddlGC_Customers.SelectedValue);

                    gc.DetectedByEmployeeID = txtDetectedByEmployeeID.Text.Trim();
                    gc.DetectedStationID = Convert.ToInt32(ddlDetectedStation.SelectedValue);

                    gc.EscapedByEmployeeID = txtEscapedByEmployeeID.Text.Trim();
                    gc.EscapedStationID = Convert.ToInt32(ddlEscapedStation.SelectedValue);

                    gc.EscapedDate = DateTime.ParseExact(txtEscapedDate.Text, "MM/dd/yyyy", null);
                    gc.ShiftID = Convert.ToInt32(ddlShift.SelectedValue);
                    gc.Defect_ID = Convert.ToInt32(ddlQM_Defects.SelectedValue);
                    gc.CRD = txtCRD.Text.Trim();
                    gc.SerialNumber = txtSerialNumber.Text.Trim();
                    gc.Description = txtDescription.Text.Trim();

                    gc.Save();
                    hdGC_DataID.Value = gc.GC_DataID.ToString();
                }
                BindData();
                lblGrapeChartMessage.Text = "Saved successfully.";
                btnAdd.Visible = false;
                btnUpdateAsk.Visible = true;
                //btnDelete.Visible = true;
                ////btnCancel2.Visible = true;
                //btnCancel.Visible = true;
            }
            catch (Exception ex)
            {
                lblGrapeChartMessage.Text = ex.Message;
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            mvGC_Data.ActiveViewIndex = 0; //Search
        }
        #endregion

        #region Private Methods
        private void BindStation()
        {
            Int32.TryParse(ddlGC_Customers.SelectedValue, out int result);
            int icustomer_id = result;
            DataTable dtStation = GC_Station.Search(string.Empty, icustomer_id);
            ddlDetectedStation.Items.Clear();
            ddlDetectedStation.DataSource = dtStation;
            ddlDetectedStation.DataBind();
            ddlDetectedStation.Items.Insert(0, new ListItem("[Please Select]", "0"));

            ddlEscapedStation.Items.Clear();
            ddlEscapedStation.DataSource = dtStation;
            ddlEscapedStation.DataBind();
            ddlEscapedStation.Items.Insert(0, new ListItem("[Please Select]", "0"));
        }
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
        protected void ddlGC_Customers_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindStation();
        }
        #endregion
    }
}