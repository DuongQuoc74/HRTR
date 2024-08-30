using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using HRTR.Server;
using HRTR.JDoc;
using System.Configuration;
using eUtilities;
using System.Globalization;

namespace HRTR.TR
{
    public partial class EmployeeDocumentMapping : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                ClearSearch();
            }
        }
        #endregion Page Events

        #region Employee Search Events
        protected void ClearSearch()
        {
            ddlTrainingGroupS.Items.Clear();
            ddlCourseGroupS.Items.Clear();
            ddlCourseS.Items.Clear();
            ddlWorkcellS.Items.Clear();
            ddlStationS.Items.Clear();

            DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);
            //TrainingGroup
            ddlTrainingGroupS.DataSource = dtTrainingGroup;
            ddlTrainingGroupS.DataBind();
            ListItem li = new ListItem("[Please Select]", "0");
            ddlTrainingGroupS.Items.Insert(0, li);

            ddlCourseGroupS.Items.Insert(0, li);

            ddlCourseS.Items.Insert(0, li);

            //Workcell
            DataTable dtWorkcell = CR_Workcell.Search();
            ddlWorkcellS.DataSource = dtWorkcell;
            ddlWorkcellS.DataBind();
            ddlWorkcellS.Items.Insert(0, li);

            ddlStationS.Items.Insert(0, li);

            txtDocNumber.Text = "";
            txtDocRev.Text = "";

            ceCerDateFrom.SelectedDate = null;
            ceCerDateTo.SelectedDate = null;

            btnSaveDocument.Visible = false;

            lblSearchEmployeeMsg.Text = "";

            HideBothGrids();
        }
        protected void HideSearchEmployeeGrid()
        {
            grvSearchEmployee.Visible = false;
            panelMapError.Visible = false;
            btnSaveDocument.Visible = false;
            Session["grvTrainingRecord_SelectedRows"] = null;
            Session["TRDocumentMappingSort"] = null;
        }
        protected void ddlTrainingGroupS_SelectedIndexChanged(object sender, EventArgs e)
        {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);

            DataTable dtCourseGroup;
            using (HRTR.Server.CR_TrainingGroup tg = new HRTR.Server.CR_TrainingGroup())
            {
                tg.TrainingGroupID = itraininggroupid;
                dtCourseGroup = tg.GetCourseGroupByTrainingGroup();
            }
            //CoursrGroup
            ddlCourseGroupS.Items.Clear();
            ddlCourseGroupS.DataSource = dtCourseGroup;
            ddlCourseGroupS.DataBind();
            ddlCourseGroupS.Items.Insert(0, new ListItem("[Please Select]", "0"));

            ddlCourseS.Items.Clear();
            ddlCourseS.Items.Insert(0, new ListItem("[Please Select]", "0"));

            HideBothGrids();
        }
        protected void ddlCourseGroupS_SelectedIndexChanged(object sender, EventArgs e)
        {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);

            int icoursegroupid = Convert.ToInt32(ddlCourseGroupS.SelectedValue);

            DataTable dtCourse = HRTR.Server.CR_Course.Search(string.Empty, icoursegroupid, itraininggroupid);
            ddlCourseS.Items.Clear();
            ddlCourseS.DataSource = dtCourse;
            ddlCourseS.DataBind();
            ddlCourseS.Items.Insert(0, new ListItem("[Please Select]", "0"));

            HideBothGrids();
        }
        protected void HideBothGrids()
        {
            HideSearchEmployeeGrid();
            HideSearchMapGrid();
        }
        protected void ddlCourseS_SelectedIndexChanged(object sender, EventArgs e)
        {
            HideBothGrids();
        }
        protected void ddlWorkcellS_SelectedIndexChanged(object sender, EventArgs e)
        {
            int strworkcellid = Int32.Parse(ddlWorkcellS.SelectedValue.ToString());
            DataTable dtStation = CR_Station.Search("", strworkcellid);
            ddlStationS.Items.Clear();
            ddlStationS.DataSource = dtStation;
            ddlStationS.DataBind();
            ddlStationS.Items.Insert(0, new ListItem("[Please Select]", "0"));
            HideBothGrids();
        }
        protected void ddlStationS_SelectedIndexChanged(object sender, EventArgs e)
        {
            HideBothGrids();
        }
        protected void btnSearchEmployee_Click(object sender, EventArgs e)
        {
            try
            {
                HideSearchMapGrid();
                grvSearchEmployee.Visible = true;
                BindTrainingRecord();
                if (grvSearchEmployee.Rows.Count>1)
                {
                    btnSaveDocument.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ShowError(lblSearchEmployeeMsg, ex.Message);
            }
        }
        protected void btnClearS_Click(object sender, EventArgs e)
        {
            ClearSearch();
        }
        #endregion

        #region Employee Search Grid
        private void SaveSelectedRows()
        {
            // Get the selected rows from the session or create a new list if null
            List<int> selectedRows = Session["grvTrainingRecord_SelectedRows"] as List<int>;
            if (selectedRows == null)
                selectedRows = new List<int>();

            // Loop through all rows in the grid
            foreach (GridViewRow row in grvSearchEmployee.Rows)
            {
                // Get the checkbox in the first column
                CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;

                // Get the datakey value for the current row
                int dataKey = Convert.ToInt32(grvSearchEmployee.DataKeys[row.RowIndex].Value);

                // If the checkbox is checked and the datakey is not in the list, add it
                if (cbSelect.Checked && !selectedRows.Contains(dataKey))
                    selectedRows.Add(dataKey);

                // If the checkbox is unchecked and the datakey is in the list, remove it
                if (!cbSelect.Checked && selectedRows.Contains(dataKey))
                    selectedRows.Remove(dataKey);
            }

            // Save the list back to the session
            Session["grvTrainingRecord_SelectedRows"] = selectedRows;
        }

        private void RestoreSelectedRows()
        {
            // Get the selected rows from the session or return if null
            List<int> selectedRows = Session["grvTrainingRecord_SelectedRows"] as List<int>;
            if (selectedRows == null)
                return;

            // Loop through all rows in the grid
            foreach (GridViewRow row in grvSearchEmployee.Rows)
            {
                // Get the checkbox in the first column
                CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;

                // Get the datakey value for the current row
                int dataKey = Convert.ToInt32(grvSearchEmployee.DataKeys[row.RowIndex].Value);

                // If the datakey is in the list, check the checkbox
                if (selectedRows.Contains(dataKey))
                    cbSelect.Checked = true;
            }
        }

        protected void grvTrainingRecord_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SaveSelectedRows();
            grvSearchEmployee.PageIndex = e.NewPageIndex;
            BindTrainingRecord();
            grvSearchEmployee.SelectedIndex = -1;
            RestoreSelectedRows();
        }

        protected void grvTrainingRecord_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                // Find the header checkbox and add a click event handler
                CheckBox chkAll = (CheckBox)e.Row.FindControl("chkAll");
                chkAll.Attributes["onclick"] = "SelectAllCheckboxes(this)";
            }
        }

        protected void grvTrainingRecord_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "TRDocumentMappingSort";
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
            catch {
                //Ignore excepion
            }
            Session[str_ssname] = str_sort;
            BindTrainingRecord(str_sort);
        }

        protected void grvTrainingRecord_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //empty command
        }

        private void BindTrainingRecord(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["TRDocumentMappingSort"] != null)
                    {
                        pstr_sort = Session["TRDocumentMappingSort"].ToString();
                    }
                }
                catch {
                    //ignore exception
                }
            }
            DataTable dtTrainingRecord = TrainingRecordData();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtTrainingRecord.DefaultView.Sort = pstr_sort;
            grvSearchEmployee.DataSource = dtTrainingRecord;
            grvSearchEmployee.DataBind();
        }

        private DataTable TrainingRecordData()
        {
            int istation = Convert.ToInt32(ddlStationS.SelectedValue);
            int icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);
            int iworkcell = Convert.ToInt32(ddlWorkcellS.SelectedValue);
            string docNumber = txtDocNumber.Text.Trim();
            string docRev = txtDocRev.Text.Trim();

            if (docNumber.Length == 0 || docRev.Length == 0)
            {
                ShowError(lblSearchEmployeeMsg, "Document Number/Revision is invalid");
                return null;
            }

            DateTime daCerDateFrom = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Local);
            try
            {
                daCerDateFrom = DateTime.ParseExact(txtCerDateFrom.Text, "MM/dd/yyyy", new CultureInfo("en-US"));
            }
            catch {
                //ignore exception
            }
            DateTime daCerDateTo = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Local);
            try
            {
                daCerDateTo = DateTime.ParseExact(txtCerDateTo.Text, "MM/dd/yyyy", new CultureInfo("en-US"));
            }
            catch {
                //ignore exception
            }

            DataTable dtTrainingRecord = HRTR.Server.TrainingRecord.SearchV2(
                iworkcell,
                istation,
                icourseid,
                docNumber,
                docRev,
                daCerDateFrom,
                daCerDateTo);
            return dtTrainingRecord;
        }

        #endregion

        #region Save New Map
        protected bool ValidateJDoc(string docNumber, string docRev, string stationName, string userName)
        {
            return true; //debug
            var jdocAPI = new JDocApi(ConfigurationManager.AppSettings["JdocClientId"], ConfigurationManager.AppSettings["JdocClientSecret"]);
            var accessToken = Application["JdocAccessToken"];
            var metadata = Application["JdocStationMetadata"];
            try
            {
                if (accessToken is GetTokenResponse && metadata is GetMetadataResponse)
                {
                    if (DateTime.Now < (accessToken as GetTokenResponse).ExpiresAt.AddSeconds(3))
                    {
                        accessToken = null;
                        metadata = null;
                    }
                }
                else
                {
                    accessToken = null;
                    metadata = null;
                }
            }
            catch
            {
                accessToken = null;
                metadata = null;
            }

            if (accessToken == null || metadata == null)
            {
                Application.Lock();
                accessToken = jdocAPI.GetAccessToken(userName);
                metadata = jdocAPI.GetMetadataResponse((accessToken as GetTokenResponse).AccessToken, userName);
                Application["JdocAccessToken"] = accessToken;
                Application["JdocStationMetadata"] = metadata;
                Application.UnLock();
            }

            return jdocAPI.GetDocuments((accessToken as GetTokenResponse).AccessToken, metadata as GetMetadataResponse, docNumber, docRev, stationName, userName);
        }
        protected void btnSaveDocument_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSelectedRows();
                string docNumber = txtDocNumber.Text.Trim();
                string docRev = txtDocRev.Text.Trim();
                int iworkcell = Convert.ToInt32(ddlWorkcellS.SelectedValue);
                int istation = Convert.ToInt32(ddlStationS.SelectedValue);
                string stationName = ddlStationS.SelectedItem.Text;
                int icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);

                DateTime daCerDateFrom;
                try
                {
                    daCerDateFrom = DateTime.ParseExact(txtCerDateFrom.Text, "MM/dd/yyyy", new CultureInfo("en-US"));
                }
                catch {
                    daCerDateFrom = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Local);
                }
                DateTime daCerDateTo;
                try
                {
                    daCerDateTo = DateTime.ParseExact(txtCerDateTo.Text, "MM/dd/yyyy", new CultureInfo("en-US"));
                }
                catch {
                    daCerDateTo = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Local);
                }

                try
                {
                    var validJdoc = ValidateJDoc(docNumber, docRev, stationName, Page.User.Identity.Name);
                    if (!validJdoc)
                    {
                        ShowError(lblSaveDocumentMsg, "Document number/revision not found in JDOC");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    ShowError(lblSaveDocumentMsg, "JDOC API error: " + ex.Message);
                    return;
                }

                List<int> selectedRows = Session["grvTrainingRecord_SelectedRows"] as List<int>;
                if (selectedRows == null || selectedRows.Count==0)
                {
                    ShowError(lblSaveDocumentMsg, "Please select records to continue");
                    return;
                }

                if (docNumber.Length==0 || docRev.Length==0)
                {
                    ShowError(lblSaveDocumentMsg, "Document Number/Revision is invalid");
                    return;
                }

                if (daCerDateFrom>daCerDateTo)
                {
                    ShowError(lblSaveDocumentMsg, "Certified date is invalid");
                    return;
                }

                var dt = HRTR.Server.TrainingRecord.SaveDocumentMap(selectedRows.ToArray(), istation, iworkcell, icourseid,
                                                                        daCerDateFrom, daCerDateTo, docNumber, docRev, (int)Session["UserProfileID"]);

                string result = string.Format("{0}/{1} records mapped succesfully", selectedRows.Count - dt.Rows.Count, selectedRows.Count);
                ShowError(lblSaveDocumentMsg, result);

                if (dt.Rows.Count>0)
                {
                    panelMapError.Visible = true;
                    Session["MapDocumentErrorDataTable"] = dt;
                    BindDocumentMapError();
                }
                else
                {
                    panelMapError.Visible = false;
                    grvMapDocumentError.DataSource = null;
                }

                BindTrainingRecord();
            }
            catch (Exception ex)
            {
                ShowError(lblSaveDocumentMsg, ex.Message);
            }
        }

        protected void btnSaveAll_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSelectedRows();
                string docNumber = txtDocNumber.Text.Trim();
                string docRev = txtDocRev.Text.Trim();
                int iworkcell = Convert.ToInt32(ddlWorkcellS.SelectedValue);
                int istation = Convert.ToInt32(ddlStationS.SelectedValue);
                string stationName = ddlStationS.SelectedItem.Text;
                int icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);

                DateTime daCerDateFrom;
                try
                {
                    daCerDateFrom = DateTime.ParseExact(txtCerDateFrom.Text, "MM/dd/yyyy", new CultureInfo("en-US"));
                }
                catch
                {
                    daCerDateFrom = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Local);
                }
                DateTime daCerDateTo;
                try
                {
                    daCerDateTo = DateTime.ParseExact(txtCerDateTo.Text, "MM/dd/yyyy", new CultureInfo("en-US"));
                }
                catch
                {
                    daCerDateTo = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Local);
                }

                try
                {
                    var validJdoc = ValidateJDoc(docNumber, docRev, stationName, Page.User.Identity.Name);
                    if (!validJdoc)
                    {
                        ShowError(lblSaveDocumentMsg, "Document number/revision not found in JDOC");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    ShowError(lblSaveDocumentMsg, "JDOC API error: " + ex.Message);
                    return;
                }

                if (docNumber.Length == 0 || docRev.Length == 0)
                {
                    ShowError(lblSaveDocumentMsg, "Document Number/Revision is invalid");
                    return;
                }

                if (daCerDateFrom > daCerDateTo)
                {
                    ShowError(lblSaveDocumentMsg, "Certified date is invalid");
                    return;
                }

                var dt = HRTR.Server.TrainingRecord.SaveAllDocumentMap(istation, iworkcell, icourseid,
                                                                        daCerDateFrom, daCerDateTo, docNumber, docRev, (int)Session["UserProfileID"]);

                if (dt.Rows.Count > 0)
                {
                    string result = string.Format("{0} records failed to map", dt.Rows.Count);
                    ShowError(lblSaveDocumentMsg, result);
                }
                else
                {
                    ShowMessage(lblSaveDocumentMsg, "Updated successfully");
                }
                

                if (dt.Rows.Count > 0)
                {
                    panelMapError.Visible = true;
                    Session["MapDocumentErrorDataTable"] = dt;
                    BindDocumentMapError();
                }
                else
                {
                    panelMapError.Visible = false;
                    grvMapDocumentError.DataSource = null;
                }

                BindTrainingRecord();
            }
            catch (Exception ex)
            {
                ShowError(lblSaveDocumentMsg, ex.Message);
            }
        }

        protected void btnUpdateDocumentMap_Click(object sender, EventArgs e)
        {
            string docNumber = txtUpdateDocNumber.Text.Trim();
            string docRev = txtUpdateDocRevision.Text.Trim();
            int empDocID = int.Parse(hdUpdateEmpDocID.Value);
            string stationName = txtStationName.Text.Trim();

            if (docNumber.Length<1)
            {
                ShowError(lblUpdateDocMapMsg, "Please enter valid document number");
            }
            else if (docRev.Length<1)
            {
                ShowError(lblUpdateDocMapMsg, "Please enter valid document revision");
            }
            else if (empDocID == 0)
            {
                ShowError(lblUpdateDocMapMsg, "Please select valid record");
            }

            try
            {
                var validJdoc = ValidateJDoc(docNumber, docRev, stationName, Page.User.Identity.Name);
                if (!validJdoc)
                {
                    ShowError(lblSearchEmployeeMsg, "Document number/revision not found in JDOC");
                    return;
                }

                HRTR.Server.TrainingRecord.UpdateSingDocumentMap(empDocID, docNumber, docRev, (int)Session["UserProfileID"]);
                BindSearchDocumentMap();
                ShowMessage(lblSearchEmployeeMsg, "Updated successfully");
            }
            catch (Exception ex)
            {
                ShowError(lblSearchEmployeeMsg, ex.Message);
            }
        }

        #endregion

        #region Grid Map Document Error

        protected void grvMapDocumentError_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvMapDocumentError.PageIndex = e.NewPageIndex;
            BindDocumentMapError();
            grvMapDocumentError.SelectedIndex = -1;
        }

        protected void grvMapDocumentError_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //nothing to do
        }

        protected void grvMapDocumentError_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "MapDocumentErrorSort";
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
            catch {
                //ignore exception
            }
            Session[str_ssname] = str_sort;
            BindDocumentMapError(str_sort);
        }

        protected void grvMapDocumentError_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //nothing to do
        }

        private void BindDocumentMapError(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["MapDocumentErrorSort"] != null)
                    {
                        pstr_sort = Session["MapDocumentErrorSort"].ToString();
                    }
                }
                catch {
                    //ignore exception
                }
            }
            DataTable dt = (DataTable)Session["MapDocumentErrorDataTable"];
            if (!string.IsNullOrEmpty(pstr_sort))
                dt.DefaultView.Sort = pstr_sort;
            grvMapDocumentError.DataSource = dt;
            grvMapDocumentError.DataBind();
        }

        #endregion

        #region Search Document Map Events

        protected void HideSearchMapGrid()
        {
            grvSearchDocumentMap.Visible = false;
            panelUnmapButtons.Visible = false;
            Session["grvSearchDocumentMap_SelectedRows"] = null;
            Session["SearchDocumentMapSort"] = null;
        }

        protected void btnSearchMap_Click(object sender, EventArgs e)
        {
            try
            {
                HideSearchEmployeeGrid();
                BindSearchDocumentMap();
            }
            catch (Exception ex)
            {
                ShowError(lblSearchEmployeeMsg, ex.Message);
            }
        }

        protected void btnUnMap_Click(object sender, EventArgs e)
        {
            try
            {
                SearchMap_SaveSelectedRows();
                List<int> selectedRows = Session["grvSearchDocumentMap_SelectedRows"] as List<int>;
                if (selectedRows == null || selectedRows.Count == 0)
                {
                    ShowError(lblUnmapExportMsg, "Please select records to continue");
                    return;
                }
                HRTR.Server.TrainingRecord.DeleteDocumentMap(selectedRows.ToArray(), (int)Session["UserProfileID"]);
                BindSearchDocumentMap();
            }
            catch (Exception ex)
            {
                ShowError(lblUnmapExportMsg, ex.Message);
            }
        }

        protected void btnDeleteAllDocumentMap_Click(object sender, EventArgs e)
        {
            try
            {
                SearchMap_SaveSelectedRows();
                string docNumber = txtDocNumber.Text.Trim();
                string docRev = txtDocRev.Text.Trim();
                int iworkcell = Convert.ToInt32(ddlWorkcellS.SelectedValue);
                int istation = Convert.ToInt32(ddlStationS.SelectedValue);
                int icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);
                int icgid = Convert.ToInt32(ddlCourseGroupS.SelectedValue);
                int itgid = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);

                HRTR.Server.TrainingRecord.DeleteAllDocumentMap(istation, iworkcell, icourseid, itgid, icgid, docNumber, docRev, (int)Session["UserProfileID"]);
                BindSearchDocumentMap();
            }
            catch (Exception ex)
            {
                ShowError(lblUnmapExportMsg, ex.Message);
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = DocumentMapData();
                string strdesfile = string.Format(@"{0}\EmployeeDocument_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , String.Format("{0:MMddyyyyHHmmss}", DateTime.Now));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[1] { "EmployeeID_ID" };

                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                string strExcelSheetName = "Employee Documents";
                OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, strExcelSheetName);
                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptEmployeeDocument", strscript, false);
            }
            catch (Exception ex)
            {
                ShowError(lblUnmapExportMsg, ex.Message);
            }
        }

        #endregion

        #region Search Document Map Grid

        private void SearchMap_SaveSelectedRows()
        {
            // Get the selected rows from the session or create a new list if null
            List<int> selectedRows = Session["grvSearchDocumentMap_SelectedRows"] as List<int>;
            if (selectedRows == null)
                selectedRows = new List<int>();

            // Loop through all rows in the grid
            foreach (GridViewRow row in grvSearchDocumentMap.Rows)
            {
                // Get the checkbox in the first column
                CheckBox cbSelect = row.FindControl("cbSMSelect") as CheckBox;

                // Get the datakey value for the current row
                int dataKey = Convert.ToInt32(grvSearchDocumentMap.DataKeys[row.RowIndex].Value);

                // If the checkbox is checked and the datakey is not in the list, add it
                if (cbSelect.Checked && !selectedRows.Contains(dataKey))
                    selectedRows.Add(dataKey);

                // If the checkbox is unchecked and the datakey is in the list, remove it
                if (!cbSelect.Checked && selectedRows.Contains(dataKey))
                    selectedRows.Remove(dataKey);
            }

            // Save the list back to the session
            Session["grvSearchDocumentMap_SelectedRows"] = selectedRows;
        }

        private void SearchMap_RestoreSelectedRows()
        {
            // Get the selected rows from the session or return if null
            List<int> selectedRows = Session["grvSearchDocumentMap_SelectedRows"] as List<int>;
            if (selectedRows == null)
                return;

            // Loop through all rows in the grid
            foreach (GridViewRow row in grvSearchDocumentMap.Rows)
            {
                // Get the checkbox in the first column
                CheckBox cbSelect = row.FindControl("cbSMSelect") as CheckBox;

                // Get the datakey value for the current row
                int dataKey = Convert.ToInt32(grvSearchDocumentMap.DataKeys[row.RowIndex].Value);

                // If the datakey is in the list, check the checkbox
                if (selectedRows.Contains(dataKey))
                    cbSelect.Checked = true;
            }
        }

        protected void grvSearchDocumentMap_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SearchMap_SaveSelectedRows();
            grvSearchDocumentMap.PageIndex = e.NewPageIndex;
            BindSearchDocumentMap();
            grvSearchDocumentMap.SelectedIndex = -1;
            SearchMap_RestoreSelectedRows();
        }

        protected void grvSearchDocumentMap_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                // Find the header checkbox and add a click event handler
                CheckBox chkAll = (CheckBox)e.Row.FindControl("chkSMAll");
                chkAll.Attributes["onclick"] = "SelectSearchMapAllCheckboxes(this)";
            }
        }

        protected void grvSearchDocumentMap_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "SearchDocumentMapSort";
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
            catch {
                //ignore exception
            }
            Session[str_ssname] = str_sort;
            BindSearchDocumentMap(str_sort);
        }

        protected void grvSearchDocumentMap_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateDocMap")
            {
                try
                {
                    lblSearchEmployeeMsg.Text = "";
                    int empDocID = Convert.ToInt32(e.CommandArgument);
                    var dt = HRTR.Server.TrainingRecord.SelectDocumentMap(empDocID);
                    txtEmployeeID.Text = dt.Rows[0].Field<string>("EmployeeID");
                    txtEmployeeName.Text = dt.Rows[0].Field<string>("EmployeeName");
                    txtCourseName.Text = dt.Rows[0].Field<string>("CourseName");
                    txtCourseGroupName.Text = dt.Rows[0].Field<string>("CourseGroupName");
                    txtTrainingGroupName.Text = dt.Rows[0].Field<string>("TrainingGroupName");
                    txtWorkcellName.Text = dt.Rows[0].Field<string>("WorkcellName");
                    txtStationName.Text = dt.Rows[0].Field<string>("StationName");
                    txtUpdateDocNumber.Text = dt.Rows[0].Field<string>("DocumentNumber");
                    txtUpdateDocRevision.Text = dt.Rows[0].Field<string>("Revision");
                    hdUpdateEmpDocID.Value = empDocID.ToString();
                    mpeUpdateDocumentMap.Show();
                }
                catch (Exception ex)
                {
                    lblSearchEmployeeMsg.Text = ex.Message;
                }
            }
        }

        private void BindSearchDocumentMap(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                try
                {
                    if (Session["SearchDocumentMapSort"] != null)
                    {
                        pstr_sort = Session["SearchDocumentMapSort"].ToString();
                    }
                }
                catch {
                    //ignore exception
                }
            }
            DataTable dt = DocumentMapData();
            if (!string.IsNullOrEmpty(pstr_sort))
                dt.DefaultView.Sort = pstr_sort;
            grvSearchDocumentMap.Visible = true;
            grvSearchDocumentMap.DataSource = dt;
            grvSearchDocumentMap.DataBind();

            if (dt.Rows.Count>0)
            {
                panelUnmapButtons.Visible = true;
            }
            else
            {
                panelUnmapButtons.Visible = false;
            }
        }

        private DataTable DocumentMapData()
        {
            string docNumber = txtDocNumber.Text.Trim();
            string docRev = txtDocRev.Text.Trim();
            int iworkcell = Convert.ToInt32(ddlWorkcellS.SelectedValue);
            int istation = Convert.ToInt32(ddlStationS.SelectedValue);
            int icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);
            int icgid = Convert.ToInt32(ddlCourseGroupS.SelectedValue);
            int itgid = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);

            var dt = HRTR.Server.TrainingRecord.SearchDocumentMap(istation, iworkcell, icourseid, itgid, icgid, docNumber, docRev);
            return dt;
        }

        #endregion
    }
}