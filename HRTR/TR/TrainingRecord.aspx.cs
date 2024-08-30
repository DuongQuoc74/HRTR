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
using HRTR.Server;

public partial class HRTR_TrainingRecord : System.Web.UI.Page
{
    #region Variables

    static DataTable dtCertifiedLevel = new DataTable();

    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dtCertifiedLevel = CertifiedLevel.Search();

            DataTable dtTrainingGroup = TrainingGroup.Search();
            //TrainingGroup
            ddlTrainingGroup.DataSource = dtTrainingGroup;
            ddlTrainingGroup.DataBind();
            ddlTrainingGroup.Items.Insert(0, new ListItem("[Please Select]", "0"));

            Session["TrainingRecordSort"] = "";
            btnSave.Visible = false;

        }
        BindFilterData();
        ddlTrainingGroup.Attributes.Add("onChange", "trainingGroupChange();");
        ddlCourseGroup.Attributes.Add("onChange", "courseGroupChange();");
        ddlProduct.Attributes.Add("onChange", "productChange();");

    }
    private void BindFilterData()
    {
        TrainingGroup tg = new TrainingGroup();
        tg.TrainingGroupID = Convert.ToInt32(ddlTrainingGroup.SelectedValue);

        DataTable dtCourseGroup = tg.GetCourseGroupByTrainingGroup();
        //CoursrGroup
        ddlCourseGroup.Items.Clear();
        ddlCourseGroup.DataSource = dtCourseGroup;
        ddlCourseGroup.DataBind();
        try
        {
            ddlCourseGroup.SelectedValue = hdCourseGroupID.Value;
        }
        catch
        {
        }


        DataTable dtProduct = tg.GetProductByTrainingGroup();
        //CoursrGroup
        ddlProduct.Items.Clear();
        ddlProduct.DataSource = dtProduct;
        ddlProduct.DataBind();
        try
        {
            ddlProduct.SelectedValue = hdProductID.Value;
        }
        catch
        {
        }

    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        BindTrainingRecord();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strmess = "Save successfully.";
        bool flag = true;
        foreach (GridViewRow row in grvTrainingRecord.Rows)
        {

            try
            {
                using (TrainingRecord trc = new TrainingRecord())
                {
                    int itrainingrecordid = 0;
                    try
                    {
                        itrainingrecordid = Convert.ToInt32(grvTrainingRecord.DataKeys[row.RowIndex]["TrainingRecordID"].ToString());
                    }
                    catch
                    {
                    }

                    trc.TrainingRecordID = itrainingrecordid;
                    //trc.EmployeeID = txtEmployeeID.Text.Trim();
                    trc.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);
                    trc.ProductID = Convert.ToInt32(hdProductID.Value);
                    int icourseid = 0;
                    try
                    {
                        icourseid = Convert.ToInt32(grvTrainingRecord.DataKeys[row.RowIndex]["CourseID"].ToString());
                    }
                    catch
                    {
                    }
                    trc.CourseID = icourseid;

                    DateTime daCertDate = new DateTime(1900, 1, 1);
                    try
                    {
                        TextBox txtCertDate = (TextBox)row.FindControl("txtCertDate");
                        daCertDate = DateTime.ParseExact(txtCertDate.Text, "MM/dd/yyyy", null);
                    }
                    catch
                    {
                    }
                    try
                    {
                        CheckBox chkOJT = (CheckBox)row.FindControl("chkOJT");
                        trc.OJT = chkOJT.Checked;
                    }
                    catch
                    {
                        trc.OJT = false;
                    }

                    if (itrainingrecordid == 0 && daCertDate.Year == 1900 && trc.OJT == false)
                    {
                        ///Continue;
                    }
                    else if (itrainingrecordid != 0 && daCertDate.Year == 1900 && trc.OJT == false)
                    {
                        trc.Delete();
                    }
                    else
                    {
                        trc.CertDate = daCertDate;
                        TextBox txtScore = (TextBox)row.FindControl("txtScore");
                        try
                        {
                            trc.Score = Convert.ToDecimal(txtScore.Text);
                        }
                        catch
                        {
                            trc.Score = 0;
                        }

                        DateTime daExpDate = new DateTime(1900, 1, 1);
                        try
                        {
                            TextBox txtExpDate = (TextBox)row.FindControl("txtExpDate");
                            daExpDate = DateTime.ParseExact(txtExpDate.Text, "MM/dd/yyyy", null);
                        }
                        catch
                        {
                        }
                        trc.ExpDate = daExpDate;
                        DropDownList ddlCertifiedLevel = (DropDownList)row.FindControl("ddlCertifiedLevel");
                        trc.CertifiedLevelID = Convert.ToInt32(ddlCertifiedLevel.SelectedItem.Value);

                        TextBox txtTrainer = (TextBox)row.FindControl("txtTrainer");
                        trc.Trainer = txtTrainer.Text;

                        trc.Save();
                    }
                }

            }
            catch (Exception ex)
            {
                flag = false;
                strmess = ex.Message;
            }
        }

        if (flag == false)
        {
            lblMessage.Text = strmess;
            mpeMessage.Show();
        }
        else
        {
            BindTrainingRecord();
            lblMessage.Text = strmess;
            btnMessage.Focus();
            mpeMessage.Show();
        }


    }
    protected void grvTrainingRecord_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //DropDownList ddlCertifiedLevel = (DropDownList)(grvTrainingRecord.Rows[gr.RowIndex].Cells[1].FindControl("ddlCertifiedLevel"));
            DropDownList ddlCertifiedLevel = (DropDownList)e.Row.FindControl("ddlCertifiedLevel");
            ddlCertifiedLevel.DataSource = dtCertifiedLevel;
            ddlCertifiedLevel.DataBind();
            //int index = 0;
            //string s = ((DataTable)grvTrainingRecord.DataSource).Rows[gr.RowIndex][11].ToString(); // 11: CertLevel
            string strcertifiedlevelid = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CertifiedLevelID"));
            //if (!string.IsNullOrEmpty(s))
            //{
            //    index = Convert.ToInt32(s);
            //}
            ddlCertifiedLevel.SelectedValue = strcertifiedlevelid;
        }
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
        catch
        {
        }
        Session[str_ssname] = str_sort;
        BindTrainingRecord(str_sort);
    }
    protected void grvTrainingRecord_RowCommand(object sender, GridViewCommandEventArgs e)
    {

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
            HR_Employee emp = new HR_Employee();
            //emp.EmployeeID = txtEmployeeID.Text;
            emp.EmployeeID_ID = Convert.ToInt32(hdEmployeeID_ID.Value);

            int i_traininggroupid = 0;
            try
            {
                i_traininggroupid = Convert.ToInt32(ddlTrainingGroup.SelectedValue);
            }
            catch
            {

            }
            if (i_traininggroupid == 0)
            {
                throw new Exception("Please select training group.");
            }
            int i_coursegroupid = 0;
            try
            {
                i_coursegroupid = Convert.ToInt32(hdCourseGroupID.Value);
            }
            catch
            {

            }
            if (i_coursegroupid == 0)
            {
                throw new Exception("Please select course group or setup course for selected training group.");
            }
            int i_productid = 0;
            try
            {
                i_productid = Convert.ToInt32(hdProductID.Value);
            }
            catch
            {

            }
            if (i_productid == 0)
            {
                throw new Exception("Please select product or setup product for selected training group.");
            }

            DataTable dtTrainingRecord = emp.TrainingRecordByCourseGroup(i_traininggroupid, i_coursegroupid, i_productid);
            if (string.IsNullOrEmpty(pstr_sort))
                dtTrainingRecord.DefaultView.Sort = pstr_sort;
            grvTrainingRecord.DataSource = dtTrainingRecord;
            grvTrainingRecord.DataBind();
            if (dtTrainingRecord.Rows.Count > 0)
            {
                btnSave.Visible = true;
            }
            else
            {
                btnSave.Visible = false;
                throw new Exception("There's no course.");
            }
            //
            //DataTable dtCertifiedLevel = CertifiedLevel.Search();
            //dt.Columns.Add("CertifiedLevelID");
            //dt.Columns.Add("CertifiedLevelName");
            ////1 (Trained), 2 (Certified), 3 (Trainer)
            //dt.Rows.Add("0", "[Please Select]");
            //dt.Rows.Add("1", "Trained");
            //dt.Rows.Add("2", "Certified");
            //dt.Rows.Add("3", "Trainer");
            //dt.AcceptChanges();

            //DropDownList ddlCertifiedLevel;

            //foreach (GridViewRow gr in grvTrainingRecord.Rows)
            //{
            //    DropDownList ddlCertifiedLevel = (DropDownList)(grvTrainingRecord.Rows[gr.RowIndex].Cells[1].FindControl("ddlCertifiedLevel"));

            //    ddlCertifiedLevel.DataSource = dtCertifiedLevel;
            //    ddlCertifiedLevel.DataBind();
            //    //int index = 0;
            //    string s = ((DataTable)grvTrainingRecord.DataSource).Rows[gr.RowIndex][11].ToString(); // 11: CertLevel
            //    //if (!string.IsNullOrEmpty(s))
            //    //{
            //    //    index = Convert.ToInt32(s);
            //    //}
            //    ddlCertifiedLevel.SelectedValue = "";
            //}
        }
        catch (Exception ex)
        {
            //DataTable dtTrainingRecord = new DataTable();
            //grvTrainingRecord.DataSource = dtTrainingRecord;
            //grvTrainingRecord.DataBind();
            //btnSave.Visible = false;
            lblMessage.Text = ex.Message;
            btnMessage.Focus();
            mpeMessage.Show();
        }

    }
}
