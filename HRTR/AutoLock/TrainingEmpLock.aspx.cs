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
using System.Linq;
using System.Collections.Generic;

namespace HRTR.AutoLock
{
    public partial class TrainingEmpLock : HCM.BasePage.BasePage
    {
        #region General
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                Session["EmployeeListSort"] = "";
                BindData();
            }
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            btnNewTrainingEmpLock.Focus();
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
                string strdesfile = string.Format(@"{0}\TrainingEmpLock_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));
                string strdesfilefullpath = MapPath(strdesfile);
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, null, null, "Training Emp Lock");
                //eUtilities.CSVFile.Export(dt, strdesfilefullpath, ",", null, null, false, true);

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptTrainingEmpLock", strscript, false);

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
            string str_ssname = "EmployeeListSort";
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

        protected void grvTrainingEmpLock_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                int lockID = Convert.ToInt32(e.CommandArgument);
                try
                {
                    LoadLockRecord(lockID);
                    if (e.CommandName == "Select")
                    {
                        ResetControl(2);
                    }
                    else
                    {
                        ResetControl(3);
                    }
                    mpeTrainingEmpLock.Show();
                    txtEmployeeID.Focus();
                }
                catch (Exception ex)
                {
                    lblSearch.Text = ex.Message;
                }
            }
        }

        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["EmployeeListSort"] != null)
                {
                    pstr_sort = Session["EmployeeListSort"].ToString();
                }
            }
            DataTable dtLockRecord = SearchLockRecord();

            if (!string.IsNullOrEmpty(pstr_sort))
                dtLockRecord.DefaultView.Sort = pstr_sort;
            grvTrainingEmpLock.DataSource = dtLockRecord;
            grvTrainingEmpLock.DataBind();
        }

        private void LoadLockRecord(int lockID)
        {
            using (HRTR.Server.TrainingEmpLook tel = new HRTR.Server.TrainingEmpLook())
            {
                hdLockID.Value = lockID.ToString();
                tel.LockID = lockID;
                tel.Select();
                txtEmployeeID.Text = tel.EmployeeID;
                txtEmployeeIDSAP.Text = tel.EmployeeIDSAP;
                txtUserName.Text = tel.UserName;
                txtEmployeeName.Text = tel.EmployeeName;
                txtTrainingCodeID.Text = tel.TrainingCodeID;
                txtDescription.Text = tel.Description;
                txtDueDate.Text = tel.DueDate.ToString("MM/dd/yyyy");
                txtExtendDay.Text = tel.ExtendDay.ToString();
                if (tel.ExtendFromDate.Year > 1900)
                {
                    txtExtendFromDate.Text = tel.ExtendFromDate.ToString("MM/dd/yyyy");
                }
                else
                {
                    txtExtendFromDate.Text = "";
                }
                if (tel.CompleteDate.Year > 1900)
                {
                    txtCompleteDate.Text = tel.CompleteDate.ToString("MM/dd/yyyy");
                }
                else
                {
                    txtCompleteDate.Text = "";
                }
                cbIsActive.Checked = tel.IsActive;

            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.TrainingEmpLook tel = new HRTR.Server.TrainingEmpLook())
                {
                    tel.LockID = Convert.ToInt32(hdLockID.Value);
                    tel.EmployeeID = txtEmployeeID.Text.Trim();
                    tel.EmployeeIDSAP = txtEmployeeIDSAP.Text.Trim();
                    tel.UserName = txtUserName.Text.Trim();
                    tel.EmployeeName = txtEmployeeName.Text.Trim();
                    tel.TrainingCodeID = txtTrainingCodeID.Text.Trim();
                    tel.Description = txtDescription.Text.Trim();

                    DateTime dueDate = new DateTime(1900, 1, 1);
                    try
                    {
                        dueDate = DateTime.ParseExact(txtDueDate.Text, "MM/dd/yyyy", null);
                    }
                    catch
                    {
                        throw new Exception("Invalid Due Date.");
                    }
                    tel.DueDate = dueDate;

                    int extendDay = 0;
                    try
                    {
                        extendDay = Convert.ToInt32(txtExtendDay.Text.Trim());
                    }
                    catch
                    {
                        throw new Exception("Invalid Extend Day.");
                    }

                    tel.ExtendDay = extendDay;

                    DateTime extendFromDate = new DateTime(1900, 1, 1);
                    tel.ExtendFromDate = extendFromDate;
                    DateTime completeDate = new DateTime(1900, 1, 1);
                    tel.CompleteDate = completeDate;
                    tel.IsActive = cbIsActive.Checked;
                    tel.IsDL = 0;
                    tel.Save();
                }
                ResetControl(4);
                BindData();
                ShowMessage(lblSearch, "Saved record successfully.");
                //string strmess = "Save record successfully.";
                //lblMessage.Text = strmess;
                //btnMessage.Focus();
                //mpeMessage.Show();
            }
            catch (Exception ex)
            {
                //lblTrainingEmpLockMessage.Text = ex.Message;
                ShowError(lblTrainingEmpLockMessage, ex.Message);
                ResetControl(1);
                mpeTrainingEmpLock.Show();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.TrainingEmpLook tel = new HRTR.Server.TrainingEmpLook())
                {
                    tel.LockID = Convert.ToInt32(hdLockID.Value);
                    tel.Delete();
                }
                ResetControl(4);
                BindData();
                ShowMessage(lblSearch, "Deleted record successfully.");
                //string strmess = "Delete record successfully.";
                //lblMessage.Text = strmess;
                //btnMessage.Focus();
                //mpeMessage.Show();
            }
            catch (Exception ex)
            {
                //lblTrainingEmpLockMessage.Text = ex.Message;
                ShowError(lblTrainingEmpLockMessage, ex.Message);
                //ShowError(lblEmployeeMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeTrainingEmpLock.Show();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.TrainingEmpLook tel = new HRTR.Server.TrainingEmpLook())
                {
                    tel.LockID = Convert.ToInt32(hdLockID.Value);
                    tel.EmployeeID = txtEmployeeID.Text.Trim();
                    tel.EmployeeIDSAP = txtEmployeeIDSAP.Text.Trim();
                    tel.UserName = txtUserName.Text.Trim();
                    tel.EmployeeName = txtEmployeeName.Text.Trim();
                    tel.TrainingCodeID = txtTrainingCodeID.Text.Trim();
                    tel.Description = txtDescription.Text.Trim();

                    DateTime dueDate = new DateTime(1900, 1, 1);
                    try
                    {
                        dueDate = DateTime.ParseExact(txtDueDate.Text, "MM/dd/yyyy", null);
                    }
                    catch
                    {
                        throw new Exception("Invalid Due Date.");
                    }
                    tel.DueDate = dueDate;

                    int extendDay = 0;
                    try
                    {
                        extendDay = Convert.ToInt32(txtExtendDay.Text.Trim());
                    }
                    catch
                    {
                        throw new Exception("Invalid Extend Day.");
                    }
                    tel.ExtendDay = extendDay;

                    DateTime extendFromDate = new DateTime(1900, 1, 1);
                    if (!String.IsNullOrEmpty(txtExtendFromDate.Text))
                    {
                        try
                        {
                            extendFromDate = DateTime.ParseExact(txtExtendFromDate.Text, "MM/dd/yyyy", null);
                        }
                        catch
                        {
                            throw new Exception("Invalid Extend From Date.");
                        }
                        tel.ExtendFromDate = extendFromDate;
                    }

                    if (extendDay != 0 && txtExtendFromDate.Text != "")
                    {
                        if (dueDate.AddDays(3) >= DateTime.Today)
                        {
                            throw new Exception("DueDate + 3 still not reached. No need extend.");
                        }

                        if (extendFromDate < DateTime.Today)
                        {
                            throw new Exception("Extend From Date must >= today.");
                        }
                    }

                    DateTime completeDate = new DateTime(1900, 1, 1);
                    if (!String.IsNullOrEmpty(txtCompleteDate.Text))
                    {
                        try
                        {
                            completeDate = DateTime.ParseExact(txtCompleteDate.Text, "MM/dd/yyyy", null);
                        }
                        catch
                        {
                            throw new Exception("Invalid Complete Date.");
                        }
                        tel.CompleteDate = completeDate;
                    }

                    if (extendDay != 0 && txtExtendFromDate.Text != "" && txtCompleteDate.Text != "")
                    {
                        if (completeDate < extendFromDate)
                        {
                            throw new Exception("Complete Date must >= Extend From Date.");
                        }
                    }

                    if (extendDay == 0 && txtExtendFromDate.Text == "" && txtCompleteDate.Text != "")
                    {
                        if (completeDate > dueDate.AddDays(3))
                        {
                            throw new Exception("Complete Date must <= Due Date + 3.");
                        }
                    }

                    tel.IsActive = cbIsActive.Checked;
                    tel.IsDL = 0;
                    tel.Save();
                }
                ResetControl(4);
                BindData();
                ShowMessage(lblSearch, "Updated record successfully.");
                //string strmess = "Update record successfully.";
                //lblMessage.Text = strmess;
                //btnMessage.Focus();
                //mpeMessage.Show();

            }
            catch (Exception ex)
            {
                //lblTrainingEmpLockMessage.Text = ex.Message;
                ShowError(lblTrainingEmpLockMessage, ex.Message);
                ResetControl(2);
                mpeTrainingEmpLock.Show();
            }
        }

        protected void btnUpdateInactiveEmployeeCourses_Click(object sender, EventArgs e)
        {
            var currentLockId = 0;
            var currentWdNo = "";
            var currentTrainingCode = "";
            var defaultDate = new DateTime(1900, 1, 1);
            try
            {
                var inactiveEmployeeTable = eDBEmployees.SearchInactiveEmployees();
                var inactiveEmployeeRows = inactiveEmployeeTable.Rows.Cast<DataRow>();
                var inactiveEmployees = inactiveEmployeeRows
                    .SelectMany(x => new string[]
                    {
                        Convert.ToString(x["WD No"]),
                        Convert.ToString(x["Employee ID SAP"]),
                        Convert.ToString(x["User Name"])
                    })
                    .Where(x => !string.IsNullOrWhiteSpace(x))
                    .Distinct()
                    .GroupBy(x => x, StringComparer.OrdinalIgnoreCase)
                    .SelectMany(x => x);

                var tranningEmployeeTable = TrainingEmpLook.Search("", "", "", "", "", defaultDate, 0, defaultDate, -1, 0, "");
                var tranningEmployeeRows = tranningEmployeeTable.Rows.Cast<DataRow>();
                var tranningEmployees = tranningEmployeeRows
                    .Select(x => new
                    {
                        WDNo = Convert.ToString(x["WDNo"]),
                        SAP = Convert.ToString(x["EmployeeIDSAP"]),
                        UserName = Convert.ToString(x["UserName"]),
                        Row = x
                    });

                var dictionary = inactiveEmployees.ToDictionary(x => x, x => new HashSet<DataRow>(), StringComparer.OrdinalIgnoreCase);
                foreach (var item in tranningEmployees)
                {
                    var rows = new HashSet<DataRow>();
                    var rowsByUserName = new HashSet<DataRow>();
                    var rowsBySAP = new HashSet<DataRow>();
                    var rowsByWD = new HashSet<DataRow>();

                    dictionary.TryGetValue(item.UserName, out rowsByUserName);
                    dictionary.TryGetValue(item.SAP, out rowsBySAP);
                    dictionary.TryGetValue(item.WDNo, out rowsByWD);

                    rowsByUserName?.Add(item.Row);
                    rowsBySAP?.Add(item.Row);
                    rowsByWD?.Add(item.Row);
                }
                var list = dictionary.SelectMany(x => x.Value).Distinct();

                var table = tranningEmployeeTable.Copy();
                table.Rows.Clear();
                foreach (var item in list)
                {
                    table.Rows.Add(item.ItemArray);
                }

                if (table.Rows.Count > 0)
                {
                    TrainingEmpLook.HideTrainingEmployee(table);
                    BindData();
                }
            }
            catch (Exception ex)
            {
                var format = "[LockID]={0}, [WD]={1}, [Training Code]={2}\n[Error]={3}.";
                var args = new object[] { currentLockId, currentWdNo, currentTrainingCode, ex.Message };
                var message = string.Format(format, args);
                ShowError(lblSearch, message);
            }
            finally
            {
            }
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
            if (txtExtendDay.Text.Trim().Length > 0)
            {
                try
                {
                    extendDay = Convert.ToInt32(txtExtendDay.Text.Trim());
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
            string strwdno = txtWDNoS.Text.Trim();

            return HRTR.Server.TrainingEmpLook.Search(employeeId, employeeIdsap, userName,
                                                employeeName, codeId, dueDate, extendDay, completeDate, isActive, 0, strwdno);

        }
        #endregion

        #region Tab Control
        private void ResetControl(int flag)
        {
            // For add new
            if (flag == 1)
            {
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                lblExtendDay.CssClass = "invisible";
                txtExtendDay.CssClass = "invisible";
                lblExtendFromDate.CssClass = "invisible";
                txtExtendFromDate.CssClass = "invisible";
                imgExtendFromDate.Visible = false;
                lblCompleteDate.CssClass = "invisible";
                txtCompleteDate.CssClass = "invisible";
                imgCompleteDate.Visible = false;
                if (String.IsNullOrEmpty(txtDueDate.Text))
                {
                    caDueDate.SelectedDate = null;
                }
                if (String.IsNullOrEmpty(txtCompleteDate.Text))
                {
                    caCompleteDate.SelectedDate = null;
                }
            }
            // For update
            else if (flag == 2)
            {
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                lblExtendDay.CssClass = "visible";
                txtExtendDay.CssClass = "visible";
                lblExtendFromDate.CssClass = "visible";
                txtExtendFromDate.CssClass = "visible";
                imgExtendFromDate.Visible = true;
                lblCompleteDate.CssClass = "visible";
                txtCompleteDate.CssClass = "visible";
                imgCompleteDate.Visible = true;
                if (String.IsNullOrEmpty(txtDueDate.Text))
                {
                    caDueDate.SelectedDate = null;
                }
                if (String.IsNullOrEmpty(txtCompleteDate.Text))
                {
                    caCompleteDate.SelectedDate = null;
                }
            }
            // For delete
            else if (flag == 3)
            {
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                lblExtendDay.CssClass = "visible";
                txtExtendDay.CssClass = "visible";
                lblExtendFromDate.CssClass = "visible";
                txtExtendFromDate.CssClass = "visible";
                imgExtendFromDate.Visible = true;
                lblCompleteDate.CssClass = "visible";
                txtCompleteDate.CssClass = "visible";
                imgCompleteDate.Visible = true;
                if (String.IsNullOrEmpty(txtDueDate.Text))
                {
                    caDueDate.SelectedDate = null;
                }
                if (String.IsNullOrEmpty(txtCompleteDate.Text))
                {
                    caCompleteDate.SelectedDate = null;
                }
            }
            else if (flag == 4)
            {
                txtEmployeeID.Text = string.Empty;
                txtEmployeeIDSAP.Text = string.Empty;
                txtUserName.Text = string.Empty;
                txtEmployeeName.Text = string.Empty;
                txtTrainingCodeID.Text = string.Empty;
                txtDescription.Text = string.Empty;
                txtDueDate.Text = string.Empty;
                txtExtendDay.Text = string.Empty;
                txtExtendFromDate.Text = string.Empty;
                txtCompleteDate.Text = string.Empty;
                cbIsActive.Checked = true;
            }
        }

        protected void mvTrainingEmpLock_Command(object sender, CommandEventArgs e)
        {
            SetMultiviewActive((string)e.CommandName);
        }

        private void SetMultiviewActive(string strviewid)
        {
            switch (strviewid)
            {
                case "Search":
                    mvTrainingEmpLock.SetActiveView(vSearchTrainingEmpLock);
                    lbSearch.CssClass = "multiviewtabactive";
                    lbImport.CssClass = "multiviewtabinactive";

                    break;
                case "Import":
                    mvTrainingEmpLock.SetActiveView(vUploadTrainingEmpLock);
                    lbSearch.CssClass = "multiviewtabinactive";
                    lbImport.CssClass = "multiviewtabactive";
                    break;

            }
        }
        #endregion

        #region Import
        protected void grvTrainingEmpLockTemp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvTrainingEmpLockTemp.PageIndex = e.NewPageIndex;
            BindDataTemp();
        }

        protected void grvTrainingEmpLockTemp_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "EmployeeTempListSort";
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
            BindDataTemp(str_sort);
        }

        private void BindDataTemp(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["EmployeeTempListSort"] != null)
                {
                    pstr_sort = Session["EmployeeTempListSort"].ToString();
                }
            }
            int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
            DataTable dt = HRTR.Server.TrainingEmpLook.SearchTemp(iuserprofileid);
            if (!string.IsNullOrEmpty(pstr_sort))
                dt.DefaultView.Sort = pstr_sort;
            grvTrainingEmpLockTemp.DataSource = dt;
            grvTrainingEmpLockTemp.DataBind();
            grvTrainingEmpLockTemp.Visible = true;

            int itotal = dt.Rows.Count;
            DataView dvEmployeeTemp = dt.DefaultView;
            dvEmployeeTemp.RowFilter = "[IsValid] = True";
            int ivalid = dvEmployeeTemp.Count;
            int iinvalid = itotal - ivalid;
            btnUploadAsk.Visible = true;
            if (ivalid > 0)
                btnUploadAsk.Enabled = true;
            else
                btnUploadAsk.Enabled = false;

            lblUpload.Text = string.Format("Total: {0} record(s), Valid: {1} record(s), Invalid: {2} record(s).", itotal, ivalid, iinvalid);
            //int iparttemptoal = dt.Rows.Count;
            //if (iparttemptoal > 0)
            //    pnUploadInfo.Visible = true;
            //else
            //    pnUploadInfo.Visible = false;
            //lblTrainingEmpLockTempCount.Text = iparttemptoal.ToString() + " record(s)";

            //DataView dvEmployeeTemp = dt.DefaultView;

            //dvEmployeeTemp.RowFilter = "IsValid = True";
            //int iparttempvalid = dvEmployeeTemp.Count;
            //lblTrainingEmpLockTempValidCount.Text = iparttempvalid.ToString() + " record(s)";

            //if (iparttempvalid > 0)
            //    btnUploadAsk.Visible = true;
            //else
            //    btnUploadAsk.Visible = false;

            //int iparttempinvalid = iparttemptoal - iparttempvalid;
            //lblTrainingEmpLockTempInValidCount.Text = iparttempinvalid.ToString() + " record(s)";
        }

        protected void AsyncFUTrainingEmpLock_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            string strext = Path.GetExtension(AsyncFUTrainingEmpLock.FileName);
            if (strext == ".xls" || strext == ".xlsx")
            {

                string strfilename = AsyncFUTrainingEmpLock.FileName;
                string strtempfolder = HRTRConfig.GetTempFolder;
                string savePath = MapPath(Path.Combine(strtempfolder, strfilename));
                AsyncFUTrainingEmpLock.SaveAs(savePath);
            }
            else
            {

                AsyncFUTrainingEmpLock.ErrorBackColor = System.Drawing.Color.Red;
            }
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            try
            {
                string strfilename = hdUploadFileName.Value;
                string strtempfolder = HRTRConfig.GetTempFolder;
                string strfile = MapPath(Path.Combine(strtempfolder, strfilename));
                //int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
                HRTR.Server.TrainingEmpLook.PreviewTrainingEmpLock(strfile, this.UserProfileID);
                BindDataTemp();
                hdUploadFileName.Value = "";
            }
            catch (Exception ex)
            {
                ShowError(lblUpload, ex.Message);
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string strmess = string.Empty;
            try
            {
                //int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
                HRTR.Server.TrainingEmpLook.Import(this.UserProfileID);

                BindData();

                grvTrainingEmpLockTemp.Visible = false;
                //pnUploadInfo.Visible = false;
                btnUploadAsk.Visible = false;

                ShowMessage(lblUpload, "Uploaded record(s) successfully.");

            }
            catch (Exception ex)
            {
                ShowError(lblUpload, ex.Message);
            }
            //lblMessage.Text = strmess;
            //btnMessage.Focus();
            //mpeMessage.Show();
        }
        #endregion
    }
}