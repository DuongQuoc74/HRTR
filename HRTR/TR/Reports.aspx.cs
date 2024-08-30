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
using eUtilities;
using SystemAuth;

namespace HRTR.TR
{

    public partial class Reports : HCM.BasePage.BasePage
    {

        #region Fields

        //string _TrainingGroupIDList = string.Empty;
        //string _CourseGroupIDList = string.Empty;

        #endregion Fields

        #region Page Events

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                DataTable dtOperatorGroup = CR_OperatorGroup.Search();
                //OperatorGroup
                ddlOperatorGroup.DataSource = dtOperatorGroup;
                ddlOperatorGroup.DataBind();
                ddlOperatorGroup.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtDepartment = SY_Department.Search();
                //Department
                ddlDepartment.DataSource = dtDepartment;
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtWorkingStatus = CR_WorkingStatus.Search();
                //WorkingStatus
                ddcWorkingStatus.DataSource = dtWorkingStatus;
                ddcWorkingStatus.DataBind();
                //ddcWorkingStatus.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtPosition = CR_Position.Search();
                //Position
                ddlPosition.DataSource = dtPosition;
                ddlPosition.DataBind();
                ddlPosition.Items.Insert(0, new ListItem("[All]", "0"));
                if (!ddlPosition.Enabled)
                {
                    ddlPosition.SelectedValue = "1";
                }
                DataTable dtCompany = CR_Company.Search();
                //Company
                ddlCompany.DataSource = dtCompany;
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtWorkcell = CR_Workcell.Search();
                //Workcell
                ddlWorkcell.DataSource = dtWorkcell;
                ddlWorkcell.DataBind();
                ddlWorkcell.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtCertifiedLevel = HRTR.Server.CR_CertifiedLevel.Search();
                ddcCertifiedLevel.DataSource = dtCertifiedLevel;
                ddcCertifiedLevel.DataBind();

                DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);
                ddcTrainingGroup.DataSource = dtTrainingGroup;
                ddcTrainingGroup.DataBind();

                TrainingGroupSelected();
                CourseGroupSelected();

                Session["TrainingRecordSort"] = "";
                string stremployeeidsaplist = string.Empty;
                try
                {
                    stremployeeidsaplist = Convert.ToString(Request.QueryString["eml"]);
                    if (!string.IsNullOrEmpty(stremployeeidsaplist))
                    {
                        txtEmployeeIDSAP.Text = stremployeeidsaplist;
                        BindTrainingRecord();
                    }
                }
                catch { }

                //if (CheckUserPermissionRole(new List<int>() { (int)EPermissionRole.View_Only }, new List<int>() { (int)EPermissionRole.Admin, (int)EPermissionRole.Input, (int)EPermissionRole.Full_Report, (int)EPermissionRole.Trainer_Leader, (int)EPermissionRole.Trainers }))
                //{
                //    ddlPosition.SelectedValue = "1";
                //    ddlPosition.Enabled = false;
                //    ddlIsActive_EmployeeS.Enabled = false;
                //    cbIsLatestRecords.Enabled = false;
                //    ddlIsActive_TrainingRecordS.Enabled = false;
                //    btnExport.Enabled = false;
                //}
            }
        }

        #endregion Page Events

        #region Control Events

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                lblSearch.Text = "";
                BindTrainingRecord();
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                lblSearch.Text = "";
                DataTable dt = TrainingRecordData();
                //string strtempfolder = HRTRConfig.GetExportsFolder;
                //string strtemplatesfolder = HRTRConfig.GetTemplatesFolder;
                string strdesfile = string.Format(@"{0}\TrainingRecord_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , String.Format("{0:MMddyyyyHHmmss}", DateTime.Now));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[1] { "EmployeeID_ID" };

                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                //dicRenameColumns.Add("EmployeeID", "Employee ID");
                //dicRenameColumns.Add("EmployeeIDSAP", "Employee ID SAP");
                //dicRenameColumns.Add("WorkcellName", "Workcell");
                string strExcelSheetName = "Training Records";
                OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, strExcelSheetName);
                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptTrainingRecord", strscript, false);
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }

        #endregion Control Events

        #region Training Record List

        protected void grvTrainingRecord_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvTrainingRecord.PageIndex = e.NewPageIndex;
            BindTrainingRecord();
            grvTrainingRecord.SelectedIndex = -1;
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
        }

        private void BindTrainingRecord(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["TrainingRecordSort"] != null)
                    {
                        pstr_sort = Session["TrainingRecordSort"].ToString();
                    }
                }
                catch { }
            }
            DataTable dtTrainingRecord = TrainingRecordData();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtTrainingRecord.DefaultView.Sort = pstr_sort;
            grvTrainingRecord.DataSource = dtTrainingRecord;
            grvTrainingRecord.DataBind();
        }

        private DataTable TrainingRecordData()
        {
            string stremployeeid = txtEmployeeID.Text.Trim();
            string stremployeeidsap = txtEmployeeIDSAP.Text.Trim();
            string stremployeename = txtEmployeeName.Text.Trim();
            int ioperatorgroup = Convert.ToInt32(ddlOperatorGroup.SelectedValue);
            int icompany = Convert.ToInt32(ddlCompany.SelectedValue);
            int idepartment = Convert.ToInt32(ddlDepartment.SelectedValue);
            string strjobtitle = txtJobTitle.Text.Trim();
            int iposition = Convert.ToInt32(ddlPosition.SelectedValue);
            int iworkcell = Convert.ToInt32(ddlWorkcell.SelectedValue);
            string strsupervisor = txtSupervisor.Text.Trim();
            int iisactive_employee = Convert.ToInt16(ddlIsActive_EmployeeS.SelectedValue);
            //int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);

            #region Training Group List

            string strtraininggroupidlist = string.Empty;
            foreach (ListItem item in ddcTrainingGroup.Items)
            {
                if (item.Selected)
                    strtraininggroupidlist = strtraininggroupidlist + item.Value + ";";
            }

            #endregion Training Group List

            //int icoursegroupid = Convert.ToInt32(ddlCourseGroup.SelectedValue);

            #region Course Group List

            string strcoursegroupidlist = string.Empty;
            foreach (ListItem item in ddcCourseGroup.Items)
            {
                if (item.Selected)
                    strcoursegroupidlist = strcoursegroupidlist + item.Value + ";";
            }

            #endregion Course Group List

            //int icourseid = Convert.ToInt32(ddlCourse.SelectedValue);
            //#region Course List
            //string strcourseidlist = string.Empty;
            //foreach (ListItem item in ddcCourse.Items)
            //{
            //    if (item.Selected)
            //        strcourseidlist = strcourseidlist + item.Value + ";";
            //}
            //#endregion Course List

            #region Course List

            string strcoursenamelist = string.Empty;
            foreach (ListItem item in ddcCourse.Items)
            {
                if (item.Selected)
                    strcoursenamelist = strcoursenamelist + item.Value + ";";
            }

            #endregion Course List

            int iproductid = Convert.ToInt32(ddlProduct.SelectedValue);
            DateTime daExpDateFrom = new DateTime(1900, 1, 1);
            try
            {
                daExpDateFrom = DateTime.ParseExact(txtExpDateFrom.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daExpDateTo = new DateTime(1900, 1, 1);
            try
            {
                daExpDateTo = DateTime.ParseExact(txtExpDateTo.Text, "MM/dd/yyyy", null);
            }
            catch { }

            DateTime daCerDateFrom = new DateTime(1900, 1, 1);
            try
            {
                daCerDateFrom = DateTime.ParseExact(txtCerDateFrom.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daCerDateTo = new DateTime(1900, 1, 1);
            try
            {
                daCerDateTo = DateTime.ParseExact(txtCerDateTo.Text, "MM/dd/yyyy", null);
            }
            catch { }
            bool bislatestrecords = cbIsLatestRecords.Checked;
            int iisactive_trainingrecord = Convert.ToInt16(ddlIsActive_TrainingRecordS.SelectedValue);

            #region Working Status

            string strworkingstatusidlist = string.Empty;
            foreach (ListItem item in ddcWorkingStatus.Items)
            {
                if (item.Selected)
                    strworkingstatusidlist = strworkingstatusidlist + item.Value + ";";
            }

            #endregion Working Status

            int iisworking = Convert.ToInt16(ddlIsWorking.SelectedValue);

            #region Certified List

            string strcertifiedidlist = string.Empty;
            foreach (ListItem item in ddcCertifiedLevel.Items)
            {
                if (item.Selected)
                    strcertifiedidlist = strcertifiedidlist + item.Value + ";";
            }

            #endregion Certified List

            DataTable dtTrainingRecord = HRTR.Server.TrainingRecord.Search(
                stremployeeid,
                stremployeeidsap,
                stremployeename,
                ioperatorgroup,
                icompany,
                idepartment,
                strjobtitle,
                iposition,
                iworkcell,
                strsupervisor,
                iisactive_employee,
                0,
                strtraininggroupidlist,
                0,
                strcoursegroupidlist,
                "",
                strcoursenamelist,
                iproductid,
                daExpDateFrom,
                daExpDateTo,
                daCerDateFrom,
                daCerDateTo,
                bislatestrecords,
                iisactive_trainingrecord,
                0,
                strworkingstatusidlist,
                0,
                strcertifiedidlist,
                iisworking);
            return dtTrainingRecord;
        }

        #endregion Training Record List

        #region Control Events

        protected void ddcTrainingGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            TrainingGroupSelected();
        }

        private void TrainingGroupSelected()
        {
            string strtraininggroupidlist = string.Empty;
            foreach (ListItem item in ddcTrainingGroup.Items)
            {
                if (item.Selected)
                    strtraininggroupidlist = strtraininggroupidlist + item.Value + ";";
            }
            DataTable dtCourseGroup = CR_CourseGroup.SearchByTrainingGroupList(strtraininggroupidlist);
            //CoursrGroup
            ddcCourseGroup.Items.Clear();
            ddcCourseGroup.DataSource = dtCourseGroup;
            ddcCourseGroup.DataBind();
            //ddlCourseGroup.Items.Insert(0, new ListItem("[All]", "0"));

            ddcCourse.Items.Clear();
            //ddcCourse.Items.Insert(0, new ListItem("[All]", "0"));

            DataTable dtProduct = CR_Product.Search(string.Empty
                , 0
                , strtraininggroupidlist);
            //CoursrGroup
            ddlProduct.Items.Clear();
            ddlProduct.DataSource = dtProduct;
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, new ListItem("[All]", "0"));
        }

        protected void ddcCourseGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            CourseGroupSelected();
        }

        private void CourseGroupSelected()
        {
            string strcoursegroupidlist = string.Empty;
            foreach (ListItem item in ddcCourseGroup.Items)
            {
                if (item.Selected)
                    strcoursegroupidlist = strcoursegroupidlist + item.Value + ";";
            }
            DataTable dtCourse = HRTR.Server.CR_Course.Search(string.Empty, 0, 0, -1, -1, -1, -1, strcoursegroupidlist);
            dtCourse = dtCourse.DefaultView.ToTable(true, "CourseName");
            ddcCourse.Items.Clear();
            ddcCourse.DataSource = dtCourse;
            ddcCourse.DataBind();
            //ddlCourse.Items.Insert(0, new ListItem("[All]", "0"));
        }

        //protected void ddlTrainingGroup_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    HRTR.Server.CR_TrainingGroup tg = new HRTR.Server.CR_TrainingGroup();
        //    tg.TrainingGroupID = Convert.ToInt32(ddlTrainingGroup.SelectedValue);

        //    DataTable dtCourseGroup = tg.GetCourseGroupByTrainingGroup();

        //    //CoursrGroup
        //    ddlCourseGroup.Items.Clear();
        //    ddlCourseGroup.DataSource = dtCourseGroup;
        //    ddlCourseGroup.DataBind();
        //    ddlCourseGroup.Items.Insert(0, new ListItem("[All]", "0"));

        //    ddlCourse.Items.Clear();
        //    ddlCourse.Items.Insert(0, new ListItem("[All]", "0"));

        //    DataTable dtProduct = tg.GetProductByTrainingGroup();
        //    //CoursrGroup
        //    ddlProduct.Items.Clear();
        //    ddlProduct.DataSource = dtProduct;
        //    ddlProduct.DataBind();
        //    ddlProduct.Items.Insert(0, new ListItem("[All]", "0"));
        //}
        //protected void ddlCourseGroup_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
        //    int icoursegroupid = Convert.ToInt32(ddlCourseGroup.SelectedValue);
        //    DataTable dtCourse = HRTR.Server.CR_Course.Search(string.Empty, icoursegroupid, itraininggroupid);
        //    ddlCourse.Items.Clear();
        //    ddlCourse.DataSource = dtCourse;
        //    ddlCourse.DataBind();
        //    ddlCourse.Items.Insert(0, new ListItem("[All]", "0"));
        //}

        #endregion Control Events

        #region Private Methods

        #endregion Private Methods
    }
}