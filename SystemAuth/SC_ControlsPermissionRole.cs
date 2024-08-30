namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_ControlsPermissionRole")]
    public class SC_ControlsPermissionRole : OBase
    {
        private int _ControlID;
        private int _PermissionRoleID;
        private bool _IsDenied;
        private bool _IsViewed;
        private bool _IsUpdated;
        public SC_ControlsPermissionRole()
        {
            
        }
        public int ControlID
        {
            get
            {
                return this._ControlID;
            }
            set
            {
                this._ControlID = value;
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
        public bool IsDenied
        {
            get
            {
                return this._IsDenied;
            }
            set
            {
                this._IsDenied = value;
            }
        }
        public bool IsViewed
        {
            get
            {
                return this._IsViewed;
            }
            set
            {
                this._IsViewed = value;
            }
        }
        public bool IsUpdated
        {
            get
            {
                return this._IsUpdated;
            }
            set
            {
                this._IsUpdated = value;
            }
        }
        public DataTable GetListControls()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2]	{	
                                                            { "@ControlID", this._ControlID }
														};
                    return _con.GetDataTableByStore("SC_Controls_Select_By_ControlID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}

