using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using HRTR.Server;

using SystemAuth;

namespace HRTR.TR
{

    public partial class TrainingRecordBE : HCM.BasePage.BasePage
    {
        protected bool IsAdmin
        {
            get
            {
                try
                {
                    string strvalue = hdAdminPermission.Value.ToUpper();
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
                DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);
                //TrainingGroup
                ddlTrainingGroup.DataSource = dtTrainingGroup;
                ddlTrainingGroup.DataBind();
                ddlTrainingGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));

                BindCourseGroup();

                BindCourse();

                BindProduct();

                //DataTable dtCertifiedLevel = CR_CertifiedLevel.Search();
                //ddlCertifiedLevel.DataSource = dtCertifiedLevel;
                //ddlCertifiedLevel.DataBind();
                //ddlCertifiedLevel.Items.Insert(0, new ListItem("[Please Select]", "0"));

                Session["TrainingRecordSort"] = "";
            }
            else { }
            using (SC_UserProfile us = new SC_UserProfile())
            {
                us.UserProfileID = this.UserProfileID;
                us.Select();
                //10: Admin
                if (us.CheckPermissionRole((int)EPermissionRole.Admin))
                {
                    hdAdminPermission.Value = "1";
                }
            }
            Page.Form.Attributes.Add("enctype", "multipart/form-data");

        }

        #endregion Page Events

        #region Search

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Session["TrainingRecordSort"] = "";
            BindTrainingRecord();
            pnSearch.Visible = true;
            pnTrainingRecord.Visible = true;
            pnEdit.Visible = false;
            //pnImport.Visible = false;
        }

        #endregion Search

        #region Training Record

        protected void btnNew_Click(object sender, EventArgs e)
        {
            SettingsForNew();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void Close()
        {
            pnSearch.Visible = true;
            //pnTrainingRecord.Visible = true;
            pnEdit.Visible = false;
            pnImport.Visible = false;
        }

        protected void grvTrainingRecord_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvTrainingRecord.PageIndex = e.NewPageIndex;
            BindTrainingRecord();
        }

        protected void grvTrainingRecord_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }

        protected void grvTrainingRecord_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "TrainingRecordSort";
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
            catch { }
            Session[str_ssname] = str_sort;
            BindTrainingRecord(str_sort);
        }

        protected void grvTrainingRecord_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                hdTrainingRecordID.Value = e.CommandArgument.ToString();
                using (TrainingRecord imr = new TrainingRecord())
                {
                    imr.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
                    imr.Select();
                    LoadTrainingRecord(imr);
                }
                ///Search
                //pnSearch.Visible = false;
                //Edit
                pnEdit.Visible = true;
            }
        }

        private void LoadTrainingRecord(TrainingRecord pimr)
        {
            hdEmployeeID_ID.Value = pimr.EmployeeID_ID.ToString();
            ///Employee Info
            using (HR_Employee em = new HR_Employee())
            {
                em.EmployeeID_ID = pimr.EmployeeID_ID;
                em.Select();
                txtEmployeeIDE.Text = em.EmployeeID;
                txtEmployeeNameE.Text = em.EmployeeName;
            }
            try
            {
                ddlTrainingGroup.SelectedValue = pimr.TrainingGroupID.ToString();
            }
            catch { }
            BindCourseGroup();
            try
            {
                ddlCourseGroup.SelectedValue = pimr.CourseGroupID.ToString();
            }
            catch { }
            BindCourse();
            try
            {
                ddlCourse.SelectedValue = pimr.CourseID.ToString();
            }
            catch { }
            BindProduct();
            try
            {
                ddlProduct.SelectedValue = pimr.ProductID.ToString();
            }
            catch { }
            txtCertDate.Text = pimr.CertDate.ToString("MM/dd/yyyy");
            if (pimr.ExpDate.Year > 2000)
                txtExpDate.Text = pimr.ExpDate.ToString("MM/dd/yyyy");
            else
                txtExpDate.Text = "";
            txtScore.Text = pimr.Score.ToString();
            //ddlCertifiedLevel.SelectedValue = pimr.CertifiedLevelID.ToString();
            txtTrainer.Text = pimr.Trainer;
            cbOJT.Checked = pimr.OJT;
            cbIsActive_TR.Checked = pimr.IsActive;
            txtComments.Text = pimr.Comments;
            btnSave.Text = "Update";
            using (SC_UserProfile us = new SC_UserProfile())
            {
                us.UserProfileID = this.UserProfileID;
                us.Select();
                //10: Admin
                if (us.CheckPermissionRole((int)SystemAuth.EPermissionRole.Admin))
                {
                    btnDelete.Visible = true;
                }
                else
                {
                    btnDelete.Visible = false;
                }
            }
            ddlTrainingGroup.Enabled = false;
            ddlCourseGroup.Enabled = false;
            ddlCourse.Enabled = false;
            ddlProduct.Enabled = false;
        }

        private void BindTrainingRecord(string pstr_sort = "")
        {
            try
            {
                if (string.IsNullOrEmpty(pstr_sort))
                {
                    if (Session["TrainingRecordSort"] != null)
                    {
                        pstr_sort = Session["TrainingRecordSort"].ToString();
                    }
                }
                int iisactive = cbIsActive_Course.Checked ? 1 : 0;
                string strTrainingGroup = txtTrainingGroupName.Text.Trim();
                string strCourseGroup = txtCourseGroupName.Text.Trim();
                string strCourse = txtCourseName.Text.Trim();
                DataTable dt;
                using (HR_Employee emp = new HR_Employee())
                {
                    emp.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
                    dt = emp.TrainingRecordByEmployeeID_ID(strTrainingGroup, strCourseGroup, strCourse, iisactive);
                }
                if (!string.IsNullOrEmpty(pstr_sort))
                    dt.DefaultView.Sort = pstr_sort;
                grvTrainingRecord.DataSource = dt;
                grvTrainingRecord.DataBind();
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }

        #endregion Training Record

        #region Apply

        protected void cfmbApply_ClickOk(object sender, EventArgs e)
        {
            string strtemp = string.Empty;
            string strapplykindid = hdApplyKindID.Value;
            if (strapplykindid == "1")///Import Quote Details
            {
                if (Apply(out strtemp))
                {
                    ShowMessage(lblSave, strtemp);
                }
                else
                {
                    ShowError(lblSave, strtemp);
                }
            }
            else if (strapplykindid == "2")
            {
                if (Delete(out strtemp))
                {
                    ShowMessage(lblSave, strtemp);
                }
                else
                {
                    ShowError(lblSave, strtemp);
                }
            }
        }

        private bool Apply(out string pstrresult)
        {
            pstrresult = string.Empty;
            try
            {
                using (TrainingRecord trc = new TrainingRecord())
                {
                    trc.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
                    trc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
                    trc.ProductID = Convert.ToInt32(ddlProduct.SelectedValue);
                    trc.CourseID = Convert.ToInt32(ddlCourse.SelectedValue);

                    DateTime daCertDate = new DateTime(1900, 1, 1);
                    try
                    {
                        daCertDate = DateTime.ParseExact(txtCertDate.Text, "MM/dd/yyyy", null);
                    }
                    catch
                    {
                        throw new Exception("Invalid Certificate Date.");
                    }
                    trc.OJT = cbOJT.Checked;
                    trc.IsActive = cbIsActive_TR.Checked;
                    trc.Comments = txtComments.Text.Trim();
                    trc.CertDate = daCertDate;
                    trc.Score = Convert.ToDecimal(txtScore.Text);
                    DateTime daExpDate = new DateTime(1900, 1, 1);
                    try
                    {
                        daExpDate = DateTime.ParseExact(txtExpDate.Text, "MM/dd/yyyy", null);
                    }
                    catch { }
                    trc.ExpDate = daExpDate;
                    //trc.CertifiedLevelID = Convert.ToInt32(ddlCertifiedLevel.SelectedValue);
                    trc.Trainer = txtTrainer.Text;
                    trc.Save();
                }
                BindTrainingRecord();
                SettingsForNew();
                pstrresult = "Saved successfully.";
                return true;
            }
            catch (Exception ex)
            {
                pstrresult = ex.Message;
                return false;
            }
            finally { }
        }

        private bool Delete(out string pstrresult)
        {
            pstrresult = string.Empty;
            try
            {
                using (TrainingRecord trc = new TrainingRecord())
                {
                    trc.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
                    trc.Delete();
                }
                BindTrainingRecord();
                SettingsForNew();
                pstrresult = "Deleted successfully.";
                return true;
            }
            catch (Exception ex)
            {
                pstrresult = ex.Message;
                return false;
            }
            finally { }
        }

        //protected void btnSave_Click(object sender, EventArgs e)
        //{
        //    if (hdTrainingRecordID.Value == "0")
        //    {
        //        lblSave.Text = "";
        //        try
        //        {
        //            using (TrainingRecord trc = new TrainingRecord())
        //            {
        //                trc.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
        //                trc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
        //                trc.ProductID = Convert.ToInt32(ddlProduct.SelectedValue);
        //                trc.CourseID = Convert.ToInt32(ddlCourse.SelectedValue);

        //                DateTime daCertDate = new DateTime(1900, 1, 1);
        //                try
        //                {
        //                    daCertDate = DateTime.ParseExact(txtCertDate.Text, "MM/dd/yyyy", null);
        //                }
        //                catch
        //                {
        //                    throw new Exception("Invalid Certificate Date.");
        //                }
        //                trc.OJT = cbOJT.Checked;
        //                trc.CertDate = daCertDate;
        //                trc.Score = Convert.ToDecimal(txtScore.Text);
        //                DateTime daExpDate = new DateTime(1900, 1, 1);
        //                try
        //                {
        //                    daExpDate = DateTime.ParseExact(txtExpDate.Text, "MM/dd/yyyy", null);
        //                }
        //                catch { }
        //                trc.ExpDate = daExpDate;
        //                trc.CertifiedLevelID = Convert.ToInt32(ddlCertifiedLevel.SelectedValue);
        //                trc.Trainer = txtTrainer.Text;
        //                trc.Save();
        //            }
        //            BindTrainingRecord();
        //            SettingsForNew();
        //            //lblSave.Text = "Saved successfully.";
        //            ShowMessage(lblSave, "Saved successfully.");
        //            //ShowMessage(lblSave, "");
        //        }
        //        catch (Exception ex)
        //        {
        //            //lblSave.Text = ex.Message;
        //            ShowError(lblSave, ex.Message);
        //        }
        //    }
        //    else
        //    {
        //        lblCaptionC.Text = "Update Training Course Confirmation";
        //        lblConfirmationTitle.Text = "Are you sure you want to update this training course?";
        //        hdAction.Value = "Update";
        //        mpeConfirmUpdate.Show();
        //    }
        //}
        //protected void btnDelete_Click(object sender, EventArgs e)
        //{
        //    lblCaptionC.Text = "Delete Training Course Confirmation";
        //    lblConfirmationTitle.Text = "Are you sure you want to detele this training course?";
        //    hdAction.Value = "Delete";
        //    mpeConfirmUpdate.Show();
        //    //lblSave.Text = "";
        //    //try
        //    //{
        //    //    using (TrainingRecord trc = new TrainingRecord())
        //    //    {
        //    //        trc.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
        //    //        trc.Delete();
        //    //    }
        //    //    BindTrainingRecord();
        //    //    SettingsForNew();
        //    //    //lblSave.Text = "Deleted successfully.";
        //    //    ShowMessage(lblSave, "Deleted successfully.");
        //    //}
        //    //catch (Exception ex)
        //    //{
        //    //    //lblSave.Text = ex.Message;
        //    //    ShowError(lblSave, ex.Message);
        //    //}
        //}
        //protected void btnUpdate_Click(object sender, EventArgs e)
        //{
        //    lblSave.Text = "";
        //    if (hdAction.Value == "Update")
        //    {
        //        try
        //        {
        //            using (TrainingRecord trc = new TrainingRecord())
        //            {
        //                trc.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
        //                trc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
        //                trc.ProductID = Convert.ToInt32(ddlProduct.SelectedValue);
        //                trc.CourseID = Convert.ToInt32(ddlCourse.SelectedValue);

        //                DateTime daCertDate = new DateTime(1900, 1, 1);
        //                try
        //                {
        //                    daCertDate = DateTime.ParseExact(txtCertDate.Text, "MM/dd/yyyy", null);
        //                }
        //                catch
        //                {
        //                    throw new Exception("Invalid Certificate Date.");
        //                }
        //                trc.OJT = cbOJT.Checked;
        //                trc.CertDate = daCertDate;
        //                trc.Score = Convert.ToDecimal(txtScore.Text);
        //                DateTime daExpDate = new DateTime(1900, 1, 1);
        //                try
        //                {
        //                    daExpDate = DateTime.ParseExact(txtExpDate.Text, "MM/dd/yyyy", null);
        //                }
        //                catch { }
        //                trc.ExpDate = daExpDate;
        //                trc.CertifiedLevelID = Convert.ToInt32(ddlCertifiedLevel.SelectedValue);
        //                trc.Trainer = txtTrainer.Text;
        //                trc.Save();
        //            }
        //            BindTrainingRecord();
        //            SettingsForNew();
        //            ShowMessage(lblSave, "Updated successfully.");
        //        }
        //        catch (Exception ex)
        //        {
        //            ShowError(lblSave, ex.Message);
        //        }
        //    }
        //    else
        //    {
        //        try
        //        {
        //            using (TrainingRecord trc = new TrainingRecord())
        //            {
        //                trc.TrainingRecordID = Convert.ToInt32(hdTrainingRecordID.Value);
        //                trc.Delete();
        //            }
        //            BindTrainingRecord();
        //            SettingsForNew();
        //            ShowMessage(lblSave, "Deleted successfully.");
        //        }
        //        catch (Exception ex)
        //        {
        //            ShowError(lblSave, ex.Message);
        //        }
        //    }
        //    hdAction.Value = "";
        //}

        #endregion Apply

        #region Control Events

        protected void ddlTrainingGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCourseGroup();
            BindCourse();
            BindProduct();
        }

        protected void ddlCourseGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCourse();
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get selected Course from UI
            var selectedCourse = int.TryParse(ddlCourse.SelectedValue, out int courseId)
                ? courseId
                : 0;

            if (selectedCourse == 0)
            {
                return;
            }

            // Get Course
            var course = new CR_Course { CourseID = courseId };
            course.Select();
            hdIsCertifiedPerFamily.Value = course.IsCertifiedPerFamily.ToString();

            // Reset Family selected value
            if (hdIsCertifiedPerFamily.Value == "False")
            {
                ddlProduct.Items.Clear();
                ddlProduct.Items.Insert(0, new ListItem(Convert.ToInt32(ddlCourseGroup.SelectedItem.Value).Equals(1) ? "N/A" : "All", "1"));
                ddlProduct.SelectedIndex = 0;
                ddlProduct.Enabled = false;
            }
            else
            {
                ddlProduct.Enabled = true;
                ddlProduct.ClearSelection();
                BindProduct();
            }

        }

        private void BindCourseGroup()
        {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
            ddlCourseGroup.Items.Clear();
            DataTable dtCourseGroup = HRTR.Server.CR_CourseGroup.SearchByTrainingGroupID(itraininggroupid, 1);

            ddlCourseGroup.DataSource = dtCourseGroup;
            ddlCourseGroup.DataBind();
            ddlCourseGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));
        }

        private void BindCourse()
        {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
            int icoursegroupid = Convert.ToInt32(ddlCourseGroup.SelectedValue);
            ddlCourse.Items.Clear();
            DataTable dt = HRTR.Server.CR_Course.Search(
                string.Empty,
                icoursegroupid,
                itraininggroupid,
                -1,
                -1,
                -1,
                -1,
                "",
                1
            );

            ddlCourse.DataSource = dt;
            ddlCourse.DataBind();
            ddlCourse.Items.Insert(0, new ListItem("[Please Select]", "0"));
        }

        private void BindProduct()
        {
            var trainingGroupId = Convert.ToInt32(ddlTrainingGroup.SelectedValue);

            ddlProduct.Items.Clear();
            ddlProduct.DataSource = CR_Product.Search(string.Empty, trainingGroupId);
            ddlProduct.DataBind();
            //ddlProduct.Items.Insert(0, new ListItem("[Please Select]", "0"));
            //ddlProduct.SelectedValue = "0";
            ddlProduct.Items.Insert(0, new ListItem(Convert.ToInt32(ddlCourseGroup.SelectedItem.Value).Equals(1) ? "N/A" : "All", "1"));
            ddlProduct.SelectedValue = "1";
        }

        #endregion Control Events

        #region Import

        protected void btnImport_Click(object sender, EventArgs e)
        {
            pnSearch.Visible = false;
            pnTrainingRecord.Visible = false;
            pnEdit.Visible = false;
            pnImport.Visible = true;
            grvTrainingRecordTemp.Visible = false;
            btnUploadAsk.Visible = false;
            lblUpload.Text = "";
        }

        protected void grvTrainingRecordTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvTrainingRecordTemp.PageIndex = e.NewPageIndex;
            BindDataTemp();


        }

        protected void grvTrainingRecordTemp_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "TrainingRecordTempListSort";
            string strSort = e.SortExpression.ToString();
            string str_sort = "" + strSort + " ASC";
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
            catch { }
            Session[str_ssname] = str_sort;
            BindDataTemp(str_sort);
        }

        private void BindDataTemp(string pSort = "")
        {
            // Get and sort data from Training Record Template
            if (string.IsNullOrEmpty(pSort) && Session["TrainingRecordTempListSort"] != null)
            {
                pSort = Session["TrainingRecordTempListSort"].ToString();
            }
            DataTable dt = HRTR.Server.TrainingRecord.SearchTemp(this.UserProfileID);
            if (!string.IsNullOrEmpty(pSort))
                dt.DefaultView.Sort = pSort;

            // Bind sorted data to grid view
            grvTrainingRecordTemp.DataSource = dt;
            grvTrainingRecordTemp.DataBind();
            grvTrainingRecordTemp.Visible = true;

            //for (int i = 1; i < grvTrainingRecordTemp.Rows.Count; i++)
            //{
            //    string message = grvTrainingRecordTemp.Rows[i].Cells[15].Text;
            //   if (message.Equals("Please select a specific family. ") || message.Equals("Please select value is All with family. "))
            //    {
            //        grvTrainingRecordTemp.Rows[i].BackColor = System.Drawing.Color.Yellow;
            //    }
            //}

            // Show upload button and record summary
            int totalRowCount = dt.Rows.Count;

            DataView dvEmployeeTemp = dt.DefaultView;
            dvEmployeeTemp.RowFilter = "[IsValid] = True";
            int validRowCount = dvEmployeeTemp.Count;
            int invalidRowCount = totalRowCount - validRowCount;

            btnUploadAsk.Visible = true;
            btnUploadAsk.Enabled = validRowCount > 0;

            lblUpload.Text = $"Total: {totalRowCount} record(s), Valid: {validRowCount} record(s), Invalid: {invalidRowCount} record(s).";


        }

        // Save file to Template folder
        protected void AsyncFUTrainingRecord_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            string extension = Path.GetExtension(AsyncFUTrainingRecord.FileName);
            if (extension == ".xls" || extension == ".xlsx")
            {
                var fileName = AsyncFUTrainingRecord.FileName;
                var tempFolder = HRTRConfig.GetTempFolder;
                var savePath = MapPath(Path.Combine(tempFolder, fileName));
                AsyncFUTrainingRecord.SaveAs(savePath);
            }
            else
            {
                AsyncFUTrainingRecord.ErrorBackColor = System.Drawing.Color.Red;
            }
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            try
            {
                lblUpload.Text = "";

                string fileName = hdUploadFileName.Value;
                string tempFolder = HRTRConfig.GetTempFolder;
                string filePath = MapPath(Path.Combine(tempFolder, fileName));
                HRTR.Server.TrainingRecord.Preview(filePath, this.UserProfileID);
                BindDataTemp();
                hdUploadFileName.Value = "";
            }
            catch (Exception ex)
            {
                //lblUpload.Text = ex.Message;
                ShowError(lblUpload, ex.Message);
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                lblUpload.Text = "";
                int userProfileId = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
                HRTR.Server.TrainingRecord.Import(userProfileId);

                grvTrainingRecordTemp.Visible = false;
                btnUploadAsk.Visible = false;

                //lblUploadStatus.Text = "Uploaded record(s) successfully.";
                ShowMessage(lblUploadStatus, "Uploaded record(s) successfully.");
            }
            catch (Exception ex)
            {
                //lblUpload.Text = ex.Message;
                ShowError(lblUpload, ex.Message);
            }
        }

        #endregion Import

        #region Private Methods

        /// <summary>
        /// go to add new
        /// </summary>
        private void SettingsForNew()
        {
            //pnSearch.Visible = true;
            //pnTrainingRecord.Visible = true;
            pnEdit.Visible = true;
            //pnImport.Visible = false;

            lblSave.Text = "";
            //hdEmployeeID_ID.Value = "0";
            txtEmployeeIDE.Text = txtEmployeeID.Text;
            txtEmployeeNameE.Text = txtEmployeeName.Text;

            hdTrainingRecordID.Value = "0";
            ddlTrainingGroup.SelectedValue = "0";
            ddlCourseGroup.SelectedValue = "0";
            BindCourse();
            ddlCourse.SelectedValue = "0";
            BindProduct();
            ddlProduct.SelectedValue = "1";
            txtCertDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            txtExpDate.Text = "";
            txtScore.Text = "0";
            //ddlCertifiedLevel.SelectedValue = "0";
            txtTrainer.Text = "";
            cbOJT.Checked = !cbOJT.Enabled;
            cbIsActive_TR.Checked = true;
            txtComments.Text = "";

            btnSave.Text = "Add";
            btnDelete.Visible = false;
            ddlTrainingGroup.Enabled = true;
            ddlCourseGroup.Enabled = true;
            ddlCourse.Enabled = true;
            ddlProduct.Enabled = true;
            ddlTrainingGroup.Focus();
        }

        #endregion Private Methods

    }
}