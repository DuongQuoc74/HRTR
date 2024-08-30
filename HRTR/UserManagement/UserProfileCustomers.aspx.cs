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
using SystemAuth;
using HRTR.Server;
using System.Collections.Generic;

namespace SystemAuth.UserManagement
{
    public partial class UserProfileCustomers : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                DataTable dtCustomers = CR_Customers.Search();

                ddlCustomersR.DataSource = dtCustomers;
                ddlCustomersR.DataBind();

                ddlCustomersA.DataSource = dtCustomers;
                ddlCustomersA.DataBind();

                //Code 11: Department, refer to MDType table
                DataTable dtDepartment = SY_Department.Search();
                //Department
                ddlDepartmentS.DataSource = dtDepartment;
                ddlDepartmentS.DataBind();

                ListItem li = new ListItem("[All]", "0");
                ddlDepartmentS.Items.Insert(0, li);

                //Department
                ddlDepartmentA.DataSource = dtDepartment;
                ddlDepartmentA.DataBind();

                ddlDepartmentA.Items.Insert(0, li);

                BindDataR();

            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindDataR();
        }
        protected void grvUserListR_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvUserListR.PageIndex = e.NewPageIndex;
            BindDataR();
        }
        protected void grvUserListR_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string strrolename = ddlCustomersR.SelectedItem.ToString();
                string strUserProfileID = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UserProfileID"));
                string strusername = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UserName"));

                HyperLink hlRemove = (HyperLink)e.Row.FindControl("hlRemove");
                if (hlRemove != null)
                    hlRemove.NavigateUrl = "javascript:RemoveUserFromRole('" + strUserProfileID + "','" + strusername + "','" + strrolename + "')";
            }
        }
        protected void grvUserListR_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "UserListSortR";
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
            BindDataR(str_sort);
        }

        private void BindDataR(string pstr_sort = "")
        {

            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["UserListSortR"] != null)
                {
                    pstr_sort = Session["UserListSortR"].ToString();
                }
            }

            DataTable dtUserProfile = SearchCustomerProfile();
            if (!string.IsNullOrEmpty(pstr_sort))
                dtUserProfile.DefaultView.Sort = pstr_sort;
            grvUserListR.DataSource = dtUserProfile;
            grvUserListR.DataBind();
            grvUserListR.SelectedIndex = -1;
        }

        private DataTable SearchCustomerProfile()
        {
            string strusername = txtUserNameS.Text.Trim();
            string stremployeeid = txtEmployeeIDS.Text.Trim();
            string strfullname = txtFullNameS.Text.Trim();
            string stremail = txtEmailS.Text.Trim();
            int idepartmentid = Convert.ToInt32(ddlDepartmentS.SelectedValue);
            string strcontactno = txtContactNoS.Text.Trim();
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);
            int icustomer_id = Convert.ToInt32(ddlCustomersR.SelectedValue);

           return SC_UserProfile.Search(strusername
                , stremployeeid
                , strfullname
                , stremail
                , idepartmentid
                , strcontactno
                , iisactive
                , 0
                , icustomer_id);
        }

        protected void grvUserListR_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void btnOKRemove_Click(object sender, EventArgs e)
        {
            try
            {
                using (SC_UserProfile us = new SC_UserProfile())
                {
                    us.UserProfileID = Convert.ToInt32(hdUserProfileIDR.Value);
                    int icustomer_id = Convert.ToInt32(ddlCustomersR.SelectedValue);
                    us.RemoveUserProfileFromCustomer(icustomer_id);
                }
                BindDataR();
                ShowMessage(lblSearch, "Removed successfully.");
                //lblMessage.Text = "Remove successfully.";
            }
            catch (Exception ex)
            {
                //lblMessage.Text = ex.Message;
                ShowError(lblSearch, ex.Message);

            }
            //btnMessage.Focus();
            //mpeMessage.Show();
        }

        protected void btnOKAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (SC_UserProfile us = new SC_UserProfile())
                {
                    us.UserProfileID = Convert.ToInt32(hdUserProfileIDA.Value);
                    int icustomer_id = Convert.ToInt32(ddlCustomersA.SelectedValue);
                    us.AddUserProfileToCustomer(icustomer_id);
                }
                BindDataR();
                //lblMessage.Text = "Add successfully.";
                ShowMessage(lblAdd, "Added successfully.");
            }
            catch (Exception ex)
            {
                //lblMessage.Text = ex.Message;
                ShowError(lblAdd, ex.Message);

            }
            //btnMessage.Focus();
            //mpeMessage.Show();

        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = SearchCustomerProfile();

               
                string strdesfile = string.Format(@"{0}\CustomerProfile_{1}.xlsx"
                   , HRTRConfig.GetExportsFolder
                   , DateTime.Now.ToString("MMddyyyyHHmmss"));
                string strdesfilefullpath = MapPath(strdesfile);
                string[] astrHideColumns = new string[2] { "UserProfileID", "DepartmentID" };

                Dictionary<string, string> dicRenameColumns = new Dictionary<string, string> {
                    { "UserName", "User Name" },
                    { "FullName", "Full Name" },
                    { "ContactNo", "Contact" },
                    { "DepartmentName", "Department" } 
                };

                eUtilities.OpenXMLExportToExcel.CreateExcelDocument(dt, strdesfilefullpath, astrHideColumns, dicRenameColumns, "CustomerProfile");

                string stropenfile = PathMap(strdesfile);
                string strscript = "<script language='javascript'></script>";
                strscript += "<script>";
                strscript += "window.open('" + stropenfile + "', '_blank');";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strscriptCourse", strscript, false);
            }
            catch (Exception ex)
            {
                ShowError(lblSearch, ex.Message);
            }
        }
    }
}