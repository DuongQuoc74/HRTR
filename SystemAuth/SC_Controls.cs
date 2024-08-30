namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_Controls")]
    public class SC_Controls : OBase
    {
        private int _ControlID;
        private string _ControlName;
        private bool _IsDenied;
        private bool _IsViewed;
        private bool _IsUpdated;
        public SC_Controls()
        {
            this._ControlName = "";
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
        public string ControlName
        {
            get
            {
                return this._ControlName;
            }
            set
            {
                this._ControlName = value;
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
        public static DataTable Search()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    return _con.GetDataTableByStore("SC_Controls_Search");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}

