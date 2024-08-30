namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Collections.Generic;
    using System.Data;
    ////using HRTR.Utilities;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("UserProfile")]
    public class UserProfile : OBase
    {
        private int _UserProfileID;
        private string _UserName;
        private string _EmployeeID;
        private string _FullName;
        private string _Email;
        private int _DepartmentID;
        private string _ContactNo;

        private bool _IsActive;
        //private string _LastUpdatedByUserName;

        public UserProfile()
        {
            this._UserProfileID = 0;
            this._UserName = "";
            this._EmployeeID = "";
            this._FullName = "";
            this._Email = "";
            this._ContactNo = "";
            //this._LastUpdatedByUserName = Environment.UserName;
        }
        public UserProfile(int i_userprofileid)
        {
            this._UserProfileID = i_userprofileid;
            this._UserName = "";
            this._EmployeeID = "";
            this._FullName = "";
            this._Email = "";
            this._ContactNo = "";
            //this._LastUpdatedByUserName = Environment.UserName;
        }
        public UserProfile(string pstr_username)
        {
            this._UserProfileID = 0;
            this._UserName = pstr_username;
            this._EmployeeID = "";
            this._FullName = "";
            this._Email = "";
            this._ContactNo = "";
            //this._LastUpdatedByUserName = Environment.UserName;
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


        public bool Save()
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
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    DataTable dt = _con.ExecStoreRDataTable("UserProfile_Save", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                    return true;
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
                    object[,] paramarr = new object[2, 2]	{	{ "@UserProfileID", this._UserProfileID },
                                                        { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("UserProfile_Delete", paramarr));
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
                    object[,] paramarr = new object[2, 2] {  { "@UserProfileID", this._UserProfileID },
                                                        { "@UserName", this._UserName } };
                    DataTable dt = _con.GetDataTableByStore("UserProfile_Select", paramarr);
                    DataRow dr = dt.Rows[0];
                    this.Fill(dr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable Search(
                                        string p_username = "",
                                        string p_employeeid = "",
                                        string p_fullname = "",
                                        string p_email = "",
                                        int p_departmentid = 0,
                                        string p_contactno = "",
                                        int p_isactive = 1,
                                        int p_permissionroleid = 0,
                                        string p_filter = "")
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[9, 2]	{	{ "@UserName", p_username },
                                                            { "@EmployeeID", p_employeeid },
															{ "@FullName",p_fullname},
															{ "@Email", p_email},
															{ "@DepartmentID", p_departmentid},
                                                            { "@ContactNo", p_contactno},
															{ "@IsActive", p_isactive},
                                                            { "@PermissionRoleID", p_permissionroleid},
                                                            { "@Filter", p_filter }
														};
                    return _con.GetDataTableByStore("UserProfile_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public void AddUserToRole(int p_permissionroleid)
        {
            try
            {
                UserProfilePermissionRole upr = new UserProfilePermissionRole();
                upr.UserProfileID = this._UserProfileID;
                upr.PermissionRoleID = p_permissionroleid;
                upr.Save();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int RemoveUserFromRole(int p_permissionroleid)
        {
            try
            {
                UserProfilePermissionRole upr = new UserProfilePermissionRole();
                upr.UserProfileID = this._UserProfileID;
                upr.PermissionRoleID = p_permissionroleid;
                return upr.Delete();
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        public DataTable GetRoleListByUserProfileID()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@UserProfileID", this._UserProfileID } };
                    return _con.GetDataTableByStore("UserProfilePermissionRole_Select_By_UserProfileID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable GetDelegationByUserProfileID()
        {

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@OwnerID", this._UserProfileID } };
                    return _con.GetDataTableByStore("Delegation_Select_By_OwnerID", paramarr);
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
                    return _con.GetDataSetByStore("Menu_Select_By_UserProfileID", paramarr);
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
                    object[,] paramarr = new object[2, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@MenuPath", pstr_page}
														};
                    return Convert.ToBoolean(_con.ExecStoreRObject("UserProfilePermissionRole_InPage", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void PreviewUserProfile(string pstr_fromexcelfile, int pi_userprofileid)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_userprofileid } };
                    _con.ExecStore("UserProfileTemp_DeleteAll", paramarr);
                }
                Excel2SQL e2s = new Excel2SQL();
                e2s.SQLConnectionString = HRTRConfig.ConnectionString;

                e2s.FromExcelFile = pstr_fromexcelfile;
                e2s.ExcelQuery = "Select [UserName], [EmployeeID], [FullName], [Email], [Department], [ContactNo], [IsActive] FROM [UserProfile$]";
                e2s.ToSQLTable = "UserProfileTemp";
                e2s.ToSQLTableColumns.Add("UserName", "UserName");
                e2s.ToSQLTableColumns.Add("EmployeeID", "EmployeeID");
                e2s.ToSQLTableColumns.Add("FullName", "FullName");
                e2s.ToSQLTableColumns.Add("Email", "Email");
                e2s.ToSQLTableColumns.Add("Department", "DepartmentName");
                e2s.ToSQLTableColumns.Add("ContactNo", "ContactNo");
                e2s.ToSQLTableColumns.Add("IsActive", "IsActive");
                if (e2s.readExcel2SQL())
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_userprofileid } };
                        _con.ExecStore("UserProfileTemp_Verify", paramarr);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static DataTable SelectAllTemp(int pi_userprofileid)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_userprofileid } };
                    return _con.GetDataTableByStore("UserProfileTemp_SelectAll", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static int Import(int pi_userprofileid)
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2] { { "@LastUpdatedBy", pi_userprofileid } };
                    return Convert.ToInt32(_con.ExecStoreRObject("UserProfile_Import", paramarr));
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

