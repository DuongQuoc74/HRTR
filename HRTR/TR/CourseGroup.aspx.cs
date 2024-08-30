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
    public partial class CourseGroup : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                Session["CourseGroupListSort"] = "";
                BindData();
            }
            else if (IsAsync)
            {
            }
            else
            {
            }
            btnNewCourseGroup.Focus();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = SearchCourseGroup();
                //string strtempfolder = HRTRConfig.GetExportsFolder;
                string strdesfile = string.Format(@"{0}\CourseGroup_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[2] { "CourseGroupID", "CourseID" };
                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                dicRenameColumns.Add("TrainingGroupName", "Training Group");
                dicRenameColumns.Add("CourseGroupName", "Course Group");
                dicRenameColumns.Add("CourseName", "Course Name");
                dicRenameColumns.Add("ExpiredInMonths", "Expired In (Month(s))");
                dicRenameColumns.Add("IsActive", "Active");
                dicRenameColumns.Add("LastUpdatedByUserName", "Last Updated By");
                dicRenameColumns.Add("LastUpdated", "Last Updated");
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "Course Group");

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptCourseGroup", strscript, false);

            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }
        protected void grvCourseGroupList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvCourseGroupList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvCourseGroupList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvCourseGroupList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "CourseGroupListSort";
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
        protected void grvCourseGroupList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int icoursegroupid = Convert.ToInt32(e.CommandArgument);
                    LoadCourseGroup(icoursegroupid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex)
                {
                    ShowError(lblCourseGroup, ex.Message);
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
                mpeCourseGroup.Show();

            }

        }
        private void LoadCourseGroup(int pi_coursegroupid)
        {
            using (HRTR.Server.CR_CourseGroup us = new HRTR.Server.CR_CourseGroup())
            {
                hdCourseGroupID.Value = pi_coursegroupid.ToString();
                us.CourseGroupID = pi_coursegroupid;
                us.Select();
                txtCourseGroupName.Text = us.CourseGroupName;
                txtExpiredInMonths.Text = us.ExpiredInMonths.ToString();
                lblCourseGroupMessage.Text = "";
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["CourseGroupListSort"] != null)
                {
                    pstr_sort = Session["CourseGroupListSort"].ToString();
                }
            }
            DataTable dtTrainingGroup = SearchCourseGroup();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtTrainingGroup.DefaultView.Sort = pstr_sort;
            grvCourseGroupList.DataSource = dtTrainingGroup;
            grvCourseGroupList.DataBind();

            //DataTable dtCourseGroup = HRTR.Server.CR_CourseGroup.Search(txtCourseGroupNameS.Text.Trim());
            //dtCourseGroup.DefaultView.Sort = pstr_sort;
            //grvCourseGroupList.DataSource = dtCourseGroup;
            //grvCourseGroupList.DataBind();
        }
        private DataTable SearchCourseGroup()
        {
            return HRTR.Server.CR_CourseGroup.Search(txtCourseGroupNameS.Text.Trim(), Convert.ToInt16(ddlIsActiveS.SelectedValue));
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_CourseGroup dept = new HRTR.Server.CR_CourseGroup())
                {
                    dept.CourseGroupID = Convert.ToInt32(hdCourseGroupID.Value);
                    dept.CourseGroupName = txtCourseGroupName.Text.Trim();
                    try
                    {
                        dept.ExpiredInMonths = Convert.ToInt32(txtExpiredInMonths.Text);
                    }
                    catch
                    {
                        throw new Exception("Invalid Expired In (Month(s)).");
                    }
                    dept.IsActive = cbIsActive.Checked;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblCourseGroupMessage, string.Format("Saved course group {0} successfully.", txtCourseGroupName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblCourseGroupMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeCourseGroup.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_CourseGroup dept = new HRTR.Server.CR_CourseGroup())
                {
                    dept.CourseGroupID = Convert.ToInt32(hdCourseGroupID.Value);
                    dept.Delete();
                }
                BindData();
                ShowMessage(lblCourseGroupMessage, string.Format("Deleted course group {0} successfully.", txtCourseGroupName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblCourseGroupMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeCourseGroup.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_CourseGroup dept = new HRTR.Server.CR_CourseGroup())
                {
                    dept.CourseGroupID = Convert.ToInt32(hdCourseGroupID.Value);
                    dept.CourseGroupName = txtCourseGroupName.Text;
                    try
                    {
                        dept.ExpiredInMonths = Convert.ToInt32(txtExpiredInMonths.Text);
                    }
                    catch
                    {
                        throw new Exception("Invalid Expired In (Month(s)).");
                    }
                    dept.IsActive = cbIsActive.Checked;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblCourseGroupMessage, string.Format("Updated course group {0} successfully.", txtCourseGroupName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblCourseGroupMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeCourseGroup.Show();
            }
        }
    }
}