using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using eUtilities;
using SystemAuth;
using System.Linq;

namespace HCM.BasePage
{
    /// <summary>
    /// Generic PageBase for inheritance by UI aspx pages
    /// </summary>
    public class BasePage : System.Web.UI.Page
    {
        #region Fields
        protected int MenuID
        {
            get
            {
                try
                {
                    HiddenField hdMenuID = (HiddenField)FindControlRecursive(this, "hdMenuID");
                    if (hdMenuID != null)
                        return Convert.ToInt32(hdMenuID.Value);
                    else
                        return 0;
                }
                catch
                {
                    return 0;
                }
            }
        }
        public int UserProfileID
        {
            get
            {
                try
                {
                    return Convert.ToInt32(HttpContext.Current.Session["UserProfileID"]);
                }
                catch { return 0; };
            }
        }
        public string IdentityUserName
        {
            get
            {
                string strReturn = string.Empty;
                string strUserName = Page.User.Identity.Name;
                try
                {
                    string[] straUserName = strUserName.Split(new char[] { '\\' });
                    strReturn = straUserName[1];
                }
                catch
                {
                    strReturn = strUserName;
                }
                return strReturn;
            }
        }
        #endregion

        #region Override
        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);
        }

        /// <summary>
        /// OnInit
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            BindEvent();
        }

        /// <summary>
        /// OnLoad
        /// </summary>
        /// <param name="e"></param>
        protected override void OnLoad(EventArgs e)
        {
            string url = Page.Request.Url.ToString().ToLower();
            string[] list = url.Split('/');
            string pagename = list[list.Length - 1];

            //object ojbuserprofileid = Session["UserProfileID"];
            //int iuserprofileid = 0;
            //try
            //{
            //    iuserprofileid = Convert.ToInt32(ojbuserprofileid);
            //}
            //catch
            //{
            //}
            using (SC_UserProfile up = new SC_UserProfile())
            {
                up.UserProfileID = this.UserProfileID;
                up.UserName = IdentityUserName;
                if (!up.RoleInPage(pagename))
                {
                    if (!pagename.Equals("Default.aspx", StringComparison.CurrentCultureIgnoreCase)
                    && !pagename.Equals("Home.aspx", StringComparison.CurrentCultureIgnoreCase)
                    && !pagename.Equals("Info.aspx", StringComparison.CurrentCultureIgnoreCase)
                    )
                        Response.Redirect("~/Default.aspx", true);
                }
                else { }
            }
            //if (iuserprofileid == 0)
            //{
            //    if (!pagename.Equals("Default.aspx", StringComparison.CurrentCultureIgnoreCase)
            //        && !pagename.Equals("Home.aspx", StringComparison.CurrentCultureIgnoreCase)
            //        && !pagename.Equals("Info.aspx", StringComparison.CurrentCultureIgnoreCase))
            //        Response.Redirect("~/Default.aspx");
            //}
            //else
            //{
            //}

            if (!IsPostBack)
            {
                //base.OnLoad(e);
                try
                {
                    //// Checks availability of menu id in pageaccessid list
                    HCM.Master mst = (HCM.Master)this.Master;
                    //if (mst.IsDenied == false && (mst.IsViewed == true || mst.IsUpdated == true))
                    //{
                    //    base.OnLoad(e);///Okie to load page
                    //}
                    //else
                    //{
                    //    if (!pagename.Equals("Default.aspx", StringComparison.CurrentCultureIgnoreCase))
                    //        Response.Redirect("~/Default.aspx");// redirect to default page
                    //    else
                    //        base.OnLoad(e);///Continue load Default.aspx
                    //}

                    base.OnLoad(e);///Okie to load page
                                   ///
                    if (!string.IsNullOrEmpty(mst.MenuName))
                        this.Title = mst.MenuName;
                    try
                    {

                        //HiddenField hdScreenID = (HiddenField)this.FindControl("hdScreenID");
                        HiddenField hdMenuID = (HiddenField)FindControlRecursive(this, "hdMenuID");
                        hdMenuID.Value = mst.MenuID.ToString();
                    }
                    catch
                    {
                    }
                    #region SC_Controls
                    ///Setting SC_Controls START
                    List<SC_Controls> lstcontrols = new List<SC_Controls>();
                    using (SC_UserProfile up = new SC_UserProfile())
                    {
                        up.UserProfileID = this.UserProfileID;
                        lstcontrols = up.GetControlsListByMenuIDAndUserProfileID(this.MenuID);
                    }
                    foreach (SC_Controls scc in lstcontrols)
                    {
                        try
                        {
                            WebControl wctl = (WebControl)FindControlRecursive(this.Page, scc.ControlName);
                            if (wctl != null)
                            {
                                //if (scc.ControlName == "lbGeneralInfo")
                                //{
                                //    string a = "";
                                //}
                                if (scc.IsDenied)
                                {
                                    wctl.Visible = false;
                                }
                                else
                                {
                                    wctl.Visible = true;
                                }
                                if (scc.IsViewed)
                                {
                                    wctl.Visible = true;
                                }
                                else
                                {
                                    wctl.Visible = false;
                                }
                                if (scc.IsUpdated)
                                {
                                    wctl.Enabled = true;
                                }
                                else
                                {
                                    wctl.Enabled = false;
                                }
                            }
                        }
                        catch
                        {
                        }
                    }
                    ///Setting SC_Controls END
                    #endregion
                    try
                    {
                        MemoryManagement.FlushMemory();
                    }
                    catch { }
                    //try
                    //{
                    //    //HiddenField hdIsUpdated = (HiddenField)mst.FindControl("hdIsUpdated");
                    //    HiddenField hdIsUpdated = (HiddenField)FindControlRecursive(this, "hdIsUpdated");
                    //    hdIsUpdated.Value = mst.IsUpdated.ToString();
                    //}
                    //catch///(Exception ex)
                    //{
                    //    ///string a = ex.Message;
                    //}
                }
                catch///If page not use eQueuingMaster page
                {
                    base.OnLoad(e);
                }
            }
        }

        /// <summary>
        /// OnInitComplete
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInitComplete(EventArgs e)
        {
            base.OnInitComplete(e);
            BindValidation();
        }
        #endregion

        #region Virtual
        /// <summary>
        /// Binds UI Controls section
        /// </summary>
        protected virtual void BindEvent()
        {
        }

        /// <summary>
        /// Validation codes section
        /// </summary>
        protected virtual void BindValidation()
        {
        }

        #endregion

        #region Methods

        protected void ShowMessage(Label lblMessage, string strMessage, string strCssClass = "")
        {
            strMessage = strMessage.Replace("'", "&#39;").Replace(@"\", "&#92;").Replace("\r\n", "<br />").Replace("\r", " ").Replace("\n", "<br />").Replace(@"""", "&#34;");
            string strscript = @"jQuery(""" + @"#" + lblMessage.ClientID + @""").html(""" + strMessage + @""").show(""" + @"fast" + @""")";
            if (!string.IsNullOrEmpty(strCssClass))
                strscript += @".addClass(""" + strCssClass + @""");";
            else
                strscript += @".addClass(""" + "Msg" + @""");";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "strmessagescript", strscript, true);
        }

        protected void ShowError(Label lblError, string strError)
        {
            ShowMessage(lblError, strError, "errorMsg");
        }

        protected void ExportToExcelFile(DataTable dtExportedDataTable, string strsheetname)
        {
            try
            {
                Session["ExportDataTable"] = dtExportedDataTable;

                string strresponse = "../Reports/ExportExcelPage.aspx?shn=" + strsheetname;
                string strscript = "";
                strscript += "<script>";
                strscript += "window.open('" + strresponse + "', '_blank')";
                strscript += "</script>";
                ScriptManager.RegisterClientScriptBlock(this, typeof(System.String), "scriptExportDataTable", strscript, false);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id)
            {
                return root;
            }

            foreach (Control c in root.Controls)
            {
                Control t = FindControlRecursive(c, id);
                if (t != null)
                {
                    return t;
                }
            }

            return null;
        }

        protected bool IsValidUserRole(List<EPermissionRole> lstPermissionRole)
        {
            using (SC_UserProfile us = new SC_UserProfile())
            {
                us.UserProfileID = UserProfileID;
                DataTable dtPermissionRole = us.GetPermissionRoleListByUserProfileID();
                
                foreach (DataRow dr in dtPermissionRole.Rows)
                {
                    int permissionRoleId = dr.Field<int>("PermissionRoleID");
                    if (lstPermissionRole.Contains((EPermissionRole)permissionRoleId))
                    {
                        return true;
                    }
                }
                return false;
            }
        }
        #endregion

        #region Public Methods
        public static bool StringToBoolean(string strvalue)
        {
            strvalue = strvalue.ToUpper();
            if (strvalue == "1"
                || strvalue == "TRUE"
                || strvalue == "YES"
                || strvalue == "Y"
                || strvalue == "T")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        ///// <summary>
        ///// Page.User.Identity.Name (remove domain if any)
        ///// </summary>
        ///// <param name="strname"></param>
        ///// <returns></returns>
        //public string PageIdentityUserName()
        //{
        //    string strname = Page.User.Identity.Name;
        //    string[] straname = strname.Split(new char[] { '\\' });
        //    return straname[1];
        //}
        public static string PathMap(string strpath)
        {
            string strapproot = HttpContext.Current.Request.PhysicalApplicationPath.TrimEnd('\\');
            return strpath.Replace(strapproot, string.Empty).Replace('\\', '/');
        }
        //public static string IdentityUserNameWithoutDomain(System.Web.UI.Page pg)
        //{
        //    string strReturn = string.Empty;
        //    string strUserName = string.Empty;
        //    try
        //    {
        //        strUserName = pg.User.Identity.Name;
        //        string[] straUserName = strUserName.Split(new char[] { '\\' });
        //        strReturn = straUserName[1];
        //    }
        //    catch
        //    {
        //        strReturn = strUserName;
        //    }
        //    return strReturn;

        //}
        #endregion

    }
}