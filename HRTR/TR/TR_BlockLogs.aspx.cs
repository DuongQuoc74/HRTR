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
using System.Collections.Generic;
using System.IO;
using SystemAuth;
using HRTR.Server;

namespace HRTR.TR {

    public partial class TR_BlockLogs : HCM.BasePage.BasePage {

        #region Page Events

        protected override void OnLoad(EventArgs e) {
            base.OnLoad(e);
            if (!IsPostBack) {
                //#region CR_Customers
                //DataTable dtCR_Customers = CR_Customers.Search();
                //ddlCR_CustomersS.DataSource = dtCR_Customers;
                //ddlCR_CustomersS.DataBind();
                //ddlCR_CustomersS.Items.Insert(0, new ListItem("[All]", "0"));

                //ddlCR_Customers.DataSource = dtCR_Customers;
                //ddlCR_Customers.DataBind();
                //#endregion

                DataTable dtCourse = HRTR.Server.CR_Course.Search(string.Empty, 0, 0
               , -1
               , -1
               , -1
               , -1
               , String.Empty);
                ddlCR_Course.Items.Clear();
                ddlCR_Course.DataSource = dtCourse;
                ddlCR_Course.DataBind();

                DateTime daCreatedDateFrom = new DateTime();
                DateTime daCreatedDateTo = new DateTime();
                try {
                    try {
                        daCreatedDateFrom = DateTime.ParseExact(Request.QueryString["f"], "yyyyMMdd", null);
                    }
                    catch {
                        daCreatedDateFrom = DateTime.Now.AddMonths(-1);
                    }
                    try {
                        daCreatedDateTo = DateTime.ParseExact(Request.QueryString["t"], "yyyyMMdd", null);
                    }
                    catch {
                        daCreatedDateTo = DateTime.Now;
                    }
                    ddlIsConfirmedS.SelectedValue = Request.QueryString["cf"].ToString();
                    //ddlCR_CustomersS.SelectedValue = Request.QueryString["cs"].ToString();
                }
                catch { }

                txtCreatedDateFromS.Text = daCreatedDateFrom.ToString("MM/dd/yyyy");
                txtCreatedDateToS.Text = daCreatedDateTo.ToString("MM/dd/yyyy");

                Session["BlockLogsSort"] = "";
                BindData();
            }
        }

        #endregion Page Events

        #region Search

        protected void btnSearch_Click(object sender, EventArgs e) {
            BindData();
        }

        protected void btnExport_Click(object sender, EventArgs e) {
            try {
                DataTable dt = BlockLogsData();

                //string strtempfolder = HRTRConfig.GetExportsFolder;

                string strdesfile = string.Format(@"{0}\BlockLogs_{1}.xlsx"
                    , HRTRConfig.GetExportsFolder
                    , DateTime.Now.ToString("MMddyyyyHHmmss"));

                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[5] { "EmployeeID_ID", "TR_BlockLogsID", "Customer_ID", "ConfirmedBy", "LastUpdatedBy" };

                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                dicRenameColumns.Add("UserName", "User Name");
                dicRenameColumns.Add("CreatedDate", "Created Date");
                dicRenameColumns.Add("StartDate", "Start Date");
                dicRenameColumns.Add("EndDate", "End Date");
                dicRenameColumns.Add("TotalRedGrapes", "Total Red Grapes");
                dicRenameColumns.Add("IsBlocked", "Blocked");
                dicRenameColumns.Add("BlockedDate", "Blocked Date");
                dicRenameColumns.Add("IsConfirmed", "Confirmed");
                dicRenameColumns.Add("ConfirmedDate", "Confirmed Date");
                dicRenameColumns.Add("LastUpdated", "Last Updated");
                dicRenameColumns.Add("ConfirmedByFullName", "Confirmed By");

                dicRenameColumns.Add("EmployeeID", "Employee ID");
                dicRenameColumns.Add("EmployeeIDSAP", "Employee ID SAP");
                dicRenameColumns.Add("EmployeeName", "Employee Name");

                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "Block Logs");
                //eUtilities.CSVFile.Export(dt, strdesfilefullpath, ",", null, null, false, true);

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptBlockLogs", strscript, false);
            }
            catch (Exception ex) {
                ShowError(lblSearch, ex.Message);
            }
        }

        protected void grvBlockLogs_PageIndexChanging(object sender, GridViewPageEventArgs e) {
            grvBlockLogs.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void grvBlockLogs_RowDataBound(object sender, GridViewRowEventArgs e) {
        }

        protected void grvBlockLogs_Sorting(object sender, GridViewSortEventArgs e) {
            string str_ssname = "BlockLogsSort";
            string strSort = e.SortExpression.ToString();
            string str_sort = "" + strSort + " " + "ASC" + "";
            try {
                if (Session[str_ssname].ToString().Length > 4) {
                    string str_temp = "";
                    string str_temp2 = Session[str_ssname].ToString();
                    if (str_temp2.EndsWith("ASC")) {
                        str_temp = str_temp2.Remove(str_temp2.Length - 3, 3);
                        str_temp = str_temp.Trim();
                        if (str_temp.Equals(strSort, StringComparison.OrdinalIgnoreCase)) {
                            str_temp2 = str_temp2.Replace("ASC", "DESC");
                            str_sort = str_temp2;
                        }
                    }
                }
            }
            catch {
            }
            Session[str_ssname] = str_sort;
            BindData(str_sort);
        }

        protected void grvBlockLogs_RowCommand(object sender, GridViewCommandEventArgs e) {
            if (e.CommandName == "Select" || e.CommandName == "Del") {
                int igc_blocklogsid = Convert.ToInt32(e.CommandArgument);
                LoadBlockLogs(igc_blocklogsid);
                mvTR_BlockLogs.ActiveViewIndex = 1; //Edit
            }
        }

        private void BindData(string pstr_sort = "") {
            if (string.IsNullOrEmpty(pstr_sort)) {
                try {
                    if (Session["BlockLogsSort"] != null) {
                        pstr_sort = Session["BlockLogsSort"].ToString();
                    }
                }
                catch {
                }
            }
            DataTable dtBlockLogs = BlockLogsData();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtBlockLogs.DefaultView.Sort = pstr_sort;
            grvBlockLogs.DataSource = dtBlockLogs;
            grvBlockLogs.DataBind();
        }

        private DataTable BlockLogsData() {
            DateTime dacreateddatefrom = new DateTime();
            try {
                dacreateddatefrom = DateTime.ParseExact(txtCreatedDateFromS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime dacreateddateto = new DateTime();
            try {
                dacreateddateto = DateTime.ParseExact(txtCreatedDateToS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            //int icustomer_id = Convert.ToInt32(ddlCR_CustomersS.SelectedValue);
            string stremployeeid = txtEmployeeIDS.Text.Trim();
            //int iisblocked = Convert.ToInt32(ddlIsBlockedS.SelectedValue);
            int iisconfirmed = Convert.ToInt32(ddlIsConfirmedS.SelectedValue);
            return HRTR.Server.TR_BlockLogs.Search(dacreateddatefrom
                , dacreateddateto
                //, icustomer_id
                , stremployeeid
                , iisconfirmed);
        }

        #endregion Search

        #region Block Logs

        private void LoadBlockLogs(int pi_gc_blocklogsid) {
            using (HRTR.Server.TR_BlockLogs gc = new HRTR.Server.TR_BlockLogs()) {
                hdTR_BlockLogsID.Value = pi_gc_blocklogsid.ToString();
                gc.TR_BlockLogsID = pi_gc_blocklogsid;
                gc.Select();

                ddlCR_Course.SelectedValue = gc.CourseID.ToString();
                txtCreatedDate.Text = gc.LastLogonDate.ToString("MM/dd/yyyy");
                using (HR_Employee em = new HR_Employee()) {
                    em.EmployeeID_ID = gc.EmployeeID_ID;
                    em.Select();
                    txtEmployeeIDFullName.Text = string.Format("{0} - {1}", em.EmployeeID, em.EmployeeName);
                }
                cbIsConfirmed.Checked = gc.IsConfirmed;
                txtComments.Text = "";
                lblBlockLogsMessage.Text = "";
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e) {
            ConfirmTR_BlockLogs();
        }

        private void ConfirmTR_BlockLogs() {
            try {
                using (HRTR.Server.TR_BlockLogs gc = new HRTR.Server.TR_BlockLogs()) {
                    gc.TR_BlockLogsID = Convert.ToInt32(hdTR_BlockLogsID.Value);
                    gc.Comments = txtComments.Text.Trim();
                    gc.Confirm();
                }
                BindData();
                mvTR_BlockLogs.ActiveViewIndex = 0; //Back to Search
            }
            catch (Exception ex) {
                ShowError(lblBlockLogsMessage, ex.Message);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e) {
            mvTR_BlockLogs.ActiveViewIndex = 0; //Back to Search
        }

        #endregion Block Logs

        #region Private Methods

        #endregion Private Methods
    }
}