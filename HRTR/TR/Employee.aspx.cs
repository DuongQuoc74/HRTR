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
    public partial class Employee : HCM.BasePage.BasePage
    {
        #region General
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                DataTable dtOperatorGroup = CR_OperatorGroup.Search();
                //OperatorGroup
                ddlOperatorGroupS.DataSource = dtOperatorGroup;
                ddlOperatorGroupS.DataBind();
                ddlOperatorGroupS.Items.Insert(0, new ListItem("[All]", "0"));

                //OperatorGroup

                ddlOperatorGroup.DataSource = dtOperatorGroup;
                ddlOperatorGroup.DataBind();
                ddlOperatorGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));


                DataTable dtDepartment = SY_Department.Search();
                //Department
                ddlDepartmentS.DataSource = dtDepartment;
                ddlDepartmentS.DataBind();
                ddlDepartmentS.Items.Insert(0, new ListItem("[All]", "0"));

                //Department

                ddlDepartment.DataSource = dtDepartment;
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, new ListItem("[Please Select]", "0"));


                DataTable dtWorkingStatus = CR_WorkingStatus.Search();
                //WorkingStatus
                ddlWorkingStatusS.DataSource = dtWorkingStatus;
                ddlWorkingStatusS.DataBind();
                ddlWorkingStatusS.Items.Insert(0, new ListItem("[All]", "0"));

                //WorkingStatus

                ddlWorkingStatus.DataSource = dtWorkingStatus;
                ddlWorkingStatus.DataBind();
                ddlWorkingStatus.Items.Insert(0, new ListItem("[Please Select]", "0"));


                DataTable dtPosition = CR_Position.Search();
                //Position
                ddlPositionS.DataSource = dtPosition;
                ddlPositionS.DataBind();
                ddlPositionS.Items.Insert(0, new ListItem("[All]", "0"));

                //Position

                ddlPosition.DataSource = dtPosition;
                ddlPosition.DataBind();
                ddlPosition.Items.Insert(0, new ListItem("[Please Select]", "0"));


                DataTable dtCompany = CR_Company.Search();
                //Company
                ddlCompanyS.DataSource = dtCompany;
                ddlCompanyS.DataBind();
                ddlCompanyS.Items.Insert(0, new ListItem("[All]", "0"));
                try
                {
                    ddlCompanyS.SelectedValue = "1";
                }
                catch { }
                //Company

                ddlCompany.DataSource = dtCompany;
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("[Please Select]", "0"));

    
                DataTable dtWorkcell = CR_Workcell.Search();
                //Workcell
                ddlWorkcellS.DataSource = dtWorkcell;
                ddlWorkcellS.DataBind();
                ddlWorkcellS.Items.Insert(0, new ListItem("[All]", "0"));

                //Workcell

                ddlWorkcell.DataSource = dtWorkcell;
                ddlWorkcell.DataBind();
                ddlWorkcell.Items.Insert(0, new ListItem("[Please Select]", "0"));


                grvEmployeeList.AutoGenerateColumns = false;
                Session["EmployeeListSort"] = "";
                BindData();
            }
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            btnNewEmployee.Focus();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void grvEmployeeList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvEmployeeList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvEmployeeList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvEmployeeList_Sorting(object sender, GridViewSortEventArgs e)
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
        protected void grvEmployeeList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int iemployeeid_id = Convert.ToInt32(e.CommandArgument);
                    LoadEmployee(iemployeeid_id);
                }
                catch (Exception ex)
                {
                    ShowError(lblEmployee, ex.Message);
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
                mpeEmployee.Show();
            }
        }
        private void LoadEmployee(int pi_employeeid_id)
        {
            using (HR_Employee us = new HR_Employee())
            {
                hdEmployeeID_ID.Value = pi_employeeid_id.ToString();
                us.EmployeeID_ID = pi_employeeid_id;
                us.Select();
                txtEmployeeID.Text = us.EmployeeID;
                txtEmployeeIDSAP.Text = us.EmployeeIDSAP;
                txtUserName.Text = us.UserName;
                txtEmployeeName.Text = us.EmployeeName;
                ddlOperatorGroup.SelectedValue = us.OperatorGroupID.ToString();
                ddlCompany.SelectedValue = us.CompanyID.ToString();
                ddlDepartment.SelectedValue = us.DepartmentID.ToString();
                txtJobTitle.Text = us.JobTitle;
                ddlPosition.SelectedValue = us.PositionID.ToString();
                ddlWorkcell.SelectedValue = us.WorkcellID.ToString();
                txtSupervisor.Text = us.Supervisor;
                cbIsActive.Checked = us.IsActive;
                cbIsSupervisor.Checked = us.IsSupervisor;
                txtJoinedDate.Text = us.JoinedDate.ToString("MM/dd/yyyy");
                try
                {
                    ddlWorkingStatus.SelectedValue = us.WorkingStatusID.ToString();
                }
                catch { }
                lblEmployeeMessage.Text = "";
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
            DataTable dt = EmployeeData();
            if (!string.IsNullOrEmpty(pstr_sort))
                dt.DefaultView.Sort = pstr_sort;
            grvEmployeeList.DataSource = dt;
            grvEmployeeList.DataBind();
        }
        private DataTable EmployeeData()
        {
            string stremployeeid = txtEmployeeIDS.Text.Trim();
            string stremployeeidsap = txtEmployeeIDSAPS.Text.Trim();
            string strusername = txtUserNameS.Text.Trim();
            string stremployeename = txtEmployeeNameS.Text;
            int ioperatorgroup = Convert.ToInt32(ddlOperatorGroupS.SelectedValue);
            int icompany = Convert.ToInt32(ddlCompanyS.SelectedValue);
            int idepartment = Convert.ToInt32(ddlDepartmentS.SelectedValue);
            string strjobtitle = txtJobTitleS.Text.Trim();
            int iposition = Convert.ToInt32(ddlPositionS.SelectedValue);
            int iworkcell = Convert.ToInt32(ddlWorkcellS.SelectedValue);
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);
            DateTime dajoineddate = new DateTime(1900, 1, 1);
            try
            {
                dajoineddate = DateTime.ParseExact(txtJoinedDateS.Text, "MM/dd/yyyy", null);
            }
            catch { }
            int iissupervisor = Convert.ToInt16(ddlIsSupervisorS.SelectedValue);
            string strsupervisor = txtSupervisorS.Text.Trim();
            int iworkingstatusid = Convert.ToInt32(ddlWorkingStatusS.SelectedValue);
            int iisworking = Convert.ToInt16(ddlIsWorkingS.SelectedValue);
            string strwdno = txtWDNoS.Text.Trim();
            return HRTR.Server.HR_Employee.Search(stremployeeid
                , stremployeeidsap
                , strusername
                , stremployeename, ioperatorgroup
                , icompany, idepartment, strjobtitle
                , iposition
                //, ishift
                , iworkcell
                , strsupervisor
                , iisactive
                , iissupervisor
                , dajoineddate
                , iworkingstatusid
                , iisworking
                , strwdno);
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.HR_Employee stc = new HRTR.Server.HR_Employee())
                {
                    stc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
                    stc.EmployeeID = txtEmployeeID.Text.Trim();
                    stc.EmployeeIDSAP = txtEmployeeIDSAP.Text.Trim();
                    stc.UserName = txtUserName.Text.Trim();
                    stc.EmployeeName = txtEmployeeName.Text.Trim();
                    stc.OperatorGroupID = Convert.ToInt32(ddlOperatorGroup.SelectedValue);
                    stc.CompanyID = Convert.ToInt32(ddlCompany.SelectedValue);
                    stc.DepartmentID = Convert.ToInt32(ddlDepartment.SelectedValue);
                    stc.JobTitle = txtJobTitle.Text.Trim();
                    stc.PositionID = Convert.ToInt32(ddlPosition.SelectedValue);
                    stc.WorkcellID = Convert.ToInt32(ddlWorkcell.SelectedValue);
                    stc.IsActive = cbIsActive.Checked;
                    stc.IsSupervisor = cbIsSupervisor.Checked;
                    stc.Supervisor = txtSupervisor.Text.Trim();
                    DateTime daJoinedDate = new DateTime(1900, 1, 1);
                    try
                    {
                        daJoinedDate = DateTime.ParseExact(txtJoinedDate.Text, "MM/dd/yyyy", null);
                    }
                    catch{}
                    stc.JoinedDate = daJoinedDate;
                    stc.WorkingStatusID = Convert.ToInt32(ddlWorkingStatus.SelectedValue);
                    stc.Save();
                }
                BindData();
                ShowMessage(lblEmployee, string.Format("Saved employee {0} successfully.", txtEmployeeName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblEmployeeMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeEmployee.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.HR_Employee stc = new HRTR.Server.HR_Employee())
                {
                    stc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
                    stc.Delete();
                }
                BindData();
                ShowMessage(lblEmployee, string.Format("Deleted employee {0} successfully.", txtEmployeeName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblEmployeeMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeEmployee.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.HR_Employee stc = new HRTR.Server.HR_Employee())
                {
                    stc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
                    stc.EmployeeID = txtEmployeeID.Text.Trim();
                    stc.EmployeeIDSAP = txtEmployeeIDSAP.Text.Trim();
                    stc.UserName = txtUserName.Text.Trim();
                    stc.EmployeeName = txtEmployeeName.Text.Trim();
                    stc.OperatorGroupID = Convert.ToInt32(ddlOperatorGroup.SelectedValue);
                    stc.CompanyID = Convert.ToInt32(ddlCompany.SelectedValue);
                    stc.DepartmentID = Convert.ToInt32(ddlDepartment.SelectedValue);
                    stc.JobTitle = txtJobTitle.Text.Trim();
                    stc.PositionID = Convert.ToInt32(ddlPosition.SelectedValue);
                    stc.WorkcellID = Convert.ToInt32(ddlWorkcell.SelectedValue);
                    stc.IsActive = cbIsActive.Checked;
                    stc.IsSupervisor = cbIsSupervisor.Checked;
                    stc.Supervisor = txtSupervisor.Text.Trim();
                    DateTime daJoinedDate = new DateTime(1900, 1, 1);
                    try
                    {
                        daJoinedDate = DateTime.ParseExact(txtJoinedDate.Text, "MM/dd/yyyy", null);
                    }
                    catch { }
                    stc.JoinedDate = daJoinedDate;
                    stc.WorkingStatusID = Convert.ToInt32(ddlWorkingStatus.SelectedValue);
                    stc.Save();
                }
                BindData();
                ShowMessage(lblEmployee, string.Format("Updated employee {0} successfully.", txtEmployeeName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblEmployeeMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeEmployee.Show();
            }
        }
        #endregion

        #region Tab Control
        protected void mvEmployee_Command(object sender, CommandEventArgs e)
        {
            SetMultiviewActive((string)e.CommandName);
        }
        private void SetMultiviewActive(string strviewid)
        {
            switch (strviewid)
            {
                case "Search":
                    mvEmployee.SetActiveView(vSearchEmp);
                    lbSearch.CssClass = "multiviewtabactive";
                    lbImport.CssClass = "multiviewtabinactive";

                    break;
                case "Import":
                    mvEmployee.SetActiveView(vUploadEmployee);
                    lbSearch.CssClass = "multiviewtabinactive";
                    lbImport.CssClass = "multiviewtabactive";
                    break;

            }
        }
        #endregion

        #region Import
        protected void grvEmployeeTempList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvEmployeeTempList.PageIndex = e.NewPageIndex;
            BindDataTemp();
        }
        protected void grvEmployeeTempList_Sorting(object sender, GridViewSortEventArgs e)
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
            catch { }
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
            DataTable dt = HRTR.Server.HR_Employee.SearchTemp(iuserprofileid);
            if (!string.IsNullOrEmpty(pstr_sort))
                dt.DefaultView.Sort = pstr_sort;
            grvEmployeeTempList.DataSource = dt;
            grvEmployeeTempList.DataBind();
            grvEmployeeTempList.Visible = true;

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
        }
        protected void AsyncFUEmployee_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            string strext = Path.GetExtension(AsyncFUEmployee.FileName).ToLower();
            if (strext == ".xls" || strext == ".xlsx")
            {
                string strfilename = AsyncFUEmployee.FileName;
                string strtempfolder = HRTRConfig.GetTempFolder;
                string savePath = MapPath(Path.Combine(strtempfolder, strfilename));
                AsyncFUEmployee.SaveAs(savePath);
            }
            else
            {
                AsyncFUEmployee.ErrorBackColor = System.Drawing.Color.Red;
            }


        }
        protected void btnPreview_Click(object sender, EventArgs e)
        {
            try
            {
                lblUpload.Text = "";
                string strfilename = hdUploadFileName.Value;
                string strtempfolder = HRTRConfig.GetTempFolder;
                string strfile = MapPath(Path.Combine(strtempfolder, strfilename));
                HRTR.Server.HR_Employee.PreviewEmployee(strfile, this.UserProfileID);
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
                HRTR.Server.HR_Employee.Import(this.UserProfileID);

                BindData();

                grvEmployeeTempList.Visible = false;
                btnUploadAsk.Visible = false;

                ShowMessage(lblUpload, "Uploaded employee(s) successfully.");

            }
            catch (Exception ex)
            {
                ShowError(lblUpload, ex.Message);
            }
        }
        #endregion

        #region Export
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {

                DataTable dt = EmployeeData();

                //string strtempfolder = HRTRConfig.GetExportsFolder;

                string strdesfile = string.Format(@"{0}\EmployeeList_{1}.xlsx"
                    , HRTRConfig.GetExportsFolder
                    , DateTime.Now.ToString("MMddyyyyHHmmss"));

                string strdesfilefullpath = MapPath(strdesfile);

                string[] astrHideColumns = new string[1] { "EmployeeID_ID" };

                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                dicRenameColumns.Add("EmployeeID", "Employee ID");
                dicRenameColumns.Add("WDNo", "WD No.");
                dicRenameColumns.Add("EmployeeIDSAP", "Employee ID SAP");
                dicRenameColumns.Add("EmployeeName", "Employee Name");
                dicRenameColumns.Add("EmployeeIDName", "Employee Name + ID");

                dicRenameColumns.Add("UserName", "User Name");
                dicRenameColumns.Add("OperatorGroupName", "Operator Group");
                dicRenameColumns.Add("CompanyName", "Company");
                dicRenameColumns.Add("DepartmentName", "Department");
                dicRenameColumns.Add("JobTitle", "Job Title");
                dicRenameColumns.Add("PositionName", "Position");
                dicRenameColumns.Add("WorkcellName", "Workcell");
                dicRenameColumns.Add("IsActive", "Active");
                dicRenameColumns.Add("IsSupervisor", "Supervisor?");
                dicRenameColumns.Add("JoinedDate", "Joined Date");
                dicRenameColumns.Add("WorkingStatusName", "Working Status");
                dicRenameColumns.Add("IsContract", "Contract");
                dicRenameColumns.Add("IsWorking", "Working");
                dicRenameColumns.Add("LastUpdated", "Last Updated");
                dicRenameColumns.Add("LastUpdatedByFullName", "Last Updated By");
                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "Employee List");

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptEmployeeList", strscript, false);

            }
            catch (Exception ex)
            {
                ShowError(lblEmployee, ex.Message);
            }
        }
        #endregion
    }
}