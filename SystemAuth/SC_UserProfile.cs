namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using System.Collections.Generic;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_UserProfile")]
    public class SC_UserProfile : OBase
    {
        private int _UserProfileID;
        private string _UserName;
        private string _EmployeeID;
        private string _FullName;
        private string _Email;
        private int _DepartmentID;
        private string _ContactNo;
        private bool _IsActive;

        public SC_UserProfile()
        {
            this._UserProfileID = 0;
            this._UserName = "";
            this._EmployeeID = "";
            this._FullName = "";
            this._Email = "";
            this._ContactNo = "";
        }
        public SC_UserProfile(int i_userprofileid)
        {
            this._UserProfileID = i_userprofileid;
            this._UserName = "";
            this._EmployeeID = "";
            this._FullName = "";
            this._Email = "";
            this._ContactNo = "";
        }
        public SC_UserProfile(string pstr_username)
        {
            this._UserProfileID = 0;
            this._UserName = pstr_username;
            this._EmployeeID = "";
            this._FullName = "";
            this._Email = "";
            this._ContactNo = "";
        }

        public int UserProfileID
        {
            get
            {
                return this._UserProfileID;
            }
            set
            {
                this._UserProfileID = value;
            }
        }
        public string UserName
        {
            get
            {
                return this._UserName;
            }
            set
            {
                this._UserName = value;
            }
        }
        public string EmployeeID
        {
            get
            {
                return this._EmployeeID;
            }
            set
            {
                this._EmployeeID = value;
            }
        }
        public string FullName
        {
            get
            {
                return this._FullName;
            }
            set
            {
                this._FullName = value;
            }
        }
        public string Email
        {
            get
            {
                return this._Email;
            }
            set
            {
                this._Email = value;
            }
        }
        public int DepartmentID
        {
            get
            {
                return this._DepartmentID;
            }
            set
            {
                this._DepartmentID = value;
            }
        }
        public string ContactNo
        {
            get
            {
                return this._ContactNo;
            }
            set
            {
                this._ContactNo = value;
            }
        }
        public bool IsActive
        {
            get
            {
                return this._IsActive;
            }
            set
            {
                this._IsActive = value;
            }
        }
        public void Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[9, 2]	{	{ "@UserProfileID", this._UserProfileID },
                                                            { "@UserName", this._UserName },
                                                            { "@EmployeeID", this._EmployeeID },
															{ "@FullName", this._FullName},
															{ "@Email", this._Email},
															{ "@DepartmentID", this._DepartmentID},
                                                            { "@ContactNo", this._ContactNo},
															{ "@IsActive", this._IsActive},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("SC_UserProfile_Save", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
              
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int Delete()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2] { { "@UserProfileID", this._UserProfileID },
                                                        { "@LastUpdatedBy", this._LastUpdatedBy }};
                    return Convert.ToInt32(_con.ExecStoreRObject("SC_UserProfile_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Select()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2] { { "@UserProfileID", this._UserProfileID },
                                                        { "@UserName", this._UserName }};
                    DataTable dt = _con.GetDataTableByStore("SC_UserProfile_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        
        public static DataTable Search(string p_username,
                                        string p_employeeid,
                                        string p_fullname,
                                        string p_email,
                                        int p_departmentid,
                                        string p_contactno,
                                        int p_isactive,
                                        int p_permissionroleid,
                                        int p_customer_id,
                                        string p_filter = "")
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[10, 2]	{	
                                                            { "@UserName", p_username },
                                                            { "@EmployeeID", p_employeeid },
															{ "@FullName",p_fullname},
															{ "@Email", p_email},
															{ "@DepartmentID", p_departmentid},
                                                            { "@ContactNo", p_contactno},
															{ "@IsActive", p_isactive},
                                                            { "@PermissionRoleID", p_permissionroleid},
                                                            { "@Customer_ID", p_customer_id},
                                                            { "@Filter", p_filter }
														};
                    return _con.GetDataTableByStore("SC_UserProfile_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void AddUserProfileToRole(int p_permissionroleid)
        {
            try
            {
                using (SC_UserProfilePermissionRole upr = new SC_UserProfilePermissionRole())
                {
                    upr.UserProfileID = this._UserProfileID;
                    upr.PermissionRoleID = p_permissionroleid;
                    upr.Save();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int RemoveUserProfileFromRole(int p_permissionroleid)
        {
            try
            {
                using (SC_UserProfilePermissionRole upr = new SC_UserProfilePermissionRole())
                {
                    upr.UserProfileID = this._UserProfileID;
                    upr.PermissionRoleID = p_permissionroleid;
                    return upr.Delete();
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        public void AddUserProfileToCustomer(int p_customer_id)
        {
            try
            {
                using (SC_UserProfileCustomers upr = new SC_UserProfileCustomers())
                {
                    upr.UserProfileID = this._UserProfileID;
                    upr.Customer_ID = p_customer_id;
                    upr.Save();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int RemoveUserProfileFromCustomer(int p_customer_id)
        {
            try
            {
                using (SC_UserProfileCustomers upr = new SC_UserProfileCustomers())
                {
                    upr.UserProfileID = this._UserProfileID;
                    upr.Customer_ID = p_customer_id;
                    return upr.Delete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SC_Controls> GetControlsListByMenuIDAndUserProfileID(int p_menuid)
        {
            try
            {
                List<SC_Controls> lstcontrols = new List<SC_Controls>();
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2] { { "@UserProfileID", this._UserProfileID }
                                                            , { "@MenuID", p_menuid } };
                    DataTable dt = _con.GetDataTableByStore("SC_Controls_Select_By_UserProfileID_MenuID", paramarr);
                    foreach (DataRow dr in dt.Rows)
                    {
                        SC_Controls scc = new SC_Controls();
                        scc.Fill(dr);
                        lstcontrols.Add(scc);
                    }
                }
                return lstcontrols;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable GetPermissionRoleListByUserProfileID()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@UserProfileID", this._UserProfileID } };
                    return _con.GetDataTableByStore("SC_UserProfilePermissionRole_Select_By_UserProfileID", paramarr);
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        public DataTable GetCustomersListByUserProfileID()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@UserProfileID", this._UserProfileID } };
                    return _con.GetDataTableByStore("SC_UserProfileCustomers_Select_By_UserProfileID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataSet GetMenuListByUserProfileID()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@UserProfileID", this._UserProfileID } };
                    return _con.GetDataSetByStore("SC_Menu_Select_By_UserProfileID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool RoleInPage(string pstr_page)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]	{	{ "@UserName", this._UserName },
															{ "@MenuPath", pstr_page}
														};
                    return Convert.ToBoolean(_con.ExecStoreRObject("SC_UserProfilePermissionRole_InPage", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool CheckPermissionRole(int pipermissionroleid)
        {
            try
            {

                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[2, 2]   {   {"@PermissionRoleID", pipermissionroleid},
                                                                {"@UserProfileID", this._UserProfileID}
                                                        };
                    return Convert.ToBoolean(_con.ExecStoreRObject("SC_UserProfile_CheckPermissionRole", paramarr));

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

