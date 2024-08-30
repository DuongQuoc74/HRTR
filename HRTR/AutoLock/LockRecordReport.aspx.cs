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

namespace HRTR.AutoLock
{
    public partial class LockRecordReport : HCM.BasePage.BasePage
    {
        #region General
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                Session["LockRecordReportSort"] = "";
                BindData();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = SearchLockRecord();

                //string strtempfolder = HRTRConfig.GetExportsFolder;
                string strdesfile = string.Format(@"{0}\LockRecordReport_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));

                string strdesfilefullpath = MapPath(strdesfile);
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, null, null, "Lock Record Report");
                //eUtilities.CSVFile.Export(dt, strdesfilefullpath, ",", null, null, false, true);

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptLockRecordReport", strscript, false);
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }

        protected void grvTrainingEmpLock_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvTrainingEmpLock.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void grvTrainingEmpLock_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void grvTrainingEmpLock_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "LockRecordReportSort";
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


        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["LockRecordReportSort"] != null)
                {
                    pstr_sort = Session["LockRecordReportSort"].ToString();
                }
            }
            DataTable dtLockRecord = SearchLockRecord();

            if (!string.IsNullOrEmpty(pstr_sort))
                dtLockRecord.DefaultView.Sort = pstr_sort;
            grvTrainingEmpLock.DataSource = dtLockRecord;
            grvTrainingEmpLock.DataBind();
        }
        private DataTable SearchLockRecord()
        {
            string employeeId = txtEmployeeIDS.Text.Trim();
            string employeeIdsap = txtEmployeeIDSAPS.Text.Trim();
            string userName = txtUserNameS.Text.Trim();
            string employeeName = txtEmployeeNameS.Text.Trim();
            string codeId = txtTrainingCodeIDS.Text.Trim();

            DateTime dueDate = new DateTime(1900, 1, 1);
            if (txtDueDateS.Text.Trim() != "")
            {
                try
                {
                    dueDate = DateTime.ParseExact(txtDueDateS.Text, "MM/dd/yyyy", null);
                }
                catch
                {
                    throw new Exception("Invalid Due Date.");
                }
            }

            int extendDay = 0;
            if (txtExtendDayS.Text.Trim().Length > 0)
            {
                try
                {
                    extendDay = Convert.ToInt32(txtExtendDayS.Text.Trim());
                }
                catch
                {
                    throw new Exception("Invalid Extend Day.");
                }
            }

            DateTime completeDate = new DateTime(1900, 1, 1);
            if (txtCompleteDateS.Text.Trim() != "")
            {
                try
                {
                    completeDate = DateTime.ParseExact(txtCompleteDateS.Text, "MM/dd/yyyy", null);
                }
                catch
                {
                    throw new Exception("Invalid Complete Date.");
                }
            }

            int isActive = Convert.ToInt32(ddlIsActiveS.SelectedValue);

            int isDL = Convert.ToInt32(ddlIsDL.SelectedValue);
            int isComplete = Convert.ToInt32(ddlIsComplete.SelectedValue);

            return HRTR.Server.LockRecordReport.Search(employeeId, employeeIdsap, userName,
                                                employeeName, codeId, dueDate, extendDay, completeDate, isActive, isDL, isComplete);

        }
        #endregion

        #region Tab Control
        #endregion

        #region Import

        #endregion
    }
}