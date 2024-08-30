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
using System.IO;
using eUtilities;

namespace HRTR.TR
{
    public partial class Department : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

                Session["DepartmentListSort"] = "";
                BindData();
            }
            else if (IsAsync)
            {
            }
            else { }
            btnNewDepartment.Focus();
        }
        protected void grvDepartmentList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvDepartmentList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvDepartmentList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvDepartmentList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "DepartmentListSort";
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
        protected void grvDepartmentList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int idepartmentid = Convert.ToInt32(e.CommandArgument);
                    LoadDepartment(idepartmentid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex)
                {
                    ShowError(lblDepartment, ex.Message);
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
                mpeDepartment.Show();

            }
        }
        private void LoadDepartment(int pi_departmentid)
        {
            using (SY_Department us = new SY_Department())
            {
                hdDepartmentID.Value = pi_departmentid.ToString();
                us.DepartmentID = pi_departmentid;
                us.Select();
                txtDepartmentCode.Text = us.DepartmentCode;
                txtDepartmentName.Text = us.DepartmentName;
                lblDepartmentMessage.Text = "";
            }
        }
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["WorkcellListSort"] != null)
                {
                    pstr_sort = Session["WorkcellListSort"].ToString();
                }
            }
            DataTable dtDepartment = HRTR.Server.SY_Department.Search();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtDepartment.DefaultView.Sort = pstr_sort;
            grvDepartmentList.DataSource = dtDepartment;
            grvDepartmentList.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.SY_Department dept = new HRTR.Server.SY_Department())
                {
                    dept.DepartmentID = Convert.ToInt32(hdDepartmentID.Value);
                    dept.DepartmentCode = txtDepartmentCode.Text;
                    dept.DepartmentName = txtDepartmentName.Text;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblDepartment, string.Format("Saved department {0} successfully.", txtDepartmentName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblDepartmentMessage, ex.Message);
                btnAdd.CssClass = "button";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeDepartment.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.SY_Department dept = new HRTR.Server.SY_Department())
                {
                    dept.DepartmentID = Convert.ToInt32(hdDepartmentID.Value);
                    dept.Delete();
                }
                BindData();
                ShowMessage(lblDepartment, string.Format("Deleted department {0} successfully.", txtDepartmentName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblDepartmentMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeDepartment.Show();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (HRTR.Server.SY_Department dept = new HRTR.Server.SY_Department())
                {
                    dept.DepartmentID = Convert.ToInt32(hdDepartmentID.Value);
                    dept.DepartmentCode = txtDepartmentCode.Text;
                    dept.DepartmentName = txtDepartmentName.Text;
                    dept.Save();
                }
                BindData();
                ShowMessage(lblDepartment, string.Format("Updated department {0} successfully.", txtDepartmentName.Text));
            }
            catch (Exception ex)
            {
                ShowError(lblDepartmentMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeDepartment.Show();
            }
        }
    }
}