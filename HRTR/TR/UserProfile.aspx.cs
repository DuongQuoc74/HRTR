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
using System.IO;
using HRTR.Server;

public partial class HRTR_UserProfile : System.Web.UI.Page
{

	protected void Page_Load(object sender, EventArgs e)
	{
        if (!IsPostBack)
        {

            DataTable dtDepartment = SY_Department.Search();
            //Department
            ddlDepartmentS.DataSource = dtDepartment;
            ddlDepartmentS.DataBind();

            //Department
            ddlDepartmentU.DataSource = dtDepartment;
            ddlDepartmentU.DataBind();
            //Department
            ddlDepartmentD.DataSource = dtDepartment;
            ddlDepartmentD.DataBind();

            //Department
            ddlDepartmentA.DataSource = dtDepartment;
            ddlDepartmentA.DataBind();
            
            ddlDepartmentA.Items.Insert(0, new ListItem("[Please Select]", "0"));

            DataTable dtRoleList = PermissionRole.Search();
            //Role list
            cblUserRoleU.DataSource = dtRoleList;
            cblUserRoleU.DataBind();

            //Role list
            cblUserRoleD.DataSource = dtRoleList;
            cblUserRoleD.DataBind();

            //Role list
            cblUserRoleA.DataSource = dtRoleList;
            cblUserRoleA.DataBind();
            foreach (ListItem lii in cblUserRoleA.Items)
            {
                if (lii.Value == "1")
                    lii.Selected = true;
                else
                    lii.Selected = false;
            }
            //End role list

            
            ddlDepartmentS.Items.Insert(0, new ListItem("[Please Select]", "0"));
            Session["UserProfileListSort"] = "";
            BindData();
            

        }
        else if (IsAsync)
        {
        }
        else
        {
        }
        txtSearchUserA.Attributes.Add("onkeyup", "SearchUser(this);");
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        btnAddControl.Focus();
	}

	protected void grvUserProfileList_PageIndexChanging(object sender, GridViewPageEventArgs e)
	{
        grvUserProfileList.PageIndex = e.NewPageIndex;
        BindData();
	}
	protected void grvUserProfileList_RowDataBound(object sender, GridViewRowEventArgs e)
	{
		
	}
	protected void grvUserProfileList_Sorting(object sender, GridViewSortEventArgs e)
	{
        string str_ssname = "UserProfileListSort";
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

	protected void btnSearch_Click(object sender, EventArgs e)
	{
        BindData();
	}
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            UserProfile us = new UserProfile();
            try
            {
                us.UserProfileID = Convert.ToInt32(hdUserProfileID.Value);
            }
            catch
            {
            }
            us.Delete();
            BindData();
            string strmess = "You already deleted user " + txtUserNameD.Text + " successfully.";
            lblMessage.Text = strmess;
            btnMessage.Focus();
            mpeMessage.Show();
        }
        catch (Exception ex)
        {
            lblDeleteErr.Text = ex.Message;
            mpeDelete.Show();
        }

    }
	private void BindData(string pstr_sort = "")
	{
        if (string.IsNullOrEmpty(pstr_sort))
        {
            try
            {
                if (Session["UserProfileListSort"] != null)
                {
                    pstr_sort = Session["UserProfileListSort"].ToString();
                }
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

        DataTable dtUserProfile = UserProfile.Search(strusername, stremployeeid, strfullname, stremail, idepartmentid, strcontactno, iisactive, 0);
        if (!string.IsNullOrEmpty(pstr_sort))
            dtUserProfile.DefaultView.Sort = pstr_sort;
        grvUserProfileList.DataSource = dtUserProfile;
        grvUserProfileList.DataBind();
	}
	private void LoadUserForUpdate(int pi_userprofileid)
	{
        UserProfile us = new UserProfile();
        hdUserProfileID.Value = pi_userprofileid.ToString();
        us.UserProfileID = pi_userprofileid;
        us.Select();
        txtUserNameU.Text = us.UserName;
        txtEmployeeIDU.Text = us.EmployeeID;
        txtFullNameU.Text = us.FullName;
        txtEmailU.Text = us.Email;
        try
        {
            ddlDepartmentU.SelectedValue = us.DepartmentID.ToString();
        }
        catch
        {
        }
        txtContactNoU.Text = us.ContactNo;
        cbIsActiveU.Checked = us.IsActive;

        lblUpdateErr.Text = "";
        DataTable dtUserRole = us.GetRoleListByUserProfileID();
        foreach (ListItem li in cblUserRoleU.Items)
        {
            li.Selected = false;
        }
        foreach (DataRow dr in dtUserRole.Rows)
        {
            foreach (ListItem li in cblUserRoleU.Items)
            {
                if (li.Value == dr["PermissionRoleID"].ToString())
                    li.Selected = true;

            }
        }
	}
    private void LoadUserForDelete(int pi_userprofileid)
    {
        UserProfile us = new UserProfile();
        hdUserProfileID.Value = pi_userprofileid.ToString();
        us.UserProfileID = pi_userprofileid;
        us.Select();
        txtUserNameD.Text = us.UserName;
        txtEmployeeIDD.Text = us.EmployeeID;
        txtFullNameD.Text = us.FullName;
        txtEmailD.Text = us.Email;
        try
        {
            ddlDepartmentD.SelectedValue = us.DepartmentID.ToString();
        }
        catch
        {
        }
        txtContactNoD.Text = us.ContactNo;
        cbIsActiveD.Checked = us.IsActive;

        lblDeleteErr.Text = "";
        DataTable dtUserRole = us.GetRoleListByUserProfileID();
        foreach (ListItem li in cblUserRoleD.Items)
        {
            li.Selected = false;
        }
        foreach (DataRow dr in dtUserRole.Rows)
        {
            foreach (ListItem li in cblUserRoleD.Items)
            {
                if (li.Value == dr["PermissionRoleID"].ToString())
                    li.Selected = true;

            }
        }
    }
	protected void grvUserProfileList_RowCommand(object sender, GridViewCommandEventArgs e)
	{
        
        if (e.CommandName == "Select")
        {
            int iuserprofileid = Convert.ToInt32(e.CommandArgument);
            LoadUserForUpdate(iuserprofileid);
            mpeUpdate.Show();
            txtUserNameU.Focus();
        }
        else if (e.CommandName == "DelUser")
        {
            int iuserprofileid = Convert.ToInt32(e.CommandArgument);
            LoadUserForDelete(iuserprofileid);
            mpeDelete.Show();
            btnDelete.Focus();
        }
	}
	protected void btnAdd_Click(object sender, EventArgs e)
	{
        try
        {
            UserProfile us = new UserProfile();
            try
            {
                us.UserProfileID = Convert.ToInt32(hdUserProfileID.Value);
            }
            catch
            {
            }
            us.UserName = txtUserNameA.Text;
            us.EmployeeID = txtEmployeeIDA.Text;
            us.FullName = txtFullNameA.Text;
            us.Email = txtEmailA.Text;
            us.DepartmentID = Convert.ToInt32(ddlDepartmentA.SelectedValue);
            us.ContactNo = txtContactNoA.Text;
            us.IsActive = cbIsActiveA.Checked;
            us.Save();
            foreach (ListItem li in cblUserRoleA.Items)
            {
                int iroleid = Convert.ToInt32(li.Value);
                if (li.Selected)
                {
                    us.AddUserToRole(iroleid);
                }
                else
                {
                    us.RemoveUserFromRole(iroleid);
                }
            }

            BindData();
            string strmess = "Save user " + us.UserName + " successfully.";
            lblMessage.Text = strmess;
            btnMessage.Focus();
            mpeMessage.Show();
        }
        catch (Exception ex)
        {
            lblAddErr.Text = ex.Message;
            mpeAdd.Show();
        }


	}
    protected void btnOKUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            UserProfile us = new UserProfile();
            try
            {
                us.UserProfileID = Convert.ToInt32(hdUserProfileID.Value);
            }
            catch
            {
            }
            us.UserName = txtUserNameU.Text;
            us.EmployeeID = txtEmployeeIDU.Text;
            us.FullName = txtFullNameU.Text;
            us.Email = txtEmailU.Text;
            us.DepartmentID = Convert.ToInt32(ddlDepartmentU.SelectedValue);
            us.ContactNo = txtContactNoU.Text;
            us.IsActive = cbIsActiveU.Checked;
            us.Save();
            foreach (ListItem li in cblUserRoleU.Items)
            {
                int iroleid = Convert.ToInt32(li.Value);
                if (li.Selected)
                {
                    us.AddUserToRole(iroleid);
                }
                else
                {
                    us.RemoveUserFromRole(iroleid);
                }
            }
            BindData();
            string strmess = "Update successfully.";
            lblMessage.Text = strmess;
            btnMessage.Focus();
            mpeMessage.Show();
        }
        catch (Exception ex)
        {
            lblUpdateErr.Text = ex.Message;
            mpeUpdate.Show();
        }
    }

    #region Tab Control
    protected void mvUserProfile_Command(object sender, CommandEventArgs e)
    {
        SetMultiviewActive((string)e.CommandName);
    }
    private void SetMultiviewActive(string strviewid)
    {
        switch (strviewid)
        {
            case "Search":
                mvUserProfile.SetActiveView(vSearchUserProfile);
                lbSearch.CssClass = "multiviewtabactive";
                lbImport.CssClass = "multiviewtabinactive";

                break;
            case "Import":
                mvUserProfile.SetActiveView(vUploadUserProfile);
                lbSearch.CssClass = "multiviewtabinactive";
                lbImport.CssClass = "multiviewtabactive";
                break;

        }
    }
    #endregion

    #region Import
    protected void grvUserProfileTempList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvUserProfileTempList.PageIndex = e.NewPageIndex;
        BindDataTemp();
    }
    protected void grvUserProfileTempList_Sorting(object sender, GridViewSortEventArgs e)
    {
        string str_ssname = "UserProfileTempListSort";
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
        BindDataTemp(str_sort);
    }
    private void BindDataTemp(string pstr_sort = "")
    {
        if (string.IsNullOrEmpty(pstr_sort))
        {
            if (Session["UserProfileTempListSort"] != null)
            {
                pstr_sort = Session["UserProfileTempListSort"].ToString();
            }
        }
        int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
        DataTable dtUserProfileTemp = HRTR.Server.UserProfile.SelectAllTemp(iuserprofileid);
        if (!string.IsNullOrEmpty(pstr_sort))
            dtUserProfileTemp.DefaultView.Sort = pstr_sort;
        grvUserProfileTempList.DataSource = dtUserProfileTemp;
        grvUserProfileTempList.DataBind();
        grvUserProfileTempList.Visible = true;

        int iparttemptoal = dtUserProfileTemp.Rows.Count;
        if (iparttemptoal > 0)
            pnUploadInfo.Visible = true;
        else
            pnUploadInfo.Visible = false;
        lblUserProfileTempCount.Text = iparttemptoal.ToString() + " employee(s)";

        DataView dvPartTemp = dtUserProfileTemp.DefaultView;

        dvPartTemp.RowFilter = "IsValid = True";
        int iparttempvalid = dvPartTemp.Count;
        lblUserProfileTempValidCount.Text = iparttempvalid.ToString() + " employee(s)";

        if (iparttempvalid > 0)
            btnUploadAsk.Visible = true;
        else
            btnUploadAsk.Visible = false;

        int iparttempinvalid = iparttemptoal - iparttempvalid;
        lblUserProfileTempInValidCount.Text = iparttempinvalid.ToString() + " employee(s)";

    }
    protected void AsyncFUUserProfile_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        string strext = Path.GetExtension(AsyncFUUserProfile.FileName);
        if (strext == ".xls" || strext == ".xlsx")
        {

            string strfilename = AsyncFUUserProfile.FileName;
            string savePath = MapPath(Path.Combine("~/Temp/", strfilename));
            if (File.Exists(MapPath("~/Temp/") + Path.GetFileName(AsyncFUUserProfile.FileName)))
            {
                File.Delete(savePath);
            }
            AsyncFUUserProfile.SaveAs(savePath);
            //AsyncFUUserProfile.SaveAs(@"D:\Temp.xlsx");
        }
        else
        {

            AsyncFUUserProfile.ErrorBackColor = System.Drawing.Color.Red;
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        try
        {
            string strfilename = hdUploadFileName.Value;
            string strfile = MapPath(Path.Combine("~/Temp/", strfilename));
            //string strfile = @"D:\Temp.xlsx";
            int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
            HRTR.Server.UserProfile.PreviewUserProfile(strfile, iuserprofileid);
            BindDataTemp();
            hdUploadFileName.Value = "";

        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.Message;
            btnMessage.Focus();
            mpeMessage.Show();
        }
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        string strmess = string.Empty;
        try
        {
            int iuserprofileid = Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
            HRTR.Server.UserProfile.Import(iuserprofileid);

            BindData();

            grvUserProfileTempList.Visible = false;
            pnUploadInfo.Visible = false;
            btnUploadAsk.Visible = false;

            strmess = "Upload user profile(s) successfully.";

        }
        catch (Exception ex)
        {
            strmess = ex.Message;
        }
        lblMessage.Text = strmess;
        btnMessage.Focus();
        mpeMessage.Show();
    }
    #endregion
	
}
