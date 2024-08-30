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

namespace SystemAuth.UserManagement
{
    public partial class UserProfile : HCM.BasePage.BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                //Code 11: Department, refer to MDType table
                DataTable dtDepartment = SY_Department.Search();
                //Department
                ddlDepartmentS.DataSource = dtDepartment;
                ddlDepartmentS.DataBind();
                ddlDepartmentS.Items.Insert(0, new ListItem("[All]", "0"));

                //Department
                DataView dvDepartment = dtDepartment.DefaultView;
                //dvDepartment.RowFilter = "IsActive = True";
                ddlDepartment.DataSource = dvDepartment;
                ddlDepartment.DataBind();
                ListItem li = new ListItem("[Please Select]", "0");
                ddlDepartment.Items.Insert(0, li);



                DataTable dtPermissionRole = SC_PermissionRole.Search();
                //Role list
                cblUserPermissionRole.DataSource = dtPermissionRole;
                cblUserPermissionRole.DataBind();
                foreach (ListItem lii in cblUserPermissionRole.Items)
                {
                    if (lii.Value == "1")
                        lii.Selected = true;
                    else
                        lii.Selected = false;
                }
                //End role list

                DataTable dtCustomer = CR_Customers.Search();
                //Customer list
                cblUserCustomer.DataSource = dtCustomer;
                cblUserCustomer.DataBind();
                foreach (ListItem lii in cblUserCustomer.Items)
                {
                    //if (lii.Value == "1")
                    //    lii.Selected = true;
                    //else
                        lii.Selected = false;
                }

                BindData();
            }
            else if (IsAsync)
            {
            }
            else
            {
            }
            txtSearchUser.Attributes.Add("onkeyup", "SearchUser(this);");
            btnNewUserProfile.Focus();
        }
        protected void grvUserList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvUserList.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void grvUserList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void grvUserList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string str_ssname = "UserListSort";
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
        protected void grvUserList_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Select" || e.CommandName == "Del")
            {
                try
                {
                    int iuserprofileid = Convert.ToInt32(e.CommandArgument);
                    LoadUserProfile(iuserprofileid);
                    //mpeUserProfile.Show();
                }
                catch (Exception ex)
                {
                    ShowError(lblUserProfile, ex.Message);
                    return;
                }

                //txtUserName.Focus();
                lblSearchUser.CssClass = "invisible";
                txtSearchUser.CssClass = "invisible";
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
                mpeUserProfile.Show();

            }

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        
        private void BindData(string pstr_sort = "")
        {
            if (string.IsNullOrEmpty(pstr_sort))
            {
                if (Session["UserListSort"] != null)
                {
                    pstr_sort = Session["UserListSort"].ToString();
                }
            }
            string strusername = txtUserNameS.Text.Trim();
            string stremployeeid = txtEmployeeIDS.Text.Trim();
            string strfullname = txtFullNameS.Text.Trim();
            string stremail = txtEmailS.Text.Trim();
            int idepartmentid = Convert.ToInt32(ddlDepartmentS.SelectedValue);
            string strcontactno = txtContactNoS.Text.Trim();
            int iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);
            DataTable dtUserProfile = SC_UserProfile.Search(strusername, stremployeeid, strfullname, stremail, idepartmentid, strcontactno, iisactive, 0, 0);
            if(!string.IsNullOrEmpty(pstr_sort))
                dtUserProfile.DefaultView.Sort = pstr_sort;
            grvUserList.DataSource = dtUserProfile;
            grvUserList.DataBind();
            grvUserList.SelectedIndex = -1;
        }
        private void LoadUserProfile(int pi_userprofileid)
        {
            using (SC_UserProfile us = new SC_UserProfile())
            {
                hdUserProfileID.Value = pi_userprofileid.ToString();
                us.UserProfileID = pi_userprofileid;
                us.Select();
                txtUserName.Text = us.UserName;
                txtEmployeeID.Text = us.EmployeeID;
                txtFullName.Text = us.FullName;
                txtEmail.Text = us.Email;
                try
                {
                    ddlDepartment.SelectedValue = us.DepartmentID.ToString();
                }
                catch
                {
                }
                txtContactNo.Text = us.ContactNo;
                cbIsActive.Checked = us.IsActive;

                lblUserProfileMessage.Text = "";

                DataTable dtPermissionRole = us.GetPermissionRoleListByUserProfileID();
                foreach (ListItem li in cblUserPermissionRole.Items)
                {
                    li.Selected = false;
                }
                foreach (DataRow dr in dtPermissionRole.Rows)
                {
                    foreach (ListItem li in cblUserPermissionRole.Items)
                    {
                        if (li.Value == dr["PermissionRoleID"].ToString())
                            li.Selected = true;

                    }
                }

                DataTable dtCustomer = us.GetCustomersListByUserProfileID();
                foreach (ListItem li in cblUserCustomer.Items)
                {
                    li.Selected = false;
                }
                foreach (DataRow dr in dtCustomer.Rows)
                {
                    foreach (ListItem li in cblUserCustomer.Items)
                    {
                        if (li.Value == dr["Customer_ID"].ToString())
                            li.Selected = true;

                    }
                }
            }
        }
        
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string strusername = txtUserName.Text.Trim();
                using (SC_UserProfile us = new SC_UserProfile())
                {
                    us.UserName = strusername;
                    us.EmployeeID = txtEmployeeID.Text.Trim();
                    us.FullName = txtFullName.Text.Trim();
                    us.Email = txtEmail.Text.Trim();
                    us.DepartmentID = Convert.ToInt32(ddlDepartment.SelectedValue);
                    us.ContactNo = txtContactNo.Text.Trim();
                    us.IsActive = cbIsActive.Checked;
                    us.Save();
                    foreach (ListItem li in cblUserPermissionRole.Items)
                    {
                        int ipermissionroleid = Convert.ToInt32(li.Value);
                        if (li.Selected)
                        {
                            us.AddUserProfileToRole(ipermissionroleid);
                        }
                        else
                        {
                            us.RemoveUserProfileFromRole(ipermissionroleid);
                        }
                    }

                    foreach (ListItem li in cblUserCustomer.Items)
                    {
                        int icustomer_id = Convert.ToInt32(li.Value);
                        if (li.Selected)
                        {
                            us.AddUserProfileToCustomer(icustomer_id);
                        }
                        else
                        {
                            us.RemoveUserProfileFromCustomer(icustomer_id);
                        }
                    }
                }
                BindData();

                ShowMessage(lblUserProfile, "Saved user " + strusername + " successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblUserProfileMessage, ex.Message);
                btnAdd.CssClass = "button";
                lblSearchUser.CssClass = "";
                txtSearchUser.CssClass = "";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button invisible";
                mpeUserProfile.Show();
            }


        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string strusername = txtUserName.Text.Trim();
                using (SC_UserProfile us = new SC_UserProfile())
                {
                    us.UserProfileID = Convert.ToInt32(hdUserProfileID.Value);
                    us.UserName = strusername;
                    us.EmployeeID = txtEmployeeID.Text.Trim();
                    us.FullName = txtFullName.Text.Trim();
                    us.Email = txtEmail.Text.Trim();
                    us.DepartmentID = Convert.ToInt32(ddlDepartment.SelectedValue);
                    us.ContactNo = txtContactNo.Text.Trim();
                    us.IsActive = cbIsActive.Checked;
                    us.Save();
                    foreach (ListItem li in cblUserPermissionRole.Items)
                    {
                        int ipermissionroleid = Convert.ToInt32(li.Value);
                        if (li.Selected)
                        {
                            us.AddUserProfileToRole(ipermissionroleid);
                        }
                        else
                        {
                            us.RemoveUserProfileFromRole(ipermissionroleid);
                        }
                    }
                    foreach (ListItem li in cblUserCustomer.Items)
                    {
                        int icustomer_id = Convert.ToInt32(li.Value);
                        if (li.Selected)
                        {
                            us.AddUserProfileToCustomer(icustomer_id);
                        }
                        else
                        {
                            us.RemoveUserProfileFromCustomer(icustomer_id);
                        }
                    }
                }
                BindData();
                ShowMessage(lblUserProfile, "Updated user " + strusername + " successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblUserProfileMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button";
                btnDelete.CssClass = "button invisible";
                mpeUserProfile.Show();
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string strusername = txtUserName.Text.Trim();
                using (SC_UserProfile us = new SC_UserProfile())
                {
                    us.UserProfileID = Convert.ToInt32(hdUserProfileID.Value);
                    us.Delete();
                }
                BindData();
                ShowMessage(lblUserProfile, "Deleted user " + strusername + " successfully.");
            }
            catch (Exception ex)
            {
                ShowError(lblUserProfileMessage, ex.Message);
                btnAdd.CssClass = "button invisible";
                btnUpdateAsk.CssClass = "button invisible";
                btnDelete.CssClass = "button";
                mpeUserProfile.Show();
            }

        }
    }
}