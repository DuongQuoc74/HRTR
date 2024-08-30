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


public partial class HRTR_UserProfilePermissionRole : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
        if (!IsPostBack)
        {


            DataTable dtRoleList = PermissionRole.Search();

            ddlPermissionRoleR.DataSource = dtRoleList;
            ddlPermissionRoleR.DataBind();

            ddlPermissionRoleA.DataSource = dtRoleList;
            ddlPermissionRoleA.DataBind();


            DataTable dtDepartment = SY_Department.Search();
            //Department
            ddlDepartmentS.DataSource = dtDepartment;
            ddlDepartmentS.DataBind();
            
            ListItem li = new ListItem("[Please Select]", "0");
            ddlDepartmentS.Items.Insert(0, li);

            //Department
            ddlDepartmentA.DataSource = dtDepartment;
            ddlDepartmentA.DataBind();

            ddlDepartmentA.Items.Insert(0, li);


            Session["UserListSortR"] = "";
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
            string strrolename = ddlPermissionRoleR.SelectedItem.ToString();
            string struserprofileid = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UserProfileID"));
            string strusername = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UserName"));

            HyperLink hlRemove = (HyperLink)e.Row.FindControl("hlRemove");
            if (hlRemove != null)
                hlRemove.NavigateUrl = "javascript:RemoveUserFromRole('" + struserprofileid + "','" + strusername + "','" + strrolename + "')";
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
 
    //private void BindDataR()
    //{
    //    string strsort = "";
    //    try
    //    {
    //        if (Session["UserListSortR"] != null)
    //        {
    //            strsort = Session["UserListSortR"].ToString();
    //        }

    //    }
    //    catch
    //    {
    //    }
    //    BindDataR(strsort);
    //}
	private void BindDataR(string pstr_sort = "")
	{

        if (string.IsNullOrEmpty(pstr_sort))
        {
            try
            {
                pstr_sort = Session["UserListSortR"].ToString();
            }
            catch
            {
            }
        }
        string strusername = txtUserNameS.Text;
        string stremployeeid = txtEmployeeIDS.Text;
        string strfullname = txtFullNameS.Text;
        string stremail = txtEmailS.Text;
        int idepartmentid = Convert.ToInt32(ddlDepartmentS.SelectedValue);
        string strcontactno = txtContactNoS.Text;
        int iisactive = -1;
        try
        {
            iisactive = Convert.ToInt16(ddlIsActiveS.SelectedValue);
        }
        catch
        {
        }

        int ipermissionroleid = Convert.ToInt32(ddlPermissionRoleR.SelectedValue);

        DataTable dtUserProfile = UserProfile.Search(strusername, stremployeeid, strfullname, stremail, idepartmentid, strcontactno, iisactive, ipermissionroleid);
        if (!string.IsNullOrEmpty(pstr_sort))
            dtUserProfile.DefaultView.Sort = pstr_sort;
        grvUserListR.DataSource = dtUserProfile;
        grvUserListR.DataBind();
	}
	protected void grvUserListR_RowCommand(object sender, GridViewCommandEventArgs e)
	{
		
	}
    protected void btnOKRemove_Click(object sender, EventArgs e)
    {
        try
        {
            UserProfile us = new UserProfile();
            try
            {
                us.UserProfileID = Convert.ToInt32(hdUserProfileIDR.Value);
            }
            catch
            {
            }
            int ipermissionroleid = Convert.ToInt32(ddlPermissionRoleR.SelectedValue);
            us.RemoveUserFromRole(ipermissionroleid);
            BindDataR();
            lblMessage.Text = "Remove successfully.";
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.Message;

        }
        btnMessage.Focus();
        mpeMessage.Show();
    }
    protected void btnOKAdd_Click(object sender, EventArgs e)
    {
        try
        {
            UserProfile us = new UserProfile();
            try
            {
                us.UserProfileID = Convert.ToInt32(hdUserProfileIDA.Value);
            }
            catch
            {
            }
            int ipermissionroleid = Convert.ToInt32(ddlPermissionRoleA.SelectedValue);
            us.AddUserToRole(ipermissionroleid);
            BindDataR();
            lblMessage.Text = "Add successfully.";
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.Message;

        }
        btnMessage.Focus();
        mpeMessage.Show();
        
    }
}
