namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_UserProfilePermissionRole")]
    public class SC_UserProfilePermissionRole : OBase
    {
        private int _UserProfileID;
        private int _PermissionRoleID;

        public SC_UserProfilePermissionRole()
        {
            
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

        public void Save()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@PermissionRoleID", this._PermissionRoleID},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    _con.ExecStoreRDataTable("SC_UserProfilePermissionRole_Save", paramarr);
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
                    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@PermissionRoleID", this._PermissionRoleID},
                                                            { "@LastUpdatedBy", this._LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("SC_UserProfilePermissionRole_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}

