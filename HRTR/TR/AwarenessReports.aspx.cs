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
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;

namespace HRTR.TR {

    public partial class AwarenessReports : HCM.BasePage.BasePage {

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
                ddlTrainingGroup.DataSource = dtTrainingGroup;
                ddlTrainingGroup.DataBind();
                ddlTrainingGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));
                TrainingGroupSelected();

                Session["AwarenessTrainingModule_Sort"] = "";
                string stremployeeidsaplist = string.Empty;
                try {
                    stremployeeidsaplist = Convert.ToString(Request.QueryString["eml"]);
                    if (!string.IsNullOrEmpty(stremployeeidsaplist)) {
                        txtEmployeeIDSAP.Text = stremployeeidsaplist;
                        BindAwarenessTrainingModule();
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
                Session["AwarenessTrainingModule_Sort"] = "";
                BindAwarenessTrainingModule();
                if (ddlOutputType.SelectedValue == "1") {
                    chartColumnChart_AwarenessRecord.Visible = false;
                    //ddlTrainingStatus.Enabled = true;
                    //btnExport.Visible = true;
                }
                else {
                    BindColumnChartData(ddlCourse.SelectedItem.ToString(), ddlWorkcell.SelectedItem.ToString());
                    chartColumnChart_AwarenessRecord.Visible = true;
                    //ddlTrainingStatus.Enabled = false;
                    //btnExport.Visible = false;
                }
            }
            catch (Exception ex) {
                ShowError(lblSearch, ex.Message);
            }
        }

        protected void btnExport_Click(object sender, EventArgs e) {
            try {
                lblSearch.Text = "";
                DataTable dt = AwarenessTrainingModuleData();
                string strExcelSheetName = "Awareness Training Module";
                string strdesfile = string.Format(@"{0}\AwarenessTrainingModule_{1}.xlsx"
               , HRTRConfig.GetExportsFolder
               , String.Format("{0:MMddyyyyHHmmss}", DateTime.Now));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[0];
                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, strExcelSheetName);
                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptAwarenessReport", strscript, false);
            }
            catch (Exception ex) {
                ShowError(lblSearch, ex.Message);
            }
        }

        #endregion Control Events

        #region Training Record List

        protected void grvAwarenessRecord_PageIndexChanging(object sender, GridViewPageEventArgs e) {
            grvAwarenessRecord.PageIndex = e.NewPageIndex;
            BindAwarenessTrainingModule();
            grvAwarenessRecord.SelectedIndex = -1;
        }

        //protected int i = 1;

        protected void grvAwarenessRecord_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                for (int i = 1; i < e.Row.Cells.Count; i++) {
                    try {
                        DataControlFieldCell dcfc = (DataControlFieldCell)e.Row.Cells[i];
                        string strfieldname = dcfc.ContainingField.HeaderText;
                        if (strfieldname.Equals("Percent", StringComparison.CurrentCultureIgnoreCase)) {
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

        protected void grvAwarenessRecord_Sorting(object sender, GridViewSortEventArgs e) {
            string str_ssname = "AwarenessTrainingModule_Sort";
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
            BindAwarenessTrainingModule(str_sort);
        }

        private void BindAwarenessTrainingModule(string pstr_sort = "") {
            DataTable dtAwarenessTrainingModule = AwarenessTrainingModuleData();
            if (string.IsNullOrEmpty(pstr_sort)) {
                try {
                    if (Session["AwarenessTrainingModule_Sort"] != null) {
                        pstr_sort = Session["AwarenessTrainingModule_Sort"].ToString();
                    }
                }
                catch { }
            }

            if (!string.IsNullOrEmpty(pstr_sort))
                dtAwarenessTrainingModule.DefaultView.Sort = pstr_sort;
            grvAwarenessRecord.DataSource = dtAwarenessTrainingModule;
            grvAwarenessRecord.DataBind();
        }

        private void BindColumnChartData(string pstrcoursename, string pstrworkcell) {
            DataTable dtAwarenessTrainingModule = AwarenessTrainingModuleData();
            List<string> lStatus = new List<string>();///X
            List<int> lNumber = new List<int>();///Y
            List<double> lPercent = new List<double>();///Y2
            double dbmax = 0;
            for (int i = 0; i < dtAwarenessTrainingModule.Rows.Count; i++) {
                lStatus.Add(dtAwarenessTrainingModule.Rows[i]["Status"].ToString().ToUpper());
                int inumber = Convert.ToInt32(dtAwarenessTrainingModule.Rows[i]["Number"]);
                lNumber.Add(inumber);
                if (inumber > dbmax) {
                    dbmax = inumber;
                }
                lPercent.Add(Math.Round(Convert.ToDouble(dtAwarenessTrainingModule.Rows[i]["Percent"]) * 100, 2));
            }

            string[] xValues = lStatus.ToArray();
            int[] yValues = lNumber.ToArray();
            double[] yValues2 = lPercent.ToArray();

            Series chartSeriesNumber = new Series("NUMBER");
            chartSeriesNumber.ChartType = SeriesChartType.Column;
            chartSeriesNumber.Color = System.Drawing.ColorTranslator.FromHtml("#3876BF");
            chartSeriesNumber.IsValueShownAsLabel = true;
            chartSeriesNumber.BorderWidth = 4;
            chartSeriesNumber["BarLabelStyle"] = "Top";
            chartSeriesNumber.Font = new System.Drawing.Font("Trebuchet MS", 10, FontStyle.Bold);
            chartSeriesNumber.Points.DataBindXY(xValues, yValues);
            chartSeriesNumber.SmartLabelStyle.MovingDirection = LabelAlignmentStyles.Right;
            chartColumnChart_AwarenessRecord.Series.Add(chartSeriesNumber);

            Series chartSeriesPercent = new Series("PERCENT");
            chartSeriesPercent.ChartType = SeriesChartType.Line;
            chartSeriesPercent.Color = System.Drawing.ColorTranslator.FromHtml("#B9504C");
            chartSeriesPercent.IsValueShownAsLabel = true;
            chartSeriesPercent.BorderWidth = 4;
            chartSeriesPercent.Font = new System.Drawing.Font("Trebuchet MS", 10, FontStyle.Bold);
            chartSeriesPercent.YAxisType = AxisType.Secondary;
            chartSeriesPercent.Label = "#VALY" + "%";
            chartSeriesPercent.Points.DataBindXY(xValues, yValues2);
            chartSeriesPercent.SmartLabelStyle.MovingDirection = LabelAlignmentStyles.Left;
            chartColumnChart_AwarenessRecord.Series.Add(chartSeriesPercent);

            ChartArea chartArea = new ChartArea();
            Axis yAxis = new Axis(chartArea, AxisName.Y);
            Axis xAxis = new Axis(chartArea, AxisName.X);

            chartArea.AxisX.MajorGrid.Enabled = false;
            chartArea.AxisX.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 10, FontStyle.Bold);
            ///Number
            chartArea.AxisY.MajorGrid.Enabled = false;
            chartArea.AxisY.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 10, FontStyle.Bold);
            chartArea.AxisY.Maximum = Math.Ceiling(dbmax / 100) * 100;
            ///Percent
            chartArea.AxisY2.Maximum = 100;
            chartArea.AxisY2.MajorGrid.Enabled = false;
            chartArea.AxisY2.LabelStyle.Format = "{0}%";
            chartArea.AxisY2.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 10, FontStyle.Bold);

            chartColumnChart_AwarenessRecord.ChartAreas.Add(chartArea);
            chartColumnChart_AwarenessRecord.Titles[0].Text = pstrcoursename + " " + pstrworkcell.Replace("[", "").Replace("]", "") + " Workcell";
        }

        private DataTable AwarenessTrainingModuleData() {
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

            //string strtraininggroupidlist = string.Empty;
            //foreach (ListItem item in ddcTrainingGroup.Items)
            //{
            //    if (item.Selected)
            //        strtraininggroupidlist = strtraininggroupidlist + item.Value + ";";
            //}

            #endregion Training Group List

            #region Course Group List

            //string strcoursegroupidlist = string.Empty;
            //foreach (ListItem item in ddcCourseGroup.Items)
            //{
            //    if (item.Selected)
            //        strcoursegroupidlist = strcoursegroupidlist + item.Value + ";";
            //}

            #endregion Course Group List

            #region Course List

            //string strcoursenamelist = string.Empty;
            //foreach (ListItem item in ddcCourse.Items)
            //{
            //    if (item.Selected)
            //        strcoursenamelist = strcoursenamelist + item.Value + ";";
            //}

            #endregion Course List

            int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
            int icoursegroupid = Convert.ToInt32(ddlCourseGroup.SelectedValue);
            int icourseid = Convert.ToInt32(ddlCourse.SelectedValue);

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
            DataTable dtAwarenessTrainingModule = HRTR.Server.TrainingRecord.rptTrainingRecord_AwarenessRecord(stremployeeid, stremployeeidsap
                , stremployeename, ioperatorgroup,
                icompany, idepartment, strjobtitle, iposition, iworkcell,
                strsupervisor, iisactive
                , itraininggroupid, icoursegroupid, icourseid
                , iproductid, daExpDateFrom, daExpDateTo, daCerDateFrom, daCerDateTo, daJoinedDateFrom, daJoinedDateTo
                , 0, strworkingstatusidlist, inumberofdays, ioutputtypeid, itrainingstatusid
                , iisworking);
            return dtAwarenessTrainingModule;
        }

        #endregion Training Record List

        #region Control Events

        protected void ddlTrainingGroup_SelectedIndexChanged(object sender, EventArgs e) {
            TrainingGroupSelected();
        }

        private void TrainingGroupSelected() {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
            ddlCourseGroup.Items.Clear();
            DataTable dt = HRTR.Server.CR_CourseGroup.SearchByTrainingGroupID(itraininggroupid);

            ddlCourseGroup.DataSource = dt;
            ddlCourseGroup.DataBind();
            ddlCourseGroup.Items.Insert(0, new ListItem("[Please select]", "0"));

            DataTable dtProduct = CR_Product.Search(string.Empty, itraininggroupid, string.Empty);
            ddlProduct.Items.Clear();
            ddlProduct.DataSource = dtProduct;
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, new ListItem("[All]", "0"));

            CourseGroupSelected();
        }

        protected void ddlCourseGroup_SelectedIndexChanged(object sender, EventArgs e) {
            CourseGroupSelected();
        }

        private void CourseGroupSelected() {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
            int icoursegroupid = Convert.ToInt32(ddlCourseGroup.SelectedValue);
            ddlCourse.Items.Clear();
            DataTable dt = HRTR.Server.CR_Course.Search(string.Empty, icoursegroupid, itraininggroupid, -1, -1, -1, -1, string.Empty);
            ddlCourse.DataSource = dt;
            ddlCourse.DataBind();
            //DataTable dt = new DataTable();
            //if (ddlCourseGroup.SelectedValue != "0")
            //{
            //    dt = HRTR.Server.CR_Course.Search(string.Empty, icoursegroupid, itraininggroupid, -1, -1, -1, string.Empty);
            //    ddlCourse.DataSource = dt;
            //    ddlCourse.DataBind();
            //}
            ddlCourse.Items.Insert(0, new ListItem("[Please select]", "0"));
        }

        #endregion Control Events

        #region Private Methods

        #endregion Private Methods
    }
}