namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_PermissionRole")]
    public class SC_PermissionRole : OBase
    {
        private int _PermissionRoleID;
        private string _PermissionRoleName;
        public SC_PermissionRole()
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
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    return _con.GetDataTableByStore("SC_PermissionRole_Search");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    public enum EPermissionRole
    {
        Trainers = 1,
        Trainer_Leader = 2,
        Line_Manager = 3,
        QE = 4,
        Full_Report = 5,
        Input = 6,
        IL_Lock = 7,
        View_Only = 8,
        Admin = 10
    };
}

