namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    ////using HRTR.Utilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("PermissionRole")]
    public class PermissionRole : OBase
    {
        private int _PermissionRoleID;
        private string _PermissionRoleName;
        public PermissionRole()
        {
            this._PermissionRoleName = "";
        }
        public int PermissionRoleID
        {
            get
            {
                return this._PermissionRoleID;
            }
            set
            {
                this._PermissionRoleID = value;
            }
        }
        public string PermissionRoleName
        {
            get
            {
                return this._PermissionRoleName;
            }
            set
            {
                this._PermissionRoleName = value;
            }
        }

        public static DataTable Search()
        {
            try
            {
                try
                {
                    using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                    {
                        return _con.GetDataTableByStore("PermissionRole_Search");
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

       
    }
}

