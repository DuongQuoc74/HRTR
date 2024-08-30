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
using System.Linq;

namespace HRTR.TR {

    public partial class OrientationReport : HCM.BasePage.BasePage {

        #region Fields

        #endregion Fields

        #region Page Events

        protected override void OnLoad(EventArgs e) {
            base.OnLoad(e);
            if (!IsPostBack) {
                txtJoinedDateFrom.Text = DateTime.Now.AddMonths(-2).ToString("MM/dd/yyyy");

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

                DataTable dtPosition = CR_Position.Search();
                //Position
                ddlPosition.DataSource = dtPosition;
                ddlPosition.DataBind();
                ddlPosition.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtCompany = CR_Company.Search();
                //Company
                ddlCompany.DataSource = dtCompany;
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, new ListItem("[All]", "0"));
                ddlCompany.SelectedValue = "1";

                DataTable dtWorkcell = CR_Workcell.Search();
                //Workcell
                ddlWorkcell.DataSource = dtWorkcell;
                ddlWorkcell.DataBind();
                ddlWorkcell.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtTrainingStatus = CR_TrainingStatus.Search();
                //TrainingStatus
                ddlTrainingStatus.DataSource = dtTrainingStatus;
                ddlTrainingStatus.DataBind();
                ddlTrainingStatus.Items.Insert(0, new ListItem("[All]", "0"));

                DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);

                ddcTrainingGroup.DataSource = dtTrainingGroup;
                ddcTrainingGroup.DataBind();
                TrainingGroupSelected();
                CourseGroupSelected();

                Session["OrientationTrainingRecord_Sort"] = "";
                string stremployeeidsaplist = string.Empty;
                try {
                    stremployeeidsaplist = Convert.ToString(Request.QueryString["eml"]);
                    if (!string.IsNullOrEmpty(stremployeeidsaplist)) {
                        txtEmployeeIDSAP.Text = stremployeeidsaplist;
                        BindOrientationTrainingRecord();
                    }
                }
                catch { }
            }
            else { }
        }

        #endregion Page Events

        #region Control Events

        protected void btnSearch_Click(object sender, EventArgs e) {
            try {
                lblSearch.Text = "";
                BindOrientationTrainingRecord();
            }
            catch (Exception ex) {
                ShowError(lblSearch, ex.Message);
            }
        }

        protected void btnExport_Click(object sender, EventArgs e) {
            try {
                lblSearch.Text = "";
                DataTable dt = OrientationTrainingRecordData();
                //string strtempfolder = HRTRConfig.GetExportsFolder;
                string strdesfile = "";
                string strExcelSheetName = "";
                if (ddlOutputType.SelectedValue == "1") {
                    strExcelSheetName = "Orientation Training Records Summary";
                    strdesfile = string.Format(@"{0}\OrientationTrainingRecordsSummary_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , String.Format("{0:MMddyyyyHHmmss}", DateTime.Now));
                }
                else {
                    strExcelSheetName = "Orientation Training Records Details";
                    strdesfile = string.Format(@"{0}\OrientationTrainingRecordsDetails_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , String.Format("{0:MMddyyyyHHmmss}", DateTime.Now));
                }
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[0];
                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, strExcelSheetName);
                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptOrientationReport", strscript, false);
            }
            catch (Exception ex) {
                ShowError(lblSearch, ex.Message);
            }
        }

        #endregion Control Events

        #region Training Record List

        protected void grvOrientationRecord_PageIndexChanging(object sender, GridViewPageEventArgs e) {
            grvOrientationRecord.PageIndex = e.NewPageIndex;
            BindOrientationTrainingRecord();
            grvOrientationRecord.SelectedIndex = -1;
        }

        //protected int i = 1;

        protected void grvOrientationRecord_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                for (int i = 1; i < e.Row.Cells.Count; i++) {
                    try {
                        DataControlFieldCell dcfc = (DataControlFieldCell)e.Row.Cells[i];
                        string strfieldname = dcfc.ContainingField.HeaderText;
                        if (strfieldname.Equals("Completed %", StringComparison.CurrentCultureIgnoreCase)) {
                            e.Row.Cells[i].CssClass = "right";
                            e.Row.Cells[i].Text = string.Format("{0:P2}", Convert.ToDouble(e.Row.Cells[i].Text));
                        }
                        else if (DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.Boolean)) {
                            e.Row.Cells[i].CssClass = "checkbox";
                        }
                        else if (DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.Int32)
                            || DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.Decimal)
                            || DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.Double)
                            || DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.Int64)
                            || DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.Int16)) {
                            e.Row.Cells[i].CssClass = "right";
                        }
                        else if (DataBinder.Eval(e.Row.DataItem, strfieldname).GetType() == typeof(System.DateTime)) {
                            e.Row.Cells[i].Text = Convert.ToDateTime(e.Row.Cells[i].Text).ToString("MM/dd/yyyy");
                        }
                    }
                    catch { }
                }
            }
        }

        protected void grvOrientationRecord_Sorting(object sender, GridViewSortEventArgs e) {
            string str_ssname = "OrientationTrainingRecord_Sort";
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
            BindOrientationTrainingRecord(str_sort);
        }

        protected void grvOrientationRecord_RowCommand(object sender, GridViewCommandEventArgs e) {
        }

        private void BindOrientationTrainingRecord(string pstr_sort = "") {
            DataTable dtOrientationTrainingRecord = OrientationTrainingRecordData();
            if (string.IsNullOrEmpty(pstr_sort)) {
                try {
                    if (Session["OrientationTrainingRecord_Sort"] != null) {
                        pstr_sort = Session["OrientationTrainingRecord_Sort"].ToString();
                    }
                }
                catch { }
            }

            if (!string.IsNullOrEmpty(pstr_sort))
                dtOrientationTrainingRecord.DefaultView.Sort = pstr_sort;
            //OrientationRecord_BuildGridViewColumn(dtOrientationTrainingRecord);
            grvOrientationRecord.DataSource = dtOrientationTrainingRecord;
            grvOrientationRecord.DataBind();
        }

        private DataTable OrientationTrainingRecordData() {
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
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);

            #region Training Group List

            string strtraininggroupidlist = string.Empty;
            foreach (ListItem item in ddcTrainingGroup.Items) {
                if (item.Selected)
                    strtraininggroupidlist = strtraininggroupidlist + item.Value + ";";
            }

            #endregion Training Group List

            #region Course Group List

            string strcoursegroupidlist = string.Empty;
            foreach (ListItem item in ddcCourseGroup.Items) {
                if (item.Selected)
                    strcoursegroupidlist = strcoursegroupidlist + item.Value + ";";
            }

            #endregion Course Group List

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
            foreach (ListItem item in ddcCourse.Items) {
                if (item.Selected)
                    strcoursenamelist = strcoursenamelist + item.Value + ";";
            }

            #endregion Course List

            int iproductid = Convert.ToInt32(ddlProduct.SelectedValue);
            DateTime daExpDateFrom = new DateTime(1900, 1, 1);
            try {
                daExpDateFrom = DateTime.ParseExact(txtExpDateFrom.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daExpDateTo = new DateTime(1900, 1, 1);
            try {
                daExpDateTo = DateTime.ParseExact(txtExpDateTo.Text, "MM/dd/yyyy", null);
            }
            catch { }

            DateTime daCerDateFrom = new DateTime(1900, 1, 1);
            try {
                daCerDateFrom = DateTime.ParseExact(txtCerDateFrom.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daCerDateTo = new DateTime(1900, 1, 1);
            try {
                daCerDateTo = DateTime.ParseExact(txtCerDateTo.Text, "MM/dd/yyyy", null);
            }
            catch { }

            DateTime daJoinedDateFrom = new DateTime(1900, 1, 1);
            try {
                daJoinedDateFrom = DateTime.ParseExact(txtJoinedDateFrom.Text, "MM/dd/yyyy", null);
            }
            catch { }
            DateTime daJoinedDateTo = new DateTime(1900, 1, 1);
            try {
                daJoinedDateTo = DateTime.ParseExact(txtJoinedDateTo.Text, "MM/dd/yyyy", null);
            }
            catch { }

            #region Working Status

            string strworkingstatusidlist = string.Empty;
            foreach (ListItem item in ddcWorkingStatus.Items) {
                if (item.Selected)
                    strworkingstatusidlist = strworkingstatusidlist + item.Value + ";";
            }

            #endregion Working Status

            int iisworking = Convert.ToInt16(ddlIsWorking.SelectedValue);
            int inumberofdays = Convert.ToInt16(txtExpectedToCompleteBefore_Days.Text);
            int ioutputtypeid = Convert.ToInt16(ddlOutputType.SelectedValue);
            int itrainingstatusid = Convert.ToInt16(ddlTrainingStatus.SelectedValue);
            DataTable dtOrientationTrainingRecord = HRTR.Server.TrainingRecord.rptTrainingRecord_OrientationRecord(stremployeeid, stremployeeidsap
                , stremployeename, ioperatorgroup,
                icompany, idepartment, strjobtitle, iposition, iworkcell,
                strsupervisor, iisactive
                , 0, strtraininggroupidlist
                , 0, strcoursegroupidlist
                , "", strcoursenamelist
                , iproductid, daExpDateFrom, daExpDateTo, daCerDateFrom, daCerDateTo, daJoinedDateFrom, daJoinedDateTo
                , 0, strworkingstatusidlist, inumberofdays, ioutputtypeid, itrainingstatusid
                , iisworking);
            return dtOrientationTrainingRecord;
        }

        #endregion Training Record List

        #region Control Events

        protected void ddcTrainingGroup_SelectedIndexChanged(object sender, EventArgs e) {
            TrainingGroupSelected();
        }

        private void TrainingGroupSelected() {
            string strtraininggroupidlist = string.Empty;
            foreach (ListItem item in ddcTrainingGroup.Items) {
                if (item.Selected)
                    strtraininggroupidlist = strtraininggroupidlist + item.Value + ";";
            }
            DataTable dtCourseGroup = CR_CourseGroup.SearchByTrainingGroupList(strtraininggroupidlist);
            //CoursrGroup
            ddcCourseGroup.Items.Clear();
            ddcCourseGroup.DataSource = dtCourseGroup;
            ddcCourseGroup.DataBind();

            ddcCourse.Items.Clear();

            DataTable dtProduct = CR_Product.Search(string.Empty
                , 0
                , strtraininggroupidlist);
            //CoursrGroup
            ddlProduct.Items.Clear();
            ddlProduct.DataSource = dtProduct;
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, new ListItem("[All]", "0"));
        }

        protected void ddcCourseGroup_SelectedIndexChanged(object sender, EventArgs e) {
            CourseGroupSelected();
        }

        private void CourseGroupSelected() {
            string strcoursegroupidlist = string.Empty;
            foreach (ListItem item in ddcCourseGroup.Items) {
                if (item.Selected)
                    strcoursegroupidlist = strcoursegroupidlist + item.Value + ";";
            }
            DataTable dtCourse = HRTR.Server.CR_Course.Search(string.Empty, 0, 0, -1, -1, -1, -1, strcoursegroupidlist);
            dtCourse = dtCourse.DefaultView.ToTable(true, "CourseName");
            ddcCourse.Items.Clear();
            ddcCourse.DataSource = dtCourse;
            ddcCourse.DataBind();
        }

        //protected void ddlOutputType_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlOutputType.SelectedValue == "1")
        //    {
        //        ddlTrainingStatus.Items[3].Enabled = true;
        //    }
        //    else
        //    {
        //        ddlTrainingStatus.Items[3].Enabled = false;
        //    }
        //}

        #endregion Control Events

        #region Private Methods

        //private void OrientationRecord_BuildGridViewColumn(DataTable dtOrientationTrainingRecord)
        //{
        //    grvOrientationRecord.Columns.Clear();
        //    int iColumnCount = dtOrientationTrainingRecord.Columns.Count;
        //    for (int i = 0; i < iColumnCount; i++)
        //    {
        //        string strColumnName = dtOrientationTrainingRecord.Columns[i].ColumnName;
        //        string strDataType = dtOrientationTrainingRecord.Columns[i].DataType.ToString().ToLower();
        //        BoundField bfOrientationRecord = new BoundField();
        //        bfOrientationRecord.DataField = strColumnName;
        //        bfOrientationRecord.HeaderText = strColumnName;
        //        bfOrientationRecord.SortExpression = strColumnName;
        //        if (strDataType.Equals("system.datetime"))
        //        {
        //            bfOrientationRecord.DataFormatString = "{0:MM/dd/yyyy}";
        //        }
        //        else if (strColumnName.Equals("No."))
        //        {
        //            bfOrientationRecord.ItemStyle.CssClass = "rowno";
        //        }
        //        else if (strColumnName.Equals("Score") ||
        //                 strColumnName.Equals("Total Courses") ||
        //                 strColumnName.Equals("Completed Courses") ||
        //                 strColumnName.Equals("Remaining Courses") ||
        //                 strColumnName.Equals("Completed %"))
        //        {
        //            bfOrientationRecord.ItemStyle.CssClass = "right";
        //        }
        //        grvOrientationRecord.Columns.Add(bfOrientationRecord);
        //    }
        //}

        #endregion Private Methods
    }
}