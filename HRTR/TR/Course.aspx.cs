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

namespace HRTR.TR {

    public partial class Course : HCM.BasePage.BasePage {

        protected override void OnLoad(EventArgs e) {
            base.OnLoad(e);
            if (!IsPostBack) {
                DataTable dtCourseGroup = HRTR.Server.CR_CourseGroup.Search("", 1);
                //CourseGroup
                ddlCourseGroupS.DataSource = dtCourseGroup;
                ddlCourseGroupS.DataBind();
                ddlCourseGroupS.Items.Insert(0, new ListItem("[All]", "0"));

                //CourseGroup

                ddlCourseGroup.DataSource = dtCourseGroup;
                ddlCourseGroup.DataBind();
                ddlCourseGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));

                //Code 1: TrainingGroup, refer to MDType table
                DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);
                //TrainingGroup
                ddlTrainingGroupS.DataSource = dtTrainingGroup;
                ddlTrainingGroupS.DataBind();
                ddlTrainingGroupS.Items.Insert(0, new ListItem("[All]", "0"));

                //TrainingGroup

                ddlTrainingGroup.DataSource = dtTrainingGroup;
                ddlTrainingGroup.DataBind();
                ddlTrainingGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));

                Session["CourseListSort"] = "";
                BindData();
            }
            else if (IsAsync) {
            }
            else { }
            btnNewCourse.Focus();
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
        }

        protected void btnSearch_Click(object sender, EventArgs e) {
            BindData();
        }

        protected void btnExport_Click(object sender, EventArgs e) {
            try {
                DataTable dt = SearchCourse();

                //DataView view = new DataView(dt);
                //DataTable newTable = view.ToTable(false, "EmployeeID", "EmployeeIDSAP", "UserName", "EmployeeName", "TrainingCodeID", "Description", "DueDate", "ExtendDay", "ExtendFromDate", "CompleteDate");

                //string strtempfolder = HRTRConfig.GetExportsFolder;

                //string strdesfile = @"" + strtempfolder + @"\EmpTrainingLock_"
                //    + String.Format("{0:MMddyyyyHHmmss}", DateTime.Now)
                //    + "_" + this.UserProfileID.ToString()
                //    + ".csv";

                //string strdesfilefullpath = MapPath(strdesfile);

                //eUtilities.CSVFile.Export(newTable, strdesfilefullpath, ",");
                //string stropenfile = @"/HRTR.UI" + PathMap(strdesfilefullpath);
                //string strtempfolder = HRTRConfig.GetExportsFolder;
                string strdesfile = string.Format(@"{0}\Course_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[3] { "TrainingGroupID", "CourseID", "CourseGroupID" };

                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string> {
                    { "TrainingGroupName", "Training Group" },
                    { "CourseGroupName", "Course Group" },
                    { "CourseName", "Course Name" },
                    { "ExpiredInMonths", "Expired In (Month(s))" },
                    { "MinPoint", "Min Point" },
                    { "MaxPoint", "Max Point" },
                    { "HasVA", "Has VA" },
                    { "IsCritical", "Critical" },
                    { "IsOrientation", "Orientation" },
                    { "IsCertifiedPerFamily", "Certified Per Family" },
                    { "EffectiveDate", "Effective Date" },
                    { "NumberOfCriticalDays", "Number Of Log In Day" },
                    { "IsActive", "Active" },
                    { "LastUpdatedByUserName", "Last Updated By" },
                    { "LastUpdated", "Last Updated" }
                };

                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "Course");
                //eUtilities.CSVFile.Export(dt, strdesfilefullpath, ",", null, null, false, true);

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptCourse", strscript, false);
            }
            catch (Exception ex) {
                ShowError(lblSearch, ex.Message);
            }
        }

        private DataTable SearchCourse() {
            string strcoursename = txtCourseNameS.Text;
            int itraininggroup = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);
            int icoursegroup = Convert.ToInt32(ddlCourseGroupS.SelectedValue);
            int ihasva = Convert.ToInt16(ddlHasVAS.SelectedValue);
            int iiscritical = Convert.ToInt16(ddlIsCriticalS.SelectedValue);
            int iisorientation = Convert.ToInt16(ddlIsOrientationS.SelectedValue);
            int iIsCertifiedPerFamily = Convert.ToInt16(ddlCertifiedPerFamily.SelectedValue);
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);

            return HRTR.Server.CR_Course.Search(
                strcoursename,
                icoursegroup,
                itraininggroup,
                ihasva,
                iiscritical,
                iisorientation,
                iIsCertifiedPerFamily,
                string.Empty,
                iisactive);
        }

        protected void grvCourseList_PageIndexChanging(object sender, GridViewPageEventArgs e) {
            grvCourseList.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void grvCourseList_RowDataBound(object sender, GridViewRowEventArgs e) {
        }

        protected void grvCourseList_Sorting(object sender, GridViewSortEventArgs e) {
            string str_ssname = "CourseListSort";
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
            catch { }
            Session[str_ssname] = str_sort;
            BindData(str_sort);
        }

        protected void grvCourseList_RowCommand(object sender, GridViewCommandEventArgs e) {
            if (e.CommandName == "Select" || e.CommandName == "Del") {
                try {
                    int icourseid = Convert.ToInt32(e.CommandArgument);
                    LoadCourse(icourseid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex) {
                    ShowError(lblCourse, ex.Message);
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
                mpeCourse.Show();
            }
        }

        private void LoadCourse(int pi_courseid) {
            using (HRTR.Server.CR_Course us = new HRTR.Server.CR_Course()) {
                hdCourseID.Value = pi_courseid.ToString();
                us.CourseID = pi_courseid;
                us.Select();
                txtCourseName.Text = us.CourseName;
                ddlTrainingGroup.SelectedValue = us.TrainingGroupID.ToString();
                ddlCourseGroup.SelectedValue = us.CourseGroupID.ToString();
                txtExpiredInMonths.Text = us.ExpiredInMonths.ToString();
                txtMinPoint.Text = us.MinPoint.ToString();
                txtMaxPoint.Text = us.MaxPoint.ToString();
                cbHasVA.Checked = us.HasVA;
                cbIsCritical.Checked = us.IsCritical;
                cbIsOrientation.Checked = us.IsOrientation;
                cbCertifiedPerFamily.Checked = us.IsCertifiedPerFamily;
                DateTime daEffectiveDate = Convert.ToDateTime(us.EffectiveDate.ToString());
                txtEffectiveDate.Text = daEffectiveDate.ToString("MM/dd/yyyy");
                if (cbIsOrientation.Checked == false) {
                    imgEffectiveDate.Attributes.Add("class", "invisible");
                    lblEffectiveDate.CssClass = "invisible";
                    txtEffectiveDate.CssClass = "invisible";
                    txtEffectiveDate.Text = "";
                    rfvEffectiveDate.IsValid = false;
                    rfvEffectiveDate.Enabled = false;
                }
                else {
                    imgEffectiveDate.Attributes.Add("class", "dateselected");
                    lblEffectiveDate.CssClass = "label";
                    txtEffectiveDate.CssClass = "textbox";
                    rfvEffectiveDate.IsValid = true;
                    rfvEffectiveDate.Enabled = true;
                }
                txtNumberOfCriticalDays.Text = us.NumberOfCriticalDays.ToString();
                cbIsActive.Checked = us.IsActive;
                lblCourseMessage.Text = "";
            }
        }

        private void BindData(string pstr_sort = "") {
            if (string.IsNullOrEmpty(pstr_sort)) {
                if (Session["CourseListSort"] != null) {
                    pstr_sort = Session["CourseListSort"].ToString();
                }
            }
            //string strcoursename = txtCourseNameS.Text;
            //int itraininggroup = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);
            //int icoursegroup = Convert.ToInt32(ddlCourseGroupS.SelectedValue);
            //int ihasva = Convert.ToInt16(ddlHasVAS.SelectedValue);
            //int iiscritical = Convert.ToInt16(ddlIsCriticalS.SelectedValue);
            //DataTable dtCourse = HRTR.Server.CR_Course.Search(strcoursename, icoursegroup
            //    , itraininggroup, ihasva, iiscritical);
            DataTable dtCourse = SearchCourse();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtCourse.DefaultView.Sort = pstr_sort;
            grvCourseList.DataSource = dtCourse;
            grvCourseList.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e) {
            try {
                using (HRTR.Server.CR_Course dept = new HRTR.Server.CR_Course()) {
                    dept.CourseID = Convert.ToInt32(hdCourseID.Value);
                    dept.CourseName = txtCourseName.Text;
                    dept.CourseGroupID = Convert.ToInt32(ddlCourseGroup.SelectedValue);
                    dept.TrainingGroupID = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
                    try {
                        dept.ExpiredInMonths = Convert.ToInt32(txtExpiredInMonths.Text);
                    }
                    catch {
                        throw new Exception("Invalid Expired In (Month(s)).");
                    }
                    try {
                        dept.NumberOfCriticalDays = Convert.ToInt32(txtNumberOfCriticalDays.Text);
                    }
                    catch {
                        throw new Exception("Invalid Number Of Log In Day.");
                    }

                    dept.MinPoint = Convert.ToDecimal(txtMinPoint.Text);
                    dept.MaxPoint = Convert.ToDecimal(txtMaxPoint.Text);

                    dept.HasVA = cbHasVA.Checked;
                    dept.IsCritical = cbIsCritical.Checked;
                    dept.IsOrientation = cbIsOrientation.Checked;
                    dept.IsCertifiedPerFamily = cbCertifiedPerFamily.Checked;

                    DateTime daEffectiveDate = new DateTime(1900, 1, 1);
                    if (cbIsOrientation.Checked) {
                        try {
                            daEffectiveDate = DateTime.ParseExact(txtEffectiveDate.Text, "MM/dd/yyyy", null);
                        }
                        catch {
                            daEffectiveDate = DateTime.Now;
                        }
                    }
                    dept.EffectiveDate = daEffectiveDate;

                    dept.IsActive = cbIsActive.Checked;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblCourseMessage, string.Format("Saved course {0} successfully.", txtCourseName.Text));
            }
            catch (Exception ex) {
                ShowError(lblCourseMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeCourse.Show();
                if (cbIsOrientation.Checked == false) {
                    imgEffectiveDate.Attributes.Add("class", "invisible");
                    lblEffectiveDate.CssClass = "invisible";
                    txtEffectiveDate.CssClass = "invisible";
                    txtEffectiveDate.Text = "";
                    rfvEffectiveDate.IsValid = false;
                    rfvEffectiveDate.Enabled = false;
                }
                else {
                    imgEffectiveDate.Attributes.Add("class", "dateselected");
                    lblEffectiveDate.CssClass = "label";
                    txtEffectiveDate.CssClass = "textbox";
                    rfvEffectiveDate.IsValid = true;
                    rfvEffectiveDate.Enabled = true;
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e) {
            try {
                using (HRTR.Server.CR_Course dept = new HRTR.Server.CR_Course()) {
                    dept.CourseID = Convert.ToInt32(hdCourseID.Value);
                    dept.Delete();
                }
                BindData();
                ShowMessage(lblCourseMessage, string.Format("Deleted course {0} successfully.", txtCourseName.Text));
            }
            catch (Exception ex) {
                ShowError(lblCourseMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeCourse.Show();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e) {
            try {
                using (HRTR.Server.CR_Course dept = new HRTR.Server.CR_Course()) {
                    dept.CourseID = Convert.ToInt32(hdCourseID.Value);
                    dept.CourseName = txtCourseName.Text;
                    dept.CourseGroupID = Convert.ToInt32(ddlCourseGroup.SelectedValue);
                    dept.TrainingGroupID = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
                    try {
                        dept.ExpiredInMonths = Convert.ToInt32(txtExpiredInMonths.Text);
                    }
                    catch {
                        throw new Exception("Invalid Expired In (Month(s)).");
                    }
                    try {
                        if (string.IsNullOrEmpty(txtNumberOfCriticalDays.Text))
                            txtNumberOfCriticalDays.Text = "0";
                        dept.NumberOfCriticalDays = Convert.ToInt32(txtNumberOfCriticalDays.Text);
                    }
                    catch {
                        throw new Exception("Invalid Number Of Log In Day.");
                    }

                    dept.MinPoint = Convert.ToDecimal(txtMinPoint.Text);
                    dept.MaxPoint = Convert.ToDecimal(txtMaxPoint.Text);

                    dept.HasVA = cbHasVA.Checked;
                    dept.IsCritical = cbIsCritical.Checked;
                    dept.IsOrientation = cbIsOrientation.Checked;
                    dept.IsCertifiedPerFamily = cbCertifiedPerFamily.Checked;

                    DateTime daEffectiveDate = new DateTime(1900, 1, 1);
                    if (cbIsOrientation.Checked) {
                        try {
                            daEffectiveDate = DateTime.ParseExact(txtEffectiveDate.Text, "MM/dd/yyyy", null);
                        }
                        catch {
                            daEffectiveDate = DateTime.Now;
                        }
                    }
                    dept.EffectiveDate = daEffectiveDate;

                    dept.IsActive = cbIsActive.Checked;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblCourseMessage, string.Format("Updated course {0} successfully.", txtCourseName.Text));
            }
            catch (Exception ex) {
                ShowError(lblCourseMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeCourse.Show();
            }
        }

        #region Import

        protected void btnImport_Click(object sender, EventArgs e) {
            pnSearch.Visible = false;
            pnCourse.Visible = false;
            pnNew.Visible = false;
            //pnImport.Visible = true;
            //grvCourseListTemp.Visible = false;
            //btnUploadAsk.Visible = false;
        }

        //protected void grvCourseListTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    grvCourseListTemp.PageIndex = e.NewPageIndex;
        //    BindDataTemp();
        //}
        //protected void grvCourseListTemp_Sorting(object sender, GridViewSortEventArgs e)
        //{
        //    string str_ssname = "CourseListTempSort";
        //    string strSort = e.SortExpression.ToString();
        //    string str_sort = "" + strSort + " " + "ASC" + "";
        //    try
        //    {
        //        if (Session[str_ssname].ToString().Length > 4)
        //        {
        //            string str_temp = "";
        //            string str_temp2 = Session[str_ssname].ToString();
        //            if (str_temp2.EndsWith("ASC"))
        //            {
        //                str_temp = str_temp2.Remove(str_temp2.Length - 3, 3);
        //                str_temp = str_temp.Trim();
        //                if (str_temp.Equals(strSort, StringComparison.OrdinalIgnoreCase))
        //                {
        //                    str_temp2 = str_temp2.Replace("ASC", "DESC");
        //                    str_sort = str_temp2;
        //                }
        //            }

        //        }
        //    }
        //    catch { }
        //    Session[str_ssname] = str_sort;
        //    BindDataTemp(str_sort);
        //}
        //protected void AsyncFUCourse_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        //{
        //    string strext = Path.GetExtension(AsyncFUCourse.FileName);
        //    if (strext == ".xls" || strext == ".xlsx")
        //    {
        //        string strfilename = AsyncFUCourse.FileName;
        //        string strtempfolder = HRTRConfig.GetTempFolder;
        //        string savePath = MapPath(Path.Combine(strtempfolder, strfilename));
        //        AsyncFUCourse.SaveAs(savePath);
        //    }
        //    else
        //    {
        //        AsyncFUCourse.ErrorBackColor = System.Drawing.Color.Red;
        //    }
        //}
        //private void BindDataTemp(string pstr_sort = "")
        //{
        //    if (string.IsNullOrEmpty(pstr_sort))
        //    {
        //        if (Session["CourseListTempSort"] != null)
        //        {
        //            pstr_sort = Session["CourseListTempSort"].ToString();
        //        }
        //    }
        //    DataTable dt = HRTR.Server.CR_Course.SearchTemp(this.UserProfileID);
        //    if (!string.IsNullOrEmpty(pstr_sort))
        //        dt.DefaultView.Sort = pstr_sort;
        //    grvCourseListTemp.DataSource = dt;
        //    grvCourseListTemp.DataBind();
        //    grvCourseListTemp.Visible = true;

        //    int itotal = dt.Rows.Count;
        //    DataView dvEmployeeTemp = dt.DefaultView;
        //    dvEmployeeTemp.RowFilter = "[IsValid] = True";
        //    int ivalid = dvEmployeeTemp.Count;
        //    int iinvalid = itotal - ivalid;
        //    btnUploadAsk.Visible = true;
        //    if (ivalid > 0)
        //        btnUploadAsk.Enabled = true;
        //    else
        //        btnUploadAsk.Enabled = false;

        //    lblUpload.Text = string.Format("Total: {0} record(s), Valid: {1} record(s), Invalid: {2} record(s).", itotal, ivalid, iinvalid);
        //}
        //protected void btnPreview_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        lblUpload.Text = "";
        //        string strfilename = hdUploadFileName.Value;
        //        string strtempfolder = HRTRConfig.GetTempFolder;
        //        string strfile = MapPath(Path.Combine(strtempfolder, strfilename));
        //        HRTR.Server.CR_Course.Preview(strfile, this.UserProfileID);
        //        BindDataTemp();
        //        hdUploadFileName.Value = "";
        //    }
        //    catch (Exception ex)
        //    {
        //        ShowError(lblUpload, ex.Message);
        //    }
        //}
        //protected void btnUpload_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        lblUpload.Text = "";
        //        int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
        //        HRTR.Server.CR_Course.Import(iuserprofileid);

        //        grvCourseListTemp.Visible = false;
        //        btnUploadAsk.Visible = false;
        //        ShowMessage(lblUploadStatus, "Uploaded record(s) successfully.");
        //    }
        //    catch (Exception ex)
        //    {
        //        ShowError(lblUpload, ex.Message);
        //    }
        //}
        protected void btnCancel_Click(object sender, EventArgs e) {
            Close();
        }

        private void Close() {
            pnSearch.Visible = true;
            pnNew.Visible = true;
            //pnImport.Visible = false;
            pnCourse.Visible = true;
            grvCourseList.Visible = true;
            BindData();
        }

        #endregion Import
    }
}