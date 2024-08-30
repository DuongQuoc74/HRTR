using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Collections.Specialized;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.Xml;
using SystemAuth;

namespace HCM
{
    public partial class Master : System.Web.UI.MasterPage
    {
        #region Fields

        private int _MenuID;
        private string _MenuName;

        #endregion

        #region Properties

        public int MenuID
        {
            get
            {
                return this._MenuID;
            }
            set
            {
                this._MenuID = value;
            }
        }
        public string MenuName
        {
            get
            {
                return this._MenuName;
            }
            set
            {
                this._MenuName = value;
            }
        }
        #endregion

        #region Page Events
        protected void Page_Init(object sender, EventArgs e)
        {
            string sPagePath = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
            string strQuery = System.Web.HttpContext.Current.Request.Url.Query;
            System.IO.FileInfo oFileInfo = new System.IO.FileInfo(sPagePath);
            string sPageName = oFileInfo.Name;
            string strmenulist = null;
            string strusername = NameWithoutDomain(Page.User.Identity.Name);
            if (Page.User.Identity.IsAuthenticated && sPageName != "Info.aspx")
            {
                try
                {
                    SC_UserProfile us = new SC_UserProfile();
                    us.UserName = strusername;
                    if (Session["UserProfileID"] == null)
                    {
                        try
                        {
                            us.Select();
                            Session["UserProfileID"] = us.UserProfileID;
                        }
                        catch///User Name not exist in DB yet
                        {
                            Session["UserProfileID"] = 0;
                        }

                    }

                    if (!Page.IsPostBack)
                    {
                        if (Session["HRTRMenu"] == null)
                        {
                            DataSet dsMenuList = new DataSet();
                            us.Select();

                            //strfullname = us.FullName;
                            dsMenuList = us.GetMenuListByUserProfileID();
                            dsMenuList.DataSetName = "Menus";
                            dsMenuList.Tables[0].TableName = "Menu";
                            DataRelation relation = new DataRelation("ParentChild",
                            dsMenuList.Tables["Menu"].Columns["MenuID"],
                            dsMenuList.Tables["Menu"].Columns["ParentID"], true);

                            relation.Nested = true;
                            dsMenuList.Relations.Add(relation);

                            strmenulist = dsMenuList.GetXml();

                            Session["HRTRMenu"] = strmenulist;
                            Session["UserProfileID"] = us.UserProfileID;
                        }
                        else
                        {
                            strmenulist = Convert.ToString(Session["HRTRMenu"]);
                        }
                        xmlDataSource.Dispose();
                        xmlDataSource.Data = strmenulist;
                        xmlDataSource.DataBind();

                        if (Request.Params["Sel"] != null)
                        {
                            string strPage = Convert.ToString(Request.Params["Sel"]);
                            if (strPage != "")
                            {
                                if (!us.RoleInPage(strPage))
                                {
                                    Response.Redirect("../Info.aspx");
                                }
                                else
                                {
                                    Response.Redirect(strPage);
                                }
                            }
                        }

                        MainMenu.Dispose();
                        MainMenu.DataSourceID = "xmlDataSource";
                        MainMenu.DataBind();


                        if (sPageName != "Home.aspx")
                        {
                            if (System.Web.HttpContext.Current.Request.UrlReferrer == null)
                            {
                                if (!us.RoleInPage(sPageName))
                                {
                                    Response.Redirect("../Info.aspx");
                                }
                            }
                        }

                        lgName.FormatString = strusername;

                        NavigationPath(strmenulist, sPageName, strQuery);

                    }
                }
                catch
                {
                    xmlDataSource.Dispose();
                    xmlDataSource.Data = "<Menus />";
                    xmlDataSource.DataBind();

                    MainMenu.Dispose();
                    MainMenu.DataSourceID = "xmlDataSource";
                    MainMenu.DataBind();
                    if (sPageName != "Home.aspx")
                        Response.Redirect("../Info.aspx");
                }
            }
            else
            {
                if (Session["HRTRMenu"] == null)
                    strmenulist = "<Menus />";
                else
                    strmenulist = Convert.ToString(Session["HRTRMenu"]);
                xmlDataSource.Dispose();
                xmlDataSource.Data = strmenulist;
                xmlDataSource.DataBind();

                MainMenu.Dispose();
                MainMenu.DataSourceID = "xmlDataSource";
                MainMenu.DataBind();
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string strapplicationversion;
                try
                {
                    System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
                    System.Diagnostics.FileVersionInfo fvi = System.Diagnostics.FileVersionInfo.GetVersionInfo(assembly.Location);
                    strapplicationversion = fvi.FileVersion;
                }
                catch
                {
                    strapplicationversion = "1.0.0";
                    if (ConfigurationManager.AppSettings["ApplicationVersion"] != null)
                    {
                        strapplicationversion = ConfigurationManager.AppSettings["ApplicationVersion"].ToString();
                    }
                }
                lblApplicationVersion.Text = string.Format("Version {0}.", strapplicationversion);
            }
        }
        //public string GetCurrentPageName()
        //{
        //    string sPath = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
        //    System.IO.FileInfo oInfo = new System.IO.FileInfo(sPath);
        //    string sRet = oInfo.Name;
        //    return sRet;
        //}
        #endregion

        #region Private Methods
        private string NavigationPath(string pstrMenuXML, string pstrPageName, string pstrQuery)
        {
            string strmenulevel = string.Empty;
            if (pstrPageName.Equals("Default.aspx", StringComparison.CurrentCultureIgnoreCase))
                return strmenulevel;
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(pstrMenuXML);
            XmlNode mCurrentNode;
            mCurrentNode = doc.DocumentElement;
            XmlNode selectednode = mCurrentNode.SelectSingleNode("//Menu[FileName='" + pstrPageName + pstrQuery + "']");
            if (selectednode == null)
            {
                selectednode = mCurrentNode.SelectSingleNode("//Menu[FileName='" + pstrPageName + "']");
            }
            if (selectednode != null)
            {
                if (selectednode.ChildNodes.Count > 0)
                {
                    foreach (XmlNode childnode in selectednode.ChildNodes)
                    {
                        if (childnode.Name == "FLevel")
                        {
                            strmenulevel = childnode.InnerText;
                            string[] stramenulevel = strmenulevel.Split(new char[] { '.' });

                            for (int i = 0; i < stramenulevel.Length; i++)
                            {
                                XmlNode tempnode = mCurrentNode.SelectSingleNode("//Menu[MenuID='" + stramenulevel[i] + "']");
                                if (tempnode.ChildNodes.Count > 0)
                                {
                                    Label lb = new Label();
                                    lb.Text = " > ";
                                    HyperLink hl = new HyperLink();
                                    foreach (XmlNode node in tempnode.ChildNodes)
                                    {
                                        if (node.Name == "MenuID")
                                            hl.ID = node.InnerText;
                                        else if (node.Name == "MenuName")
                                            hl.Text = node.InnerText;
                                        else if (node.Name == "MenuPath")
                                            hl.NavigateUrl = node.InnerText;
                                    }
                                    hl.CssClass = "breadcrumb";
                                    navlink.Controls.Add(lb);
                                    navlink.Controls.Add(hl);
                                }
                            }

                        }
                        else if (childnode.Name == "MenuID")
                        {
                            this._MenuID = Convert.ToInt32(childnode.InnerText);
                        }
                        else if (childnode.Name == "MenuName")
                        {
                            this._MenuName = childnode.InnerText;
                        }
                        //else if (childnode.Name == "IsDenied")
                        //{
                        //    this._IsDenied = Convert.ToBoolean(Convert.ToInt32(childnode.InnerText));
                        //}
                        //else if (childnode.Name == "IsViewed")
                        //{
                        //    this._IsViewed = Convert.ToBoolean(Convert.ToInt32(childnode.InnerText));
                        //}
                        //else if (childnode.Name == "IsUpdated")
                        //{
                        //    this._IsUpdated = Convert.ToBoolean(Convert.ToInt32(childnode.InnerText));
                        //}
                    }
                }
            }
            return strmenulevel;
        }
        //private void NavPath(string strmenulist, string sPageName)
        //{
        //    if (sPageName == "Home.aspx")
        //        return;
        //    XmlDocument doc = new XmlDocument();
        //    doc.LoadXml(strmenulist);
        //    XmlNode mCurrentNode;
        //    mCurrentNode = doc.DocumentElement;
        //    XmlNode selectednode = mCurrentNode.SelectSingleNode("//Menu[FileName='" + sPageName + "']");
        //    if (selectednode == null)
        //    {
        //        try
        //        {
        //            string sPagePath = System.Web.HttpContext.Current.Request.UrlReferrer.AbsolutePath;
        //            System.IO.FileInfo oFileInfo = new System.IO.FileInfo(sPagePath);
        //            sPageName = oFileInfo.Name;
        //            selectednode = mCurrentNode.SelectSingleNode("//Menu[FileName='" + sPageName + "']");
        //        }
        //        catch
        //        {
        //        }
        //    }
        //    if (selectednode != null)
        //    {
        //        if (selectednode.ChildNodes.Count > 0)
        //        {
        //            foreach (XmlNode childnode in selectednode.ChildNodes)
        //            {
        //                if (childnode.Name == "FLevel")
        //                {
        //                    string strmenuid = childnode.InnerText;
        //                    string[] strlmenuid = strmenuid.Split(new char[] { '.' });
        //                    for (int i = 0; i < strlmenuid.Length; i++)
        //                    {
        //                        XmlNode tempnode = mCurrentNode.SelectSingleNode("//Menu[MenuID='" + strlmenuid[i] + "']");
        //                        if (tempnode.ChildNodes.Count > 0)
        //                        {
        //                            Label lb = new Label();
        //                            lb.Text = " > ";
        //                            HyperLink hl = new HyperLink();
        //                            foreach (XmlNode node in tempnode.ChildNodes)
        //                            {
        //                                if (node.Name == "MenuID")
        //                                    hl.ID = node.InnerText;
        //                                else if (node.Name == "MenuName")
        //                                    hl.Text = node.InnerText;
        //                                else if (node.Name == "MenuPath")
        //                                    hl.NavigateUrl = node.InnerText;
        //                            }
        //                            hl.CssClass = "breadcrumb";
        //                            navlink.Controls.Add(lb);
        //                            navlink.Controls.Add(hl);
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //    }
        //}
        private static string NameWithoutDomain(string strname)
        {
            string[] straname = strname.Split(new char[] { '\\' });
            return straname[1];
        }
        #endregion
    }
}