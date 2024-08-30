using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using HRTR.Server;

namespace HRTR.TR
{
    public partial class CourseStation : HCM.BasePage.BasePage
    {
        #region Page Events
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                DataTable dtTrainingGroup = HRTR.Server.CR_TrainingGroup.Search(1);
                //TrainingGroup
                ddlTrainingGroupS.DataSource = dtTrainingGroup;
                ddlTrainingGroupS.DataBind();
                ListItem li = new ListItem("[Please Select]", "0");
                ddlTrainingGroupS.Items.Insert(0, li);

                //TrainingGroup
                ddlTrainingGroup.DataSource = dtTrainingGroup;
                ddlTrainingGroup.DataBind();
                ddlTrainingGroup.Items.Insert(0, li);

                ddlCourseGroupS.Items.Insert(0, li);
                ddlCourseGroup.Items.Insert(0, li);

                ddlCourseS.Items.Insert(0, li);
                ddlCourse.Items.Insert(0, li);

                //Workcell
                DataTable dtWorkcell = CR_Workcell.Search();
                ddlWorkcellS.DataSource = dtWorkcell;
                ddlWorkcellS.DataBind();
                ddlWorkcellS.Items.Insert(0, li);

                //ddlWorkcell.DataSource = dtWorkcell;
                //ddlWorkcell.DataBind();
                ////ddlWorkcell.Items.Insert(0, li);

                ddlStation.DataSource = CR_Station.Search("", 0);
                ddlStation.DataBind();
            }
        }
        #endregion Page Events

        #region Export
        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                int icourseid = 0;
                try
                {
                    icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);
                }
                catch
                {
                }

                DataTable dt = HRTR.Server.CR_CourseStation.Search(icourseid);
                //DataTable dt = HRTR.Server.CR_CourseStation.Search();

                //string strtempfolder = HRTRConfig.GetExportsFolder;
                string strdesfile = string.Format(@"{0}\CourseStation_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[4] { "CourseStationID", "CourseID", "CourseGroupID", "TrainingGroupID" };
                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string>();
                dicRenameColumns.Add("CourseName", "Course Name");
                dicRenameColumns.Add("CourseGroupName", "Course Group");
                dicRenameColumns.Add("TrainingGroupName", "Training Group");
                dicRenameColumns.Add("IsActive", "Active");
                dicRenameColumns.Add("WorkcellName", "Workcell");
                dicRenameColumns.Add("StationName", "Station");
                dicRenameColumns.Add("LastUpdated", "Last Updated");
                dicRenameColumns.Add("LastUpdatedByUserName", "Last Updated By");

                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "Course Station");
                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptCourseStation", strscript, false);
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }

        }
        #endregion Export

        #region HRTR Selection
        protected void ddlTrainingGroupS_SelectedIndexChanged(object sender, EventArgs e)
        {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);
            ddlTrainingGroup.SelectedValue = ddlTrainingGroupS.SelectedValue;

            DataTable dtCourseGroup = new DataTable();
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

            //CoursrGroup
            ddlCourseGroup.Items.Clear();
            ddlCourseGroup.DataSource = dtCourseGroup;
            ddlCourseGroup.DataBind();
            ddlCourseGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));


            ddlCourseS.Items.Clear();
            ddlCourseS.Items.Insert(0, new ListItem("[Please Select]", "0"));

            ddlCourse.Items.Clear();
            ddlCourse.Items.Insert(0, new ListItem("[Please Select]", "0"));

            grvCourseStationList.Visible = false;
            grvStationList.Visible = false;
        }
        protected void ddlCourseGroupS_SelectedIndexChanged(object sender, EventArgs e)
        {
            int itraininggroupid = Convert.ToInt32(ddlTrainingGroupS.SelectedValue);
            ddlTrainingGroup.SelectedValue = ddlTrainingGroupS.SelectedValue;

            int icoursegroupid = Convert.ToInt32(ddlCourseGroupS.SelectedValue);
            ddlCourseGroup.SelectedValue = ddlCourseGroupS.SelectedValue;

            DataTable dtCourse = HRTR.Server.CR_Course.Search(string.Empty, icoursegroupid, itraininggroupid);
            ddlCourseS.Items.Clear();
            ddlCourseS.DataSource = dtCourse;
            ddlCourseS.DataBind();
            ddlCourseS.Items.Insert(0, new ListItem("[Please Select]", "0"));

            ddlCourse.Items.Clear();
            ddlCourse.DataSource = dtCourse;
            ddlCourse.DataBind();
            ddlCourse.Items.Insert(0, new ListItem("[Please Select]", "0"));

            grvCourseStationList.Visible = false;
            grvStationList.Visible = false;
        }

        protected void ddlCourseS_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnSearchCourse_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void grvCourseStationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvCourseStationList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvCourseStationList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvCourseStationList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "CourseStationListSort";
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
        protected void grvCourseStationList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                int icoursestationid = Convert.ToInt32(e.CommandArgument);
                LoadCourseStation(icoursestationid);
                if (e.CommandName == "Select") /// For editing
                {
                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button";
                    btnDelete.CssClass = "button invisible";
                }
                else /// For deleting
                {

                    btnAdd.CssClass = "button invisible";
                    btnUpdateAsk.CssClass = "button invisible";
                    btnDelete.CssClass = "button";
                }
                mpeCourseStation.Show();
                btnAdd.Focus();
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["CourseStationListSort"] != null)
                {
                    pstr_sort = Session["CourseStationListSort"].ToString();
                }
            }
            int icourseid = 0;
            try
            {
                icourseid = Convert.ToInt32(ddlCourseS.SelectedValue);
            }
            catch
            {
            }

            DataTable dtCourseStation = HRTR.Server.CR_CourseStation.Search(icourseid);
            if (!string.IsNullOrEmpty(pstr_sort))
                dtCourseStation.DefaultView.Sort = pstr_sort;
            grvCourseStationList.DataSource = dtCourseStation;
            grvCourseStationList.DataBind();

            grvCourseStationList.Visible = true;

            ddlCourse.SelectedValue = ddlCourseS.SelectedValue;
        }
        #endregion

        #region Course Station
        private void LoadCourseStation(int pi_coursestationid)
        {
            using (HRTR.Server.CR_CourseStation gc = new HRTR.Server.CR_CourseStation())
            {
                hdCourseStationID.Value = pi_coursestationid.ToString();
                gc.CourseStationID = pi_coursestationid;
                gc.Select();


                ddlStation.SelectedValue = gc.StationID.ToString();
                //cbIsActive.Checked = gc.Active;
                lblCourseStationMessage.Text = "";
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_CourseStation gc = new HRTR.Server.CR_CourseStation())
                {
                    gc.CourseStationID = Convert.ToInt32(hdCourseStationID.Value);
                    gc.Delete();
                }
                BindData();
                ShowMessage(lblSearchStationMessage, "Deleted successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblCourseStationMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeCourseStation.Show();
            }

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_CourseStation gc = new HRTR.Server.CR_CourseStation())
                {
                    gc.CourseID = Convert.ToInt32(ddlCourse.SelectedValue);
                    gc.StationID = Convert.ToInt32(ddlStation.SelectedValue);
                    string strResult = gc.Save();
                    if (strResult != null && strResult != "")
                    {
                        ShowError(lblCourseStationMessage, strResult);
                        btnAdd.CssClass = "button invisible";
                        btnUpdateAsk.CssClass = "button";
                        btnDelete.CssClass = "button invisible";
                        mpeCourseStation.Show();
                    }
                    else
                    {
                        BindData();
                        ShowMessage(lblSearchStationMessage, "Updated successfully.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(lblCourseStationMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeCourseStation.Show();
            }


        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.CR_CourseStation gc = new HRTR.Server.CR_CourseStation())
                {
                    gc.CourseStationID = Convert.ToInt32(hdCourseStationID.Value);
                    gc.CourseID = Convert.ToInt32(ddlCourse.SelectedValue);
                    gc.StationID = Convert.ToInt32(ddlStation.SelectedValue);
                    string strResult =  gc.Save();
                    if(strResult != null && strResult != "")
                    {
                        ShowError(lblCourseStationMessage, strResult);
                        btnAdd.CssClass = "button invisible";
                        btnUpdateAsk.CssClass = "button";
                        btnDelete.CssClass = "button invisible";
                        mpeCourseStation.Show();
                    }
                    else
                    {
                        BindData();
                        ShowMessage(lblSearchStationMessage, "Updated successfully.");
                    }
                }
                
            }
            catch (Exception ex)
            {
                ShowError(lblCourseStationMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeCourseStation.Show();
            }
        }
        #endregion

        #region eDCC Search
        protected void ddlWorkcellS_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDataeDCCStation();
        }
        protected void btnSearchStation_Click(object sender, EventArgs e)
        {
            BindDataeDCCStation();
        }
        private void BindDataeDCCStation(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["eDCCStationListSort"] != null)
                {
                    pstr_sort = Session["eDCCStationListSort"].ToString();
                }
            }
            int strworkcellid = Int32.Parse(ddlWorkcellS.SelectedValue.ToString());
            string strStationName = txtStationNameS.Text.Trim();
            DataTable dtStation = CR_Station.Search(strStationName, strworkcellid);
            if (!string.IsNullOrEmpty(pstr_sort))
                dtStation.DefaultView.Sort = pstr_sort;
            grvStationList.DataSource = dtStation;
            grvStationList.DataBind();
            grvStationList.Visible = true;
        }
        protected void grvStationList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvStationList.PageIndex = e.NewPageIndex;
            BindDataeDCCStation();
        }
        protected void grvStationList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvStationList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "eDCCStationListSort";
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
            BindDataeDCCStation(str_sort);
        }
        protected void grvStationList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Add")
            {
                try
                {
                    int istationid = Convert.ToInt32(e.CommandArgument);
                    ddlStation.SelectedValue = istationid.ToString();
                    lblCourseStationMessage.Text = "";
                    btnAdd.CssClass = "button";
                    btnUpdateAsk.CssClass = "button invisible";
                    btnDelete.CssClass = "button invisible";
                    mpeCourseStation.Show();
                    btnAdd.Focus();
                }
                catch (Exception ex)
                {
                    lblSearchStationMessage.Text = ex.Message;
                }
            }
        }
        #endregion
    }
}