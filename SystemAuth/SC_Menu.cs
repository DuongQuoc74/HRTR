namespace SystemAuth
{
    using System;
    using System.Xml.Serialization;
    using System.Data;
    using eUtilities;

    [System.SerializableAttribute()]
    [System.Xml.Serialization.XmlRootAttribute("SC_Menu")]
    public class SC_Menu : OBase
    {
        private int _MenuID;
        private string _MenuName;
        public SC_Menu()
        {
            this._MenuName = "";
        }
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

        public DataTable GetListControls()
        {
            try
            {
                using (SystemAuthDBAccess _con = new SystemAuthDBAccess())
                {
                    object[,] paramarr = new object[1, 2]	{	
                                                            { "@MenuID", this._MenuID }
														};
                    return _con.GetDataTableByStore("SC_Controls_Select_By_MenuID", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}

