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
using HRTR.Server;
using System.IO;
using eUtilities;

namespace HRTR.TR
{
    public partial class TrainingGroup : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                Session["TrainingGroupListSort"] = "";
                BindData();
            }
            else if (IsAsync)
            {
            }
            else
            {
            }
            btnNewTrainingGroup.Focus();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = SearchTrainingGroup();
                //string strtempfolder = /*HRTRConfig.GetExportsFolder*/;
                string strdesfile = string.Format(@"{0}\TrainingGroup_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[1] { "TrainingGroupID" };
                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                dicRenameColumns.Add("TrainingGroupName", "Training Group");
                dicRenameColumns.Add("IsActive", "Active");
                dicRenameColumns.Add("LastUpdatedByUserName", "Last Updated By");
                dicRenameColumns.Add("LastUpdated", "Last Updated");
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "Training Group");

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptTrainingGroup", strscript, false);

            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }
        protected void grvTrainingGroupList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvTrainingGroupList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvTrainingGroupList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvTrainingGroupList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "TrainingGroupListSort";
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
        protected void grvTrainingGroupList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int itraininggroupid = Convert.ToInt32(e.CommandArgument);
                    LoadTrainingGroup(itraininggroupid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex)
                {
                    ShowError(lblTrainingGroup, ex.Message);
                    return;
                }

                if (e.CommandName == "Select") /// For editing
                {
                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button";
                    btnDelete.CssClass = "button invisible";
                    btnUpdateAsk.Focus();
                }
                else /// For deleting
                {
                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button invisible";
                    btnDelete.CssClass = "button";
                    btnDelete.Focus();
                }
                mpeTrainingGroup.Show();

            }

        }
        private void LoadTrainingGroup(int pi_traininggroupid)
        {
            using (HRTR.Server.CR_TrainingGroup us = new HRTR.Server.CR_TrainingGroup())
            {
                hdTrainingGroupID.Value = pi_traininggroupid.ToString();
                us.TrainingGroupID = pi_traininggroupid;
                us.Select();
                txtTrainingGroupName.Text = us.TrainingGroupName;
                lblTrainingGroupMessage.Text = "";
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["TrainingGroupListSort"] != null)
                {
                    pstr_sort = Session["TrainingGroupListSort"].ToString();
                }
            }
            DataTable dtTrainingGroup = SearchTrainingGroup();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtTrainingGroup.DefaultView.Sort = pstr_sort;
            grvTrainingGroupList.DataSource = dtTrainingGroup;
            grvTrainingGroupList.DataBind();

            //DataTable dtTrainingGroup = SearchTrainingGroup();
            //dtTrainingGroup.DefaultView.Sort = pstr_sort;
            //grvTrainingGroupList.DataSource = dtTrainingGroup;
            //grvTrainingGroupList.DataBind();
        }
        private DataTable SearchTrainingGroup()
        {
            return HRTR.Server.CR_TrainingGroup.Search(Convert.ToInt16(ddlIsActiveS.SelectedValue));
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_TrainingGroup dept = new HRTR.Server.CR_TrainingGroup())
                {
                    dept.TrainingGroupID = Convert.ToInt32(hdTrainingGroupID.Value);
                    dept.TrainingGroupName = txtTrainingGroupName.Text.Trim();
                    dept.IsActive = cbIsActive.Checked;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblTrainingGroupMessage, string.Format("Saved training group {0} successfully.", txtTrainingGroupName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblTrainingGroupMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeTrainingGroup.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_TrainingGroup dept = new HRTR.Server.CR_TrainingGroup())
                {
                    dept.TrainingGroupID = Convert.ToInt32(hdTrainingGroupID.Value);
                    dept.Delete();
                }
                BindData();
                ShowMessage(lblTrainingGroupMessage, string.Format("Deleted training group {0} successfully.", txtTrainingGroupName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblTrainingGroupMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeTrainingGroup.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_TrainingGroup dept = new HRTR.Server.CR_TrainingGroup())
                {
                    dept.TrainingGroupID = Convert.ToInt32(hdTrainingGroupID.Value);
                    dept.TrainingGroupName = txtTrainingGroupName.Text;
                    dept.IsActive = cbIsActive.Checked;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblTrainingGroupMessage, string.Format("Updated training group {0} successfully.", txtTrainingGroupName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblTrainingGroupMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeTrainingGroup.Show();
            }
        }
    }
}