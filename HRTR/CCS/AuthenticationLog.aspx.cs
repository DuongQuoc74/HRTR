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

namespace HRTR.CCS
{
    public partial class AuthenticationLog : HCM.BasePage.BasePage
    {
        #region General
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                DateTime daLoginTimeFrom = new DateTime();
                DateTime daLoginTimeTo = new DateTime();
                try
                {
                    try
                    {
                        daLoginTimeFrom = DateTime.ParseExact(Request.QueryString["f"], "yyyyMMdd", null);
                    }
                    catch
                    {
                        daLoginTimeFrom = DateTime.Now.AddMonths(-1);
                    }
                    try
                    {
                        daLoginTimeTo = DateTime.ParseExact(Request.QueryString["t"], "yyyyMMdd", null);
                    }
                    catch
                    {
                        daLoginTimeTo = DateTime.Now;
                    }
                    txtEmployeeIDS.Text = Request.QueryString["e"].ToString();
                    txtUserNameS.Text = Request.QueryString["un"].ToString();
                }
                catch { }

                txtLoginTimeFromS.Text = daLoginTimeFrom.ToString("MM/dd/yyyy");
                txtLoginTimeToS.Text = daLoginTimeTo.ToString("MM/dd/yyyy");

                Session["AuthenticationLogSort"] = "";
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
                string strdesfile = string.Format(@"{0}\CCSLoginHistory_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));

                string strdesfilefullpath = MapPath(strdesfile);
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, null, null, "CCS Login History");

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptCCSLoginHistory", strscript, false);
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
            string str_ssname = "AuthenticationLogSort";
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
                if (Session["AuthenticationLogSort"] != null)
                {
                    pstr_sort = Session["AuthenticationLogSort"].ToString();
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
            string stremployeeid = txtEmployeeIDS.Text.Trim();
            string strusername = txtUserNameS.Text.Trim();
            DateTime dalogintimefrom = new DateTime();
            try
            {
                dalogintimefrom = DateTime.ParseExact(txtLoginTimeFromS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime dalogintimeto = new DateTime();
            try
            {
                dalogintimeto = DateTime.ParseExact(txtLoginTimeToS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            return HRTR.Server.CCS_AuthenticationLog.Search(dalogintimefrom, dalogintimeto, strusername, stremployeeid);

        }
        #endregion
    }
}