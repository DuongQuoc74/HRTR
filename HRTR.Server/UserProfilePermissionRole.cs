namespace HRTR.Server
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    ////using HRTR.Utilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("UserProfilePermissionRole")]
    public class UserProfilePermissionRole : OBase
    {
        private int _UserProfileID;
        private int _PermissionRoleID;
        //private string _UserName;

        public UserProfilePermissionRole()
        {
            //this._UserName = Environment.UserName;
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
        //public string UserName
        //{
        //    get
        //    {
        //        return this._UserName;
        //    }
        //    set
        //    {
        //        this._UserName = value;
        //    }
        //}

        public void Save()
        {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
            //                                                { "@PermissionRoleID", this._PermissionRoleID},
            //                                                { "@LastUpdatedBy", this.LastUpdatedBy}
            //                                            };
            //    condb.execStoreRDT("UserProfilePermissionRole_Save", paramarr);
             
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@PermissionRoleID", this._PermissionRoleID},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    _con.ExecStore("UserProfilePermissionRole_Save", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int Delete()
        {
            //try
            //{
            //    ConnectionDatabase condb = new ConnectionDatabase();
            //    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
            //                                                { "@PermissionRoleID", this._PermissionRoleID},
            //                                                { "@LastUpdatedBy", this.LastUpdatedBy}
            //                                            };
            //    return condb.execStoreRI("UserProfilePermissionRole_Delete", paramarr);
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[3, 2]	{	{ "@UserProfileID", this._UserProfileID },
															{ "@PermissionRoleID", this._PermissionRoleID},
                                                            { "@LastUpdatedBy", this.LastUpdatedBy}
														};
                    return Convert.ToInt32(_con.ExecStoreRObject("UserProfilePermissionRole_Delete", paramarr));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}

